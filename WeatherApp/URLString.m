//
//  URLString.m
//  WeatherApp
//
//  Created by readygo on 15/12/17.
//  Copyright © 2015年 liuting. All rights reserved.
//

#import "URLString.h"

@implementation URLString

static NSString * const futureURLLeading = @"http://api.k780.com:88/?app=weather.future&weaid=";

static NSString * const appkeyAndSign = @"&&appkey=16842&sign=16351404d0f7186d6cc901716c1a5e1b&format=json";

static NSString * const todayURLLeading = @"http://api.k780.com:88/?app=weather.today&weaid=";


- (instancetype)initWithCitynm:(NSString *)citynm {
    self = [super init];
    if (self) {
        _citynm = citynm;
    }
    return self;
}

- (NSString *)generateFutureURL{
    NSString *encodedCitynm = [_citynm stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *futureURL = [[futureURLLeading stringByAppendingString:encodedCitynm]stringByAppendingString:appkeyAndSign];
    
    return futureURL;
}

- (NSString *)generateTodayURL{
    NSString *encodedCitynm = [_citynm stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *todayURL = [[todayURLLeading stringByAppendingString:encodedCitynm]stringByAppendingString:appkeyAndSign];
    
    return todayURL;
}

@end
