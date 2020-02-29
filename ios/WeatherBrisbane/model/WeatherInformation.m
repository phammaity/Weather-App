//
//  WeatherInformation.m
//  Yesterday’s weather Brisbane.
//
//  Created by MacMini on 12/30/19.
//  Copyright © 2019 com.typham. All rights reserved.
//

#import "WeatherInformation.h"

@implementation WeatherInformation

-(id)initWithJSON:(NSDictionary *)json
{
     self = [super init];
     if (self) {
         self.weatherId = [json[@"id"]intValue];;
         self.stateName = json[@"weather_state_name"];
         self.stateImageAbbr = json[@"weather_state_abbr"];
         self.humidity = [json[@"humidity"] intValue];
         self.minTemp = [json[@"min_temp"] floatValue];
         self.maxTemp = [json[@"max_temp"] floatValue];
         
         NSString *dateString = json[@"created"];
         if(dateString) {
             NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
             [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
             [formatter setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"en_US_POSIX"]];
             self.createdDate = [formatter dateFromString:dateString];
         }
     }
     return self;
}


@end
