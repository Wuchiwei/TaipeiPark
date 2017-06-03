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

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] init];
    
    self.window.frame = [UIScreen mainScreen].bounds;
    
    id<TableViewDataFetchProtocol> dataModel = [[TestModel alloc] init];
    
    [self.window setRootViewController:[[TableViewDataFetchController alloc] initWithDataModel:dataModel]];
    
    [self.window makeKeyAndVisible];
    
    return YES;
}
@end
