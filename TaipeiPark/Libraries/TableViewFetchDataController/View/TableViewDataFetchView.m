//
//  TableViewDataFetchView.m
//  TaipeiPark
//
//  Created by WU CHIH WEI on 2017/6/3.
//  Copyright © 2017年 WU CHIH WEI. All rights reserved.
//

#import "TableViewDataFetchView.h"

@implementation TableViewDataFetchView

-(instancetype)initWithDelegate: (id<UITableViewDelegate,UITableViewDataSource>) delegate {
    
    self = [super init];
    
    if (self) {
        self.delegate = delegate;
        [self setUp];
    }
    
    return self;
}

-(void)setUp {
    
    UITableView* tableView = [[UITableView alloc] initWithFrame: CGRectZero];
    
    tableView.delegate = self.delegate;
    tableView.dataSource = self.delegate;
    
    tableView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:tableView];
    NSLayoutConstraint* top = [tableView.topAnchor constraintEqualToAnchor: self.topAnchor];
    NSLayoutConstraint* leading = [tableView.leadingAnchor constraintEqualToAnchor: self.leadingAnchor];
    NSLayoutConstraint* trailing = [tableView.trailingAnchor constraintEqualToAnchor: self.trailingAnchor];
    NSLayoutConstraint* bottom = [tableView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor];
    [self addConstraints:@[top, leading, trailing, bottom]];
}

@end
