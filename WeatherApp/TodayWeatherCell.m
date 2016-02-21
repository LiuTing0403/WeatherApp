//
//  TodayWeatherCell.m
//  WeatherApp
//
//  Created by readygo on 15/12/16.
//  Copyright © 2015年 liuting. All rights reserved.
//

#import "TodayWeatherCell.h"

@interface TodayWeatherCell()
{
    UIView *snapView;
}

@end
@implementation TodayWeatherCell



- (void)awakeFromNib {
    _containerView.layer.cornerRadius = 20;
    
    
    _shadowView.layer.cornerRadius = 20;
    _shadowView.layer.shadowColor = [[UIColor grayColor]CGColor];
    _shadowView.layer.shadowOffset = CGSizeMake(5, 5);
    _shadowView.layer.shadowOpacity = 0.5;
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPressGuesture:)];
    [self.contentView addGestureRecognizer:longPress];
}

- (void)setUpcitynm:(NSString *)citynm {
    _citynm.text = citynm;
}

- (void)setUpweather:(NSString *)weather {
    _weather.text = weather;
}

- (void)setUptemp:(NSString *)temp_curr {
    _temp_curr.text = temp_curr;
}

- (void)handleLongPressGuesture:(UILongPressGestureRecognizer *)guesture {
    CGPoint startPoint;
    
    switch (guesture.state) {
        case UIGestureRecognizerStateBegan:
        {
            NSLog(@"longpress started");
            snapView = [_containerView snapshotViewAfterScreenUpdates:NO];
            snapView.frame = _containerView.frame;
            snapView.transform = CGAffineTransformMakeRotation(M_PI/30);
            startPoint = [guesture locationInView:self.contentView];

            [self.contentView addSubview:snapView];
            _shadowView.hidden = YES;
            _containerView.hidden = YES;
            
            
            break;
        }
        case UIGestureRecognizerStateChanged: {
            NSLog(@"longpress changed");
            CGPoint changedPoint = [guesture locationInView:self.contentView];
            snapView.center = changedPoint;

            
            break;
        }
        case UIGestureRecognizerStateEnded: {
            NSLog(@"longpress ended");
            CGPoint endedPoint = [guesture locationInView:self.contentView];
            if (endedPoint.x > self.contentView.bounds.size.width - 50 ) {
                if (_cellBlock) {
                    _cellBlock(YES, _cellIndex);

                }
            }
            else {
                if (_cellBlock) {
                    _cellBlock(NO, _cellIndex);
                    
                }
            }
            [snapView removeFromSuperview];
            _containerView.hidden = NO;
            _shadowView.hidden = NO;
        }
        default:
            break;
    }
    
    
    
}

@end
