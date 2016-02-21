//
//  WeatherTableView.m
//  WeatherApp
//
//  Created by readygo on 15/12/14.
//  Copyright © 2015年 liuting. All rights reserved.
//

#import "WeatherTableView.h"
#import "FutureWeatherCell.h"
#import "HTTPKit.h"
#import "Const.h"
#import "URLString.h"

@interface WeatherTableView ()

@property (strong, nonatomic) IBOutlet UILabel *cityLabel;

@property (strong, nonatomic) IBOutlet UILabel *weatherLabel;

@property (strong, nonatomic) IBOutlet UILabel *tempLabel;

@property (strong, nonatomic) UIImageView *imageSun;


@property (strong, nonatomic) NSString *encodedCitynm;

@property (nonatomic, strong) UIGravityBehavior *gravity;
@property (nonatomic, strong) UIDynamicAnimator *animator;
@end

@implementation WeatherTableView


- (void)viewDidLoad {
    [super viewDidLoad];
    _encodedCitynm = [_citynm stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    [self getFutureData];
    [self getTodayData];
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(getTodayData) forControlEvents:UIControlEventValueChanged];
    
    [self setUpAnimation];
}

#pragma mark - internal methods
- (void)getFutureData {

    NSString *futureURL = [[[URLString alloc]initWithCitynm:_citynm
                           ]generateFutureURL];
    [[HTTPKit NetworKit] getHTTPResponse:futureURL completion:^(id responseObject) {
        _futureData = [responseObject objectForKey:result];
        [self.tableView reloadData];

    }];
}

- (void)getTodayData {
    NSString *todayURL = [[[URLString alloc]initWithCitynm:_citynm
                           ]generateTodayURL];
    [[HTTPKit NetworKit] getHTTPResponse:todayURL completion:^(id responseObject) {
        _todayWeatherData = [responseObject objectForKey:result];
        
        NSLog(@"%@", responseObject);
        _cityLabel.text = [_todayWeatherData objectForKey:citynm];
        _weatherLabel.text = [_todayWeatherData objectForKey:weather];
        _tempLabel.text = [_todayWeatherData objectForKey:temp_curr];
        [self.refreshControl endRefreshing];
        
    }];
}

- (void)setUpAnimation {
    
    _imageSun = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon-sun"]];
    _imageSun.frame = CGRectMake(0, 0, 60, 60);
    [self.tableView addSubview:_imageSun];
    _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.tableView];
    _gravity = [[UIGravityBehavior alloc]initWithItems:@[_imageSun]];
    [_animator addBehavior:_gravity];
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _futureData.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FutureWeatherCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
//    
    _futureWeatherData = [_futureData objectAtIndex:indexPath.row];
    

    [cell setUptemp_lowLabel:[_futureWeatherData objectForKey:temp_low]];
    [cell setUptemp_highLabel:[_futureWeatherData objectForKey:temp_high]];
    [cell setUpweekLabel:[_futureWeatherData objectForKey:week]];
    [cell setUpweatherLabel:[_futureWeatherData objectForKey:weather]];
    
    return cell;
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
