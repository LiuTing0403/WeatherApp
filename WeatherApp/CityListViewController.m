//
//  CityListViewController.m
//  WeatherApp
//
//  Created by readygo on 15/12/15.
//  Copyright © 2015年 liuting. All rights reserved.
//

#import "CityListViewController.h"
#import "WeatherTableView.h"
#import "TodayWeatherCell.h"
#import "HTTPKit.h"
#import "Const.h"
#import "URLString.h"

@interface CityListViewController ()

@property (nonatomic, strong) NSMutableArray *cityList;
@property (nonatomic, strong) NSMutableArray *allCityData;




- (IBAction)addCity:(id)sender;

@end

@implementation CityListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _cityList = [NSMutableArray new];  
    _allCityData = [NSMutableArray new];
    //读取保存的数据
    [self readFromNSUserDefault];
   
    if (_cityList.count != 0) {
        [self getallCityDataToday];
        NSLog(@"%@", _cityList);
    }
    
    
    [self.navigationItem setTitle:[self getCurrentDate]];
    self.refreshControl = [UIRefreshControl new];
    [self.refreshControl addTarget:self action:@selector(getallCityDataToday) forControlEvents:UIControlEventValueChanged];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _allCityData.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TodayWeatherCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cityListCell" forIndexPath:indexPath];
    NSDictionary *cityData = [_allCityData objectAtIndex:indexPath.row];
    [cell setUpcitynm:[cityData objectForKey:citynm]];
    [cell setUpweather:[cityData objectForKey:weather]];
    [cell setUptemp:[cityData objectForKey:temp_curr]];
    
    cell.cellIndex = indexPath;
    cell.cellBlock = ^(BOOL isDelete, NSIndexPath *index){
        if (isDelete) {
          
            
            [_allCityData removeObjectAtIndex:index.row];
            [_cityList removeObjectAtIndex:index.row];
            [self saveToNSUserDefault];
        
            
            [self.tableView deleteRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationRight];
           
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.tableView reloadData];});
        }

    };
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    WeatherTableView *cityWeatherDetail = [self.storyboard instantiateViewControllerWithIdentifier:@"cityWeatherDetail"];
    cityWeatherDetail.citynm = [_allCityData[indexPath.row] objectForKey:citynm];
    
    
    [self.navigationController pushViewController:cityWeatherDetail animated:YES];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [self saveToNSUserDefault];
}

#pragma mark - actions
- (IBAction)addCity:(id)sender {
    NSLog(@"button clicked");
    UIAlertController *alertView =[UIAlertController alertControllerWithTitle:@"添加城市" message:@"请输入城市名称" preferredStyle: UIAlertControllerStyleAlert];
    [alertView addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"城市名";
    }];
    
    [alertView addAction:[UIAlertAction actionWithTitle:@"添加" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (![alertView.textFields[0].text  isEqual: @""]) {

            [_cityList addObject:alertView.textFields[0].text];
 //           [self getOneCityDataToday:alertView.textFields[0].text];
            [self getallCityDataToday];
        }
    }]];
    
    [alertView addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    
    [self presentViewController:alertView animated:YES completion:nil];

}

#pragma mark - methods

- (void)getallCityDataToday{
    [_allCityData removeAllObjects];
    for (NSString *citynm in _cityList) {
        [self getOneCityDataToday:citynm];
    }
    [self.refreshControl endRefreshing];
}
//从网络请求某个城市的信息
- (void)getOneCityDataToday:(NSString *)citynm {


    NSString *todayURL = [[[URLString alloc]initWithCitynm:citynm
                                 ]generateTodayURL];
    
    [[HTTPKit NetworKit] getHTTPResponse:todayURL completion:^(id responseObject) {
            
        NSLog(@"%@", responseObject);
        NSDictionary *cityData = [responseObject objectForKey:result];
        [_allCityData addObject:cityData];
        
        [self.tableView reloadData];
            

    }];

}

- (NSString *)getCurrentDate {
    NSString *currentDate;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    currentDate = [dateFormatter stringFromDate:[NSDate date]];
    return currentDate;
}


#pragma mark - userdefault methods
//保存城市列表，只保存城市名称，不保存其他数据
- (void)saveToNSUserDefault {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [_cityList removeAllObjects];
    //由于网络请求速度的问题，_allCityData的城市顺序有所变化，要保存的cityList需要从_allCityData中重新加载，此处存在问题
    for (NSDictionary *cityData in _allCityData) {
        [_cityList addObject:[cityData objectForKey:citynm]];
    }
    [userDefault setObject:_cityList forKey:@"cityList"];

}
//读取城市列表
- (void)readFromNSUserDefault {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSMutableArray *tempCityList = [NSMutableArray new];
    tempCityList = [userDefault objectForKey:@"cityList"];
    //如果userdefault里面保存的数据不为空，则添加到_cityList里
    if (tempCityList != nil) {
        [_cityList addObjectsFromArray:tempCityList];
    }
}


#pragma mark - TableViewEditing

//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
//    return YES;
//}


//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        [_allCityData removeObjectAtIndex:indexPath.row];
//        [_cityList removeObjectAtIndex:indexPath.row];
//        [self saveToNSUserDefault];
//        //删除列表某项时，此方法已刷新tableview，不用reloadData；
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//        
//    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
//
//    }   
//}


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
