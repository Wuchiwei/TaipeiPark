//
//  TableViewDataFetchController.m
//  TaipeiPark
//
//  Created by WU CHIH WEI on 2017/6/3.
//  Copyright © 2017年 WU CHIH WEI. All rights reserved.
//

#import "TableViewDataFetchController.h"
#import "TableViewDataFetchView.h"

@interface TableViewDataFetchController ()

@property (nonatomic, strong) id<TableViewDataFetchProtocol> dataModel;

@end

@implementation TableViewDataFetchController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUp];
}

-(void) setUp {
    [self setUpFetchView];
}

-(void) setUpFetchView {
    
    TableViewDataFetchView* fetchView = [[TableViewDataFetchView alloc] init];
    
    fetchView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:fetchView];
    NSLayoutConstraint *top = [fetchView.topAnchor constraintEqualToAnchor:self.topLayoutGuide.bottomAnchor];
    NSLayoutConstraint *leading = [fetchView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor];
    NSLayoutConstraint *trailing = [fetchView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor];
    NSLayoutConstraint *bottom = [fetchView.bottomAnchor constraintEqualToAnchor:self.bottomLayoutGuide.topAnchor];
    
    [self.view addConstraints:[[NSArray alloc] initWithObjects:top, leading, trailing, bottom, nil]];
}

-(instancetype)initWithDataModel:(id<TableViewDataFetchProtocol>)dataModel {
    self = [super init];

    if (self) {
        self.dataModel = dataModel;
    }
    return self;
}
@end
