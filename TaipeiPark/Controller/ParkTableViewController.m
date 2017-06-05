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
#import "ParkTableViewCellProtocol.h"

@interface ParkTableViewController ()

@property (strong, nonatomic) id<ParkTableViewDataModelProtocol> dataModel;
@property (strong, nonatomic) TableViewDataFetchController* tableViewController;

@end

@implementation ParkTableViewController

-(instancetype)initWithDataModel:(id<ParkTableViewDataModelProtocol>)dataModel {
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
    
    [self testNetworkHandler]; //remove
    
    [self registeAsObserve];
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
    
    [self.tableViewController cellForRowHandler:^(id object, UITableViewCell* cell, UITableView* myTableView, NSIndexPath *indexPath) {
        
        if ([object conformsToProtocol:@protocol(ParkTableViewCellProtocol)]) {
            
            if ([cell isKindOfClass:[ParkTableViewCell class]]) {
                
                ParkTableViewCell *parkCell = (ParkTableViewCell*) cell;
                
                id<ParkTableViewCellProtocol> parkObject = object;
                
                parkCell.parkNameLabel.text = [parkObject getParkName];
                
                parkCell.parkVarietyLabel.text = [parkObject getParkVariety];
                
                parkCell.parkNoteLabel.text = [parkObject getParkNote];
                
                __weak ParkTableViewController* weakSelf = self;
                
                __weak UITableView *weakTableView = myTableView;

                dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
                    
                    [weakSelf.dataModel requestImageWithRow:indexPath.row andSection:indexPath.section completion:^(NSData *data) {
                        
                        UIImage *image = [UIImage imageWithData:data];
                        
                        ParkTableViewCell *reloadCell = (ParkTableViewCell*)[weakTableView cellForRowAtIndexPath:indexPath];
                        
                        NSLog(@"%li",(long)indexPath.row);
                        
                        if (reloadCell) {
                            
                            reloadCell.parkImageView.image = image;
                        }
                    }];
                    
                });
            }
        }
        
    }];
    
    [self.tableViewController didMoveToParentViewController:self];
}

-(void) registeAsObserve {

    NSString *notificationName = [self.dataModel getDidRecieveDatasFromSeverNotificationString];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData) name:notificationName object:nil];
}

-(void) reloadData {
    
    NSLog(@"get data message");
    
    [self.tableViewController reloadTableView];
}

-(void) testNetworkHandler {

    [self.dataModel requestParks];
}

@end






