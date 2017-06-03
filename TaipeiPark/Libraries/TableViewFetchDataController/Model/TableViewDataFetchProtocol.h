//
//  TableViewDataFetchProtocol.h
//  TaipeiPark
//
//  Created by WU CHIH WEI on 2017/6/3.
//  Copyright © 2017年 WU CHIH WEI. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TableViewDataFetchProtocol <NSObject>

@required
-(NSInteger)numberOfSectionInTableView;
-(NSInteger)numberOfRowInSection:(NSInteger) section;
-(id) objectForCellAtRow:(NSInteger)row section:(NSInteger) section;

@end
