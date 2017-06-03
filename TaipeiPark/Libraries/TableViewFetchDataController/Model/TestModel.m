//
//  TestModel.m
//  TaipeiPark
//
//  Created by WU CHIH WEI on 2017/6/3.
//  Copyright © 2017年 WU CHIH WEI. All rights reserved.
//

#import "TestModel.h"
@implementation TestModel

-(NSInteger)numberOfSectionInTableView {
    return 1;
}

-(NSInteger)numberOfRowInSection:(NSInteger) section {
    return 1;
}

-(id) objectiveForCellAtRow:(NSInteger)row section:(NSInteger) section {
    return self;
}

@end
