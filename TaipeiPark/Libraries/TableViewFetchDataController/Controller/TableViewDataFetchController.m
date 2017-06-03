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

-(instancetype)initWithDataModel:(id<TableViewDataFetchProtocol>)dataModel {
    self = [super init];
    
    if (self) {
        self.dataModel = dataModel;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUp];
}

-(void) setUp {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setUpFetchView];
}

-(void) setUpFetchView {
    
    TableViewDataFetchView* fetchView = [[TableViewDataFetchView alloc] initWithDelegate: self];
    
    fetchView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:fetchView];
    
    NSLayoutConstraint *top = [fetchView.topAnchor constraintEqualToAnchor:self.topLayoutGuide.bottomAnchor];
    
    NSLayoutConstraint *leading = [fetchView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor];
    
    NSLayoutConstraint *trailing = [fetchView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor];
    
    NSLayoutConstraint *bottom = [fetchView.bottomAnchor constraintEqualToAnchor:self.bottomLayoutGuide.topAnchor];
    
    [self.view addConstraints:[[NSArray alloc] initWithObjects:top, leading, trailing, bottom, nil]];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [self.dataModel numberOfSectionInTableView];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.dataModel numberOfRowInSection:section];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    
    cell.textLabel.text = @"Hi";
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 100.0;
}
@end































