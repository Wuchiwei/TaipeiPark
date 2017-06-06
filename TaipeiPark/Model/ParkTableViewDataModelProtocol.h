//
//  ParkTableViewDataModelProtocol.h
//  TaipeiPark
//
//  Created by WU CHIH WEI on 2017/6/3.
//  Copyright © 2017年 WU CHIH WEI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TableViewDataFetchProtocol.h"
#import "TaipeiParkNetworkHandler.h"

@protocol ParkTableViewDataModelProtocol <NSObject, TableViewDataFetchProtocol>

@required

-(void) requestParks;
-(void) requestImageWithRow:(NSInteger)row andSection:(NSInteger)section completion:(void(^)(NSData*))completion;
@optional
-(NSString*) getDidRecieveDatasFromSeverNotificationString;

@end
