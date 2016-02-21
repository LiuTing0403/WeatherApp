//
//  URLString.h
//  WeatherApp
//
//  Created by readygo on 15/12/17.
//  Copyright © 2015年 liuting. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface URLString : NSObject

@property (nonatomic, strong) NSString *citynm;

- (instancetype)initWithCitynm : (NSString *)citynm;

- (NSString *)generateFutureURL;
- (NSString *)generateTodayURL;

@end
