//
//  TableViewDataFetchController.h
//  TaipeiPark
//
//  Created by WU CHIH WEI on 2017/6/3.
//  Copyright © 2017年 WU CHIH WEI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TableViewDataFetchProtocol.h"

@interface TableViewDataFetchController : UIViewController

-(instancetype)initWithDataModel: (id<TableViewDataFetchProtocol>) dataModel;

@end
