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
@property (strong, nonatomic) NSCache *cache;
@property (strong, nonatomic) NSMutableDictionary *downloadedURLDict;

@end

@implementation ParkTableViewController

-(instancetype)initWithDataModel:(id<ParkTableViewDataModelProtocol>)dataModel {
    self = [super init];
    
    if (self) {
        
        self.dataModel = dataModel;
        
        self.cache = [[NSCache alloc] init];
        
        self.downloadedURLDict = [[NSMutableDictionary alloc] init];
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
        
        __weak ParkTableViewController* weakSelf = self;
        
        if ([object conformsToProtocol:@protocol(ParkTableViewCellProtocol)]) {
            
            if ([cell isKindOfClass:[ParkTableViewCell class]]) {
                
                ParkTableViewCell *parkCell = (ParkTableViewCell*) cell;
                
                id<ParkTableViewCellProtocol> parkObject = object;
                
                parkCell.parkNameLabel.text = [parkObject getParkName];
                
                parkCell.parkVarietyLabel.text = [parkObject getParkVariety];
                
                parkCell.parkNoteLabel.text = [parkObject getParkNote];
                
                UIImage *cacheImage = [weakSelf.cache objectForKey:indexPath];
                
                if (cacheImage) {
                    
                    parkCell.parkImageView.image = cacheImage;
                    
                    return;
                    
                } else {
                    
                    parkCell.parkImageView.image = nil;
                }
                
                if ([weakSelf.downloadedURLDict objectForKey:indexPath]) {
                    
                    return;
                }

                __weak UITableView *weakTableView = myTableView;

                dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
                    
                    NSLog(@"Request download image at row %li",(long)indexPath.row);
                    
                    [weakSelf.downloadedURLDict setObject:parkObject.getImageUrl forKey:indexPath];
                    
                    [weakSelf.dataModel requestImageWithRow:indexPath.row andSection:indexPath.section completion:^(NSData *data) {
                        
                        UIImage *image = [UIImage imageWithData:data];
                        
                        if (image) {
                            
                            [weakSelf.cache setObject:image forKey: indexPath];
                        
                        } else {
                            
                            //Error Handle
                            return;
                        }

                        ParkTableViewCell *reloadCell = (ParkTableViewCell*)[weakTableView cellForRowAtIndexPath:indexPath];
                        
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






