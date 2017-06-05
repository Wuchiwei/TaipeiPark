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
@property (nonatomic, strong) TableViewDataFetchView *fetchView;
@property (nonatomic, copy, nullable) void(^cellHandler)(id, UITableViewCell*, UITableView*, NSIndexPath*);
@property (nonatomic, strong) NSString* cellIdentifier;
@property CGFloat rowHeight;
@end

@implementation TableViewDataFetchController

-(instancetype)initWithDataModel:(id<TableViewDataFetchProtocol>)dataModel {
    self = [super init];
    
    if (self) {
        self.dataModel = dataModel;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void) setUp {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setUpFetchView];
}

-(void) setUpFetchView {
    
    self.fetchView = [[TableViewDataFetchView alloc] initWithDelegate: self];
    
    [self.fetchView cellIdentifier:self.cellIdentifier];
    
    self.fetchView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:self.fetchView];
    
    NSLayoutConstraint *top = [self.fetchView.topAnchor constraintEqualToAnchor:self.topLayoutGuide.bottomAnchor];
    
    NSLayoutConstraint *leading = [self.fetchView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor];
    
    NSLayoutConstraint *trailing = [self.fetchView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor];
    
    NSLayoutConstraint *bottom = [self.fetchView.bottomAnchor constraintEqualToAnchor:self.bottomLayoutGuide.topAnchor];
    
    [self.view addConstraints:[[NSArray alloc] initWithObjects:top, leading, trailing, bottom, nil]];
}

-(void)cellIdentifiers:(NSString *)identifier {
    
    self.cellIdentifier = identifier;
    
    [self setUp];
}

-(void)cellForRowHandler:(void(^)(id object, UITableViewCell* cell, UITableView* myTableView, NSIndexPath *indexPath)) handler {

    self.cellHandler = handler;
}

-(void)arrangeViewWithHandler:(void(^)(UIView* childView)) handler {
    
    handler(self.view);
}

-(void)heightForRow:(CGFloat)height {
    
    self.rowHeight = height;
}

-(void)reloadTableView {
    [self.fetchView.tableView reloadData];
}
// MARK: TableView DataSource and Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [self.dataModel numberOfSectionInTableView];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.dataModel numberOfRowInSection:section];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: self.cellIdentifier
                                                            forIndexPath: indexPath];

    id object = [self.dataModel objectForCellAtRow:indexPath.row section:indexPath.section];

    if (self.cellHandler) {
    
        self.cellHandler(object, cell, tableView, indexPath);
    }

    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.rowHeight > 0) {
        
        return self.rowHeight;
    }
    
    return UITableViewAutomaticDimension;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 100.0;
}

@end































