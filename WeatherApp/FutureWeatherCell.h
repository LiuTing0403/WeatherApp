//
//  FutureWeatherCell.h
//  WeatherApp
//
//  Created by readygo on 15/12/15.
//  Copyright © 2015年 liuting. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FutureWeatherCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *weekLabel;

@property (strong, nonatomic) IBOutlet UILabel *weatherLabel;

@property (strong, nonatomic) IBOutlet UILabel *temp_highLabel;

@property (strong, nonatomic) IBOutlet UILabel *temp_lowLabel;

- (void)setUpweekLabel:(NSString *)weekday;
- (void)setUpweatherLabel:(NSString *)weather;
- (void)setUptemp_highLabel:(NSString*)temp_high;
- (void)setUptemp_lowLabel:(NSString *)temp_low;



@end
