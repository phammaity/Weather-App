//
//  WeatherInformationViewModel.h
//  Yesterday’s weather Brisbane.
//
//  Created by MacMini on 12/30/19.
//  Copyright © 2019 com.typham. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol WeatherInformationDelegate<NSObject>
@optional
- (void)dataLoadedSuccess;
- (void)dataLoadedSuccess:(NSMutableArray *_Nullable)data;
- (void)dataLoadedError:(NSString *_Nonnull)error;

@end

NS_ASSUME_NONNULL_BEGIN



@interface WeatherInformationViewModel : NSObject
@property (nonatomic, weak) id<WeatherInformationDelegate> delegate;

- (NSInteger)numberOfWeatherHistory;
- (NSString *)getStateNameAtIndex:(int)index;
- (NSString *)getStateIconAtIndex:(int)index;
- (NSString *)getHumidityAtIndex:(int)index;
- (NSString *)getMinTempAtIndex:(int)index;
- (NSString *)getMaxTempAtIndex:(int)index;
- (NSString *)getCreatedTimeAtIndex:(int)index;

- (void)fetchData;
@end

NS_ASSUME_NONNULL_END
