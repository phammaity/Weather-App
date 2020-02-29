//
//  WeatherInformationViewModel.m
//  Yesterday’s weather Brisbane.
//
//  Created by MacMini on 12/30/19.
//  Copyright © 2019 com.typham. All rights reserved.
//

#import "WeatherInformationViewModel.h"
#import "WeatherInformation.h"

@implementation WeatherInformationViewModel {
    NSArray<WeatherInformation*>*weatherInfos;
    NSMutableArray *jsonData;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        weatherInfos = [NSMutableArray new];
    }
    return self;
}

// MARK:custom data
- (NSInteger)numberOfWeatherHistory {
    return [weatherInfos count];
}

- (WeatherInformation *)getWeatherInfoAtIndex:(int)index {
    return [weatherInfos objectAtIndex:index];
}

- (NSString *)getStateNameAtIndex:(int)index {
    WeatherInformation *info = [self getWeatherInfoAtIndex:index];
    if(info){
        return info.stateName;
    }
    return @"";
}

- (NSString *)getStateIconAtIndex:(int)index {
    WeatherInformation *info = [self getWeatherInfoAtIndex:index];
    if(info){
        return info.stateImageAbbr;
    }
    return @"";
}

- (NSString *)getCreatedTimeAtIndex:(int)index {
    WeatherInformation *info = [self getWeatherInfoAtIndex:index];
    if(info){
        NSDate *date = info.createdDate;
        if(date){
            NSDateFormatter *formatterUI = [[NSDateFormatter alloc]init];
            [formatterUI setDateFormat:@"yyyy/MM/dd \n HH:mm"];
            return [formatterUI stringFromDate:date];
        }
    }
    return @"";
}

- (NSString *)getMaxTempAtIndex:(int)index {
    WeatherInformation *info = [self getWeatherInfoAtIndex:index];
    if(info){
        return [NSString stringWithFormat:@"%0.f°C",info.maxTemp];
    }
    return @"";
}

- (NSString *)getMinTempAtIndex:(int)index {
    WeatherInformation *info = [self getWeatherInfoAtIndex:index];
    if(info){
        return [NSString stringWithFormat:@"%0.f°C",info.minTemp];
    }
    return @"";
}

- (NSString *)getHumidityAtIndex:(int)index {
    WeatherInformation *info = [self getWeatherInfoAtIndex:index];
    if(info){
        return [NSString stringWithFormat:@"%d%%",info.humidity];
    }
    return @"";
}

- (NSString *)yesterdayString {
    NSDate *yesterday = [NSDate dateWithTimeIntervalSinceNow: -(60.0f*60.0f*24.0f)];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy/MM/dd"];
    return [formatter stringFromDate:yesterday];
}

- (void)setWeatherInfos:(NSMutableArray *)array{
    NSMutableArray *data = [NSMutableArray new];
    for (NSDictionary *dic in array) {
        WeatherInformation* info = [[WeatherInformation alloc]initWithJSON:dic];
        [data addObject:info];
    }
    weatherInfos = data;
}

// MARK:handle callback
- (void)handleCallBackWithData:(NSDictionary*)dataJSON {
    NSMutableArray *data = [NSMutableArray new];
    for (NSDictionary *dic in dataJSON) {
        [data addObject:dic];
    }
    [self setWeatherInfos:data];
    __weak WeatherInformationViewModel *weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([weakSelf.delegate respondsToSelector:@selector(dataLoadedSuccess:)]) {
            [weakSelf.delegate dataLoadedSuccess: data];
        }
    });
}

- (void)handleCallBackWithError:(NSError *)error {
    __weak WeatherInformationViewModel *weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([weakSelf.delegate respondsToSelector:@selector(dataLoadedError:)]) {
            [weakSelf.delegate dataLoadedError:@"Fetch data error"];
        }
    });
}

// MARK: fetch data
- (void)fetchData {
    int woeid = 1100661;//Where On Earth ID - Brisbane
    NSString *yesterday = [self yesterdayString];
    NSString *urlString = [[NSString alloc]initWithFormat:@"https://www.metaweather.com/api/location/%d/%@/",woeid,yesterday];
    NSURL *url = [[NSURL alloc]initWithString:urlString];
    
    if(url == nil) {
        return;
    }
    
    [[NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(error) {
            [self handleCallBackWithError:error];
            return;
        }
        
        NSError *errJsonParse;
        NSDictionary *dataJSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&errJsonParse];
        
        
        if(errJsonParse){
            NSLog(@"Failed to parsing JSON: %@", errJsonParse);
            [self handleCallBackWithError:errJsonParse];
            return;
        }
        //handle call back
        [self handleCallBackWithData:dataJSON];
        
    }]resume];
}

@end
