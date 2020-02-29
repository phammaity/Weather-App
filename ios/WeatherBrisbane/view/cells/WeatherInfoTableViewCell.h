//
//  WeatherInfoTableViewCell.h
//  Yesterday’s weather Brisbane.
//
//  Created by MacMini on 12/30/19.
//  Copyright © 2019 com.typham. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WeatherInfoTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *createdTime;
@property (weak, nonatomic) IBOutlet UIImageView *stateIcon;
@property (weak, nonatomic) IBOutlet UILabel *stateName;
@property (weak, nonatomic) IBOutlet UILabel *maxTemp;
@property (weak, nonatomic) IBOutlet UILabel *minTemp;
@property (weak, nonatomic) IBOutlet UILabel *humidity;

@end

NS_ASSUME_NONNULL_END
