//
//  NativeAppViewController.m
//  WeatherBrisbane
//
//  Created by MacMini on 12/31/19.
//  Copyright © 2019 com.typham. All rights reserved.
//

#import "NativeAppViewController.h"
#import "WeatherInformation.h"
#import "WeatherInformationViewModel.h"
#import "WeatherInfoTableViewCell.h"

@interface NativeAppViewController ()<WeatherInformationDelegate, UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation NativeAppViewController{
    WeatherInformationViewModel *viewModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //init viewModel
    viewModel = [[WeatherInformationViewModel alloc]init];
    viewModel.delegate = self;
    
    //register cell
    [self.tableView registerNib:[UINib nibWithNibName:@"WeatherInfoTableViewCell" bundle:nil] forCellReuseIdentifier:@"WeatherInfoTableViewCell"];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [viewModel fetchData];
}

// MARK:WeatherInformationDelegate
- (void)dataLoadedError:(NSString *)error {
    //show error alert
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Alert" message:error preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)dataLoadedSuccess:(NSMutableArray *)data {
    //reload data after loaded
    [self.tableView reloadData];
}

// MARK:UITableViewDelegate

// MARK:UITableViewDatasource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WeatherInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WeatherInfoTableViewCell"];
    
    cell.stateName.text = [viewModel getStateNameAtIndex:(int)indexPath.row];
    cell.stateIcon.image = [UIImage imageNamed:[viewModel getStateIconAtIndex:(int)indexPath.row]];
    cell.createdTime.text = [viewModel getCreatedTimeAtIndex:(int)indexPath.row];
    cell.maxTemp.text = [viewModel getMaxTempAtIndex:(int)indexPath.row];
    cell.minTemp.text = [viewModel getMinTempAtIndex:(int)indexPath.row];
    cell.humidity.text = [viewModel getHumidityAtIndex:(int)indexPath.row];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [viewModel numberOfWeatherHistory];
}

@end
