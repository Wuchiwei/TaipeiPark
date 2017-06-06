//
//  IndicatorViewController.m
//  TaipeiPark
//
//  Created by WU CHIH WEI on 2017/6/6.
//  Copyright © 2017年 WU CHIH WEI. All rights reserved.
//

#import "IndicatorViewController.h"
#import "ParkTableViewController.h"
#import "TaipeiParks.h"
#import "AppDelegate.h"
#import "Reachability.h"

@interface IndicatorViewController ()

@property (strong, nonatomic) UIActivityIndicatorView* indicatorView;
@property (strong, nonatomic) ParkTableViewController *controller;
@property (strong, nonatomic) NSTimer *timer;

@end

@implementation IndicatorViewController

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        
        self.indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    }
    
    return self;
}

- (void)dealloc {
    
    [self.timer invalidate];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUp];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self checkInternetStatus];
}

-(void)checkInternetStatus {
    
    if (self.timer) {
        
        [self.timer invalidate];
    }
    
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    
    if (networkStatus == NotReachable) {
    
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:@"No Internet connect" preferredStyle:UIAlertControllerStyleAlert];
        
        __weak IndicatorViewController *weakSelf = self;
        
        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            weakSelf.timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(checkInternetStatus) userInfo:nil repeats:true];
            
            [weakSelf.indicatorView startAnimating];
        }];
        
        [self.indicatorView stopAnimating];
        
        [alertController addAction:alertAction];
        
        [self presentViewController:alertController animated:true completion:nil];
    
    } else {
    
        [self changeRootViewController];
    }
}

-(void)changeRootViewController {
    
    id<ParkTableViewDataModelProtocol> dataModel = [[TaipeiParks alloc] init];
    
    self.controller = [[ParkTableViewController alloc] initWithDataModel:dataModel];
    
    __weak ParkTableViewController* weakController = self.controller;
    
    self.controller.loadDataCompletion = ^{
        
        AppDelegate *appDelegate = (AppDelegate*) [UIApplication sharedApplication].delegate;
        
        UIWindow *window = appDelegate.window;
        
        [window setRootViewController:weakController];
    };
    
    [self.controller loadData];
}

-(void) setUp {
    
    self.view.backgroundColor = [UIColor whiteColor];

    [self setIndicatorView];
}

-(void) setIndicatorView {
    
    self.indicatorView.color = [UIColor grayColor];
    
    [self.view addSubview:self.indicatorView];
    
    self.indicatorView.translatesAutoresizingMaskIntoConstraints = false;
 
    NSLayoutConstraint *top = [self.indicatorView.topAnchor constraintEqualToAnchor:self.topLayoutGuide.bottomAnchor];
    
    NSLayoutConstraint *leading = [self.indicatorView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor];
    
    NSLayoutConstraint *trailing = [self.indicatorView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor];
    
    NSLayoutConstraint *bottom = [self.indicatorView.bottomAnchor constraintEqualToAnchor:self.bottomLayoutGuide.topAnchor];
    
    [self.view addConstraints:@[top, leading, trailing, bottom]];
    
    [self.indicatorView startAnimating];
}

@end





















