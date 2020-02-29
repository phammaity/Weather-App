//
//  ViewController.m
//  WeatherBrisbane
//
//  Created by MacMini on 12/31/19.
//  Copyright © 2019 com.typham. All rights reserved.
//

#import "ViewController.h"
#import <React/RCTRootView.h>
#import "NativeAppViewController.h"
#import "WeatherInformationViewModel.h"

@interface ViewController ()<WeatherInformationDelegate>
@property (weak, nonatomic) IBOutlet UIButton *reactNativeButton;
@property (weak, nonatomic) IBOutlet UIButton *iosButton;
@end

@implementation ViewController {
    WeatherInformationViewModel *viewModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //init viewModel
    viewModel = [[WeatherInformationViewModel alloc]init];
    viewModel.delegate = self;
}

- (IBAction)clickReactNativeButton:(id)sender {
    [viewModel fetchData];
}

- (IBAction)clickiOSNativeButton:(id)sender {
    NativeAppViewController *vc = [[NativeAppViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
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
    //load react-native view
    NSURL *jsCodeLocation = [NSURL URLWithString:@"http://localhost:8081/index.bundle?platform=ios"];
    
    RCTRootView *rootView = [[RCTRootView alloc] initWithBundleURL: jsCodeLocation
                                                        moduleName: @"RNWeather"
                                                 initialProperties:@{@"data" : data}
                                                     launchOptions: nil];
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view = rootView;
    [self presentViewController:vc animated:YES completion:nil];
}

@end
