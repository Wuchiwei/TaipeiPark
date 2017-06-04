//
//  ParkTableViewController.h
//  TaipeiPark
//
//  Created by WU CHIH WEI on 2017/6/3.
//  Copyright © 2017年 WU CHIH WEI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TableViewDataFetchProtocol.h"
#import "ParkTableViewDataModelProtocol.h"

@interface ParkTableViewController : UIViewController

-(instancetype)initWithDataModel: (id<ParkTableViewDataModelProtocol>) dataModel;

@end

