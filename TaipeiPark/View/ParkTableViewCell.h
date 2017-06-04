//
//  ParkTableViewCell.h
//  TaipeiPark
//
//  Created by WU CHIH WEI on 2017/6/3.
//  Copyright © 2017年 WU CHIH WEI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ParkTableViewCell : UITableViewCell

+(NSString*) cellIdentifier;
@property (weak, nonatomic) IBOutlet UIImageView *parkImageView;
@property (weak, nonatomic) IBOutlet UILabel *parkNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *parkVarietyLabel;
@property (weak, nonatomic) IBOutlet UILabel *parkNoteLabel;

@end
