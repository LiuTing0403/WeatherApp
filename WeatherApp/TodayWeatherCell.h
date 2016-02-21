//
//  TodayWeatherCell.h
//  WeatherApp
//
//  Created by readygo on 15/12/16.
//  Copyright © 2015年 liuting. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^handleGuestureEndedBlock)(BOOL isDelete, NSIndexPath *index);

@interface TodayWeatherCell : UITableViewCell


@property (strong, nonatomic) IBOutlet UILabel *citynm;

@property (strong, nonatomic) IBOutlet UILabel *weather;

@property (strong, nonatomic) IBOutlet UILabel *temp_curr;

@property (strong, nonatomic) IBOutlet UIView *shadowView;

@property (strong, nonatomic) IBOutlet UIView *containerView;

@property (nonatomic, copy) handleGuestureEndedBlock cellBlock;
@property (nonatomic, strong) NSIndexPath *cellIndex;

- (void)setUpcitynm:(NSString *)citynm;
- (void)setUpweather:(NSString *)weather;
- (void)setUptemp:(NSString *)temp_curr;


@end
