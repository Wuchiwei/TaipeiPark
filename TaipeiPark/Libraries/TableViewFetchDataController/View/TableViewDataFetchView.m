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
    
    self.tableView = [[UITableView alloc] initWithFrame: CGRectZero];
    
    UITableView* myTableView = self.tableView;
    
    myTableView.delegate = self.delegate;
    
    myTableView.dataSource = self.delegate;
    
    myTableView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addSubview:myTableView];
    
    NSLayoutConstraint* top = [myTableView.topAnchor constraintEqualToAnchor: self.topAnchor];
    
    NSLayoutConstraint* leading = [myTableView.leadingAnchor constraintEqualToAnchor: self.leadingAnchor];
    
    NSLayoutConstraint* trailing = [myTableView.trailingAnchor constraintEqualToAnchor: self.trailingAnchor];
    
    NSLayoutConstraint* bottom = [myTableView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor];
    
    [self addConstraints:@[top, leading, trailing, bottom]];
}

-(void) cellIdentifier:(NSString *)identifier {
    
    UINib* nib = [UINib nibWithNibName:identifier bundle:nil];
    
    [self.tableView registerNib:nib forCellReuseIdentifier:identifier];
}

@end
