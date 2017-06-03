//
//  DataFetchTableViewCell.m
//  TaipeiPark
//
//  Created by WU CHIH WEI on 2017/6/3.
//  Copyright © 2017年 WU CHIH WEI. All rights reserved.
//

#import "DataFetchTableViewCell.h"

@implementation DataFetchTableViewCell

+(NSString*) identifier {
    return @"DataFetchTableViewCell";
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.myLabel.text = @"Ni how";
}

@end
