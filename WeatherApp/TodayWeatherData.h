//
//  TodayWeatherData.h
//  WeatherApp
//
//  Created by readygo on 15/12/17.
//  Copyright © 2015年 liuting. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TodayWeatherData : NSObject

@property (nonatomic, assign) int weaid;
@property (nonatomic, strong) NSString *week;
@property (nonatomic, strong) NSString *citynm;
@property (nonatomic, strong) NSString *temperature;
@property (nonatomic, strong) NSString *temperature_curr;
@property (nonatomic, strong) NSString *weather;

@end
