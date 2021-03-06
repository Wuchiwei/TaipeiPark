//
//  TaipeiParkNetworkHandler.h
//  TaipeiPark
//
//  Created by WU CHIH WEI on 2017/6/4.
//  Copyright © 2017年 WU CHIH WEI. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    limit = 0,
    offset,
    limitWithOffset,
    none
} EndPoint;

typedef enum {
    GET = 0
} Method;

@interface TaipeiParkNetworkHandler : NSObject

+(instancetype) sharedInstance;
-(void)setLimit:(NSInteger)limit andOffset:(NSInteger)offset;
-(void)makeRequestWithMethod:(Method)method andEndPoint:(EndPoint)endPoint dataCompletion: (void(^)(NSData*)) completion;
-(NSString*)getNSStringWithEndPoint:(EndPoint)endPoint;
-(void)downloadDataWith:(NSString*)urlString completion:(void(^)(NSData*))completion;

@end
