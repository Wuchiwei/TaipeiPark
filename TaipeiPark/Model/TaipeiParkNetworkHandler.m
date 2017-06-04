//
//  TaipeiParkNetworkHandler.m
//  TaipeiPark
//
//  Created by WU CHIH WEI on 2017/6/4.
//  Copyright © 2017年 WU CHIH WEI. All rights reserved.
//

#import "TaipeiParkNetworkHandler.h"

@implementation TaipeiParkNetworkHandler

+(instancetype)sharedInstance {
    
    static TaipeiParkNetworkHandler *instance = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        instance = [[TaipeiParkNetworkHandler alloc] init];
    });

    return instance;
}
@end
