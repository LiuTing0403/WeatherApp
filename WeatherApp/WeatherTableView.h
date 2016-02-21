//
//  WeatherTableView.h
//  WeatherApp
//
//  Created by readygo on 15/12/14.
//  Copyright © 2015年 liuting. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeatherTableView : UITableViewController

@property (nonatomic, strong)NSArray *futureData;
@property (nonatomic, strong)NSDictionary *futureWeatherData;
@property (strong, nonatomic) NSString *citynm;
@property (strong, nonatomic)NSDictionary *todayWeatherData;

@end
