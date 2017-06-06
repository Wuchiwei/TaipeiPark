//
//  AppDelegate.m
//  TaipeiPark
//
//  Created by WU CHIH WEI on 2017/6/3.
//  Copyright © 2017年 WU CHIH WEI. All rights reserved.
//

#import "AppDelegate.h"
#import "IndicatorViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] init];
    
    self.window.frame = [UIScreen mainScreen].bounds;

    IndicatorViewController *controller = [[IndicatorViewController alloc] init];
    
    [self.window setRootViewController: controller];
    
    [self.window makeKeyAndVisible];
    
    return YES;
}
@end
