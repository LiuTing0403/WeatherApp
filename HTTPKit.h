//
//  HTTPKit.h
//  WeatherApp
//
//  Created by readygo on 15/12/15.
//  Copyright © 2015年 liuting. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HTTPKit:NSObject
+ (HTTPKit *)NetworKit;
- (void)getHTTPResponse:(NSString *)url completion: (void(^)(id responseObject))completion;


@end
