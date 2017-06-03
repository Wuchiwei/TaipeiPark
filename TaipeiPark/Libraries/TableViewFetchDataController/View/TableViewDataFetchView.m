//
//  TableViewDataFetchView.m
//  TaipeiPark
//
//  Created by WU CHIH WEI on 2017/6/3.
//  Copyright © 2017年 WU CHIH WEI. All rights reserved.
//

#import "TableViewDataFetchView.h"

@implementation TableViewDataFetchView

-(instancetype)init{
    
    self = [super init];
    
    if (self) {
        [self setUp];
    }
    
    return self;
}

-(void)setUp {
    self.backgroundColor = [UIColor redColor];
}

@end
