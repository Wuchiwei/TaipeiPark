//
//  ParkTableViewController.m
//  TaipeiPark
//
//  Created by WU CHIH WEI on 2017/6/5.
//  Copyright © 2017年 WU CHIH WEI. All rights reserved.
//

#import "ParkTableViewController.h"
#import "ParkTableViewCellProtocol.h"
#import "ParkTableViewCell.h"

@interface ParkTableViewController ()
@property (strong, nonatomic) id<ParkTableViewDataModelProtocol> dataModel;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSCache *cache;
@property (strong, nonatomic) NSMutableDictionary *downloadedURLDict;
@end

@implementation ParkTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUp];
}

-(instancetype)initWithDataModel: (id<ParkTableViewDataModelProtocol>) dataModel {
    
    self = [super init];
    
    if(self){
        self.dataModel = dataModel;
        self.tableView = [[UITableView alloc] init];
        self.cache = [[NSCache alloc] init];
        self.downloadedURLDict = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}

-(void)setUp {

    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setUpTableView];
    
    [self registeAsObserver];
    
    [self.dataModel requestParks];
}

-(void) setUpTableView {
    
    self.automaticallyAdjustsScrollViewInsets = false;
    
    UINib* nib = [UINib nibWithNibName:[ParkTableViewCell cellIdentifier] bundle:nil];
    
    [self.tableView registerNib:nib forCellReuseIdentifier:[ParkTableViewCell cellIdentifier]];
    
    self.tableView.translatesAutoresizingMaskIntoConstraints = false;
    
    self.tableView.delegate = self;
    
    self.tableView.dataSource = self;
    
    [self.view addSubview: self.tableView];
    
    NSLayoutConstraint *top = [self.tableView.topAnchor constraintEqualToAnchor:self.topLayoutGuide.bottomAnchor];
    
    NSLayoutConstraint *leading = [self.tableView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor];
    
    NSLayoutConstraint *trailing = [self.tableView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor];
    
    NSLayoutConstraint *bottom = [self.tableView.bottomAnchor constraintEqualToAnchor:self.bottomLayoutGuide.topAnchor];
    
    [self.view addConstraints:@[top, leading, trailing, bottom]];
}

-(void) registeAsObserver {
    
    NSString *notificationName = [self.dataModel getDidRecieveDatasFromSeverNotificationString];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData) name:notificationName object:nil];
}

-(void) reloadData {
    
    NSLog(@"get data message YA");
    
    [self.tableView reloadData];
}

// MARK: TableView DataSource And Delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [self.dataModel numberOfSectionInTableView];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [self.dataModel numberOfRowInSection:section];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return UITableViewAutomaticDimension;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 200;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    id<ParkTableViewCellProtocol> parkObject = (id<ParkTableViewCellProtocol>) [self.dataModel objectForCellAtRow:indexPath.row section:indexPath.section];
    
    ParkTableViewCell* parkCell = (ParkTableViewCell*) [tableView dequeueReusableCellWithIdentifier:[ParkTableViewCell cellIdentifier] forIndexPath:indexPath];
    
    if ([parkObject conformsToProtocol:@protocol(ParkTableViewCellProtocol)]) {
        
        if ([parkCell isKindOfClass:[ParkTableViewCell class]]) {
            
            parkCell.parkNameLabel.text = [parkObject getParkName];
            
            parkCell.parkVarietyLabel.text = [parkObject getParkVariety];
            
            parkCell.parkNoteLabel.text = [parkObject getParkNote];
            
            UIImage *cacheImage = [self.cache objectForKey:indexPath];
            
            if (cacheImage) {
                
                parkCell.parkImageView.image = cacheImage;
                
                return parkCell;
                
            } else {
                
                parkCell.parkImageView.image = nil;
            }
            
            if ([self.downloadedURLDict objectForKey:indexPath]) {
                
                return parkCell;
            
            } else {
                
                [self downloadImageForCellAtIndexPath:indexPath withImageURL:parkObject.getImageUrl];
            }
        }
    }
    
    return parkCell;
}

-(void) downloadImageForCellAtIndexPath: (NSIndexPath *) indexPath withImageURL: (NSString*) imageURL {
    
    __weak ParkTableViewController* weakSelf = self;
    
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        
        NSLog(@"Request download image at row %li",(long)indexPath.row);
        
        [weakSelf.downloadedURLDict setObject: imageURL forKey:indexPath];
        
        [weakSelf.dataModel requestImageWithRow:indexPath.row andSection:indexPath.section completion:^(NSData *data) {
            
            UIImage *image = [UIImage imageWithData:data];
            
            if (image) {
                
                [weakSelf.cache setObject:image forKey: indexPath];
                
            } else {
                
                //Error Handle
                return;
            }
            
            ParkTableViewCell *reloadCell = (ParkTableViewCell*)[weakSelf.tableView cellForRowAtIndexPath:indexPath];
            
            if (reloadCell) {
                
                reloadCell.parkImageView.image = image;
            }
        }];
        
    });
}

@end










































