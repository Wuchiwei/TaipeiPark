//
//  TaipeiParks.m
//  TaipeiPark
//
//  Created by WU CHIH WEI on 2017/6/3.
//  Copyright © 2017年 WU CHIH WEI. All rights reserved.
//

#import "TaipeiParks.h"

@implementation TaipeiParks

-(NSInteger)numberOfSectionInTableView {
    return 1;
}

-(NSInteger)numberOfRowInSection:(NSInteger)section {
    return 5;
}

-(id) objectForCellAtRow:(NSInteger)row section:(NSInteger) section{
    return self;
}

-(void)requestParks {
    
    TaipeiParkNetworkHandler* networkHandler = [TaipeiParkNetworkHandler sharedInstance];

    [networkHandler makeRequestWithMethod:GET andEndPoint:limitWithOffset];
}

@end
