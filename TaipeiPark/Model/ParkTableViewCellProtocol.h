//
//  ParkTableViewCellProtocol.h
//  TaipeiPark
//
//  Created by WU CHIH WEI on 2017/6/3.
//  Copyright © 2017年 WU CHIH WEI. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ParkTableViewCellProtocol <NSObject>

-(NSString*)getImageUrl;
-(NSString*)getParkName;
-(NSString*)getParkVariety;
-(NSString*)getParkNote;

@end
