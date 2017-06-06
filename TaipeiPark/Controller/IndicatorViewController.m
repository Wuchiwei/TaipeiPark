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

@interface IndicatorViewController ()

@property (strong, nonatomic) UIActivityIndicatorView* indicatorView;
@property (strong, nonatomic) ParkTableViewController *controller;

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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUp];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
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





















