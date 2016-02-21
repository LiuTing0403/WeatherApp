//
//  FutureWeatherCell.m
//  WeatherApp
//
//  Created by readygo on 15/12/15.
//  Copyright © 2015年 liuting. All rights reserved.
//

#import "FutureWeatherCell.h"

@implementation FutureWeatherCell

- (void)setUpweekLabel:(NSString *)weekday {
    _weekLabel.text = weekday;
}
- (void)setUpweatherLabel:(NSString *)weather {
    _weatherLabel.text = weather;
}
- (void)setUptemp_highLabel:(NSString *)temp_high {
    _temp_highLabel.text = temp_high;
}
- (void)setUptemp_lowLabel:(NSString *)temp_low {
    _temp_lowLabel.text = temp_low;
}


@end
