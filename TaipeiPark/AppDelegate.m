//
//  AppDelegate.m
//  TaipeiPark
//
//  Created by WU CHIH WEI on 2017/6/3.
//  Copyright © 2017年 WU CHIH WEI. All rights reserved.
//

#import "AppDelegate.h"
#import "TableViewDataFetchController.h"
#import "TestModel.h"
#import "DataFetchTableViewCell.h"

#import "ParkTableViewController.h"
#import "ParkTableViewDataModel.h"
#import "TaipeiParks.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] init];
    
    self.window.frame = [UIScreen mainScreen].bounds;
    
    id<ParkTableViewDataModel> dataModel = [[TaipeiParks alloc] init];
    
    ParkTableViewController *controller = [[ParkTableViewController alloc] initWithDataModel:dataModel];

    [self.window setRootViewController: controller];
    
    [self.window makeKeyAndVisible];
    
    return YES;
}
@end
