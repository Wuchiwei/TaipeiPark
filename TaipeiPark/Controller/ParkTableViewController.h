//
//  ParkTableViewController.h
//  TaipeiPark
//
//  Created by WU CHIH WEI on 2017/6/5.
//  Copyright © 2017年 WU CHIH WEI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ParkTableViewDataModelProtocol.h"

@interface ParkTableViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, copy, nullable) void(^loadDataCompletion)();

-(instancetype)initWithDataModel: (id<ParkTableViewDataModelProtocol>) dataModel;
-(void) loadData;

@end
