//
//  ParkTableViewController.m
//  TaipeiPark
//
//  Created by WU CHIH WEI on 2017/6/3.
//  Copyright © 2017年 WU CHIH WEI. All rights reserved.
//

#import "ParkTableViewController.h"
#import "TableViewDataFetchController.h"
#import "ParkTableViewCell.h"

@interface ParkTableViewController ()

@property (strong, nonatomic) id<ParkTableViewDataModel> dataModel;
@property (strong, nonatomic) TableViewDataFetchController* tableViewController;

@end

@implementation ParkTableViewController

-(instancetype)initWithDataModel:(id<ParkTableViewDataModel>)dataModel {
    
    self = [super init];
    
    if (self) {
        
        self.dataModel = dataModel;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];

    [self setUp];
}

-(void) setUp {

    [self addTableViewDataFetchController];
}

-(void) addTableViewDataFetchController {
    
    self.tableViewController = [[TableViewDataFetchController alloc] initWithDataModel:self.dataModel];
    
    [self.tableViewController cellIdentifiers:[ParkTableViewCell cellIdentifier]];
    
    [self addChildViewController: self.tableViewController];
    
    [self.view addSubview: self.tableViewController.view];
    
    __weak ParkTableViewController *weakSelf = self;
    
    [self.tableViewController arrangeViewWithHandler:^(UIView *childView) {
        
        if (childView.superview) {
            
            UIView *superView = childView.superview;
            
            childView.translatesAutoresizingMaskIntoConstraints = false;
            
            NSLayoutConstraint *top = [childView.topAnchor constraintEqualToAnchor: weakSelf.topLayoutGuide.bottomAnchor];
            
            NSLayoutConstraint *leading = [childView.leadingAnchor constraintEqualToAnchor: superView.leadingAnchor];
            
            NSLayoutConstraint *trailing = [childView.trailingAnchor constraintEqualToAnchor: superView.trailingAnchor];
            
            NSLayoutConstraint *bottom = [childView.bottomAnchor constraintEqualToAnchor: weakSelf.bottomLayoutGuide.topAnchor];
            
            [superView addConstraints:@[top, leading, trailing, bottom]];
        }
    }];
    
    [self.tableViewController didMoveToParentViewController:self];
}

@end






