//
//  Park.h
//  TaipeiPark
//
//  Created by WU CHIH WEI on 2017/6/3.
//  Copyright © 2017年 WU CHIH WEI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ParkTableViewCellProtocol.h"

@interface Park : NSObject <ParkTableViewCellProtocol>

+(instancetype) createParkWithDictionary: (NSDictionary*) dict;

@end
