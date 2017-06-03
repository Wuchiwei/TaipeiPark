//
//  TableViewDataFetchView.h
//  TaipeiPark
//
//  Created by WU CHIH WEI on 2017/6/3.
//  Copyright © 2017年 WU CHIH WEI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewDataFetchView : UIView

@property (weak,nonatomic) id<UITableViewDataSource, UITableViewDelegate> delegate;
@property (strong, nonatomic) UITableView* tableView;

-(instancetype)initWithDelegate: (id <UITableViewDelegate, UITableViewDataSource>) delegate;
-(void)cellIdentifier: (NSString*) identifier;

@end
