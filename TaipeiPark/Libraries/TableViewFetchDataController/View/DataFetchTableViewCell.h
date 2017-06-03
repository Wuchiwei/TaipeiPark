//
//  DataFetchTableViewCell.h
//  TaipeiPark
//
//  Created by WU CHIH WEI on 2017/6/3.
//  Copyright © 2017年 WU CHIH WEI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataFetchTableViewCellProtocol.h"

@interface DataFetchTableViewCell : UITableViewCell <DataFetchTableViewCellProtocol>

@property (weak, nonatomic) IBOutlet UILabel *myLabel;

@end
