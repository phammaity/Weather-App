//
//  WeatherInformation.h
//  Yesterday’s weather Brisbane.
//
//  Created by MacMini on 12/30/19.
//  Copyright © 2019 com.typham. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WeatherInformation : NSObject

@property (nonatomic, assign) int weatherId;
@property (strong, nonatomic) NSString *stateName;
@property (strong, nonatomic) NSString *stateImageAbbr;
@property (strong, nonatomic) NSDate *createdDate;
@property (nonatomic, assign) int humidity;
@property (nonatomic, assign) float minTemp;
@property (nonatomic, assign) float maxTemp;


-(id)initWithJSON:(NSDictionary *)json;
@end

NS_ASSUME_NONNULL_END
