//
//  HTTPKit.m
//  WeatherApp
//
//  Created by readygo on 15/12/15.
//  Copyright © 2015年 liuting. All rights reserved.
//

#import "HTTPKit.h"
#import "AFNetworking.h"

@implementation HTTPKit

+ (HTTPKit *)NetworKit {
    static HTTPKit *sharedHTTPKitInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedHTTPKitInstance = [[self alloc]init];
    });
    
    return sharedHTTPKitInstance;
}

- (void)getHTTPResponse:(NSString *)url completion:(void (^)(id))completion{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
 
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        completion(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"get error : %@", error);
    }];

}




@end
