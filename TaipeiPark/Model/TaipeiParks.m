//
//  TaipeiParks.m
//  TaipeiPark
//
//  Created by WU CHIH WEI on 2017/6/3.
//  Copyright © 2017年 WU CHIH WEI. All rights reserved.
//

#import "TaipeiParks.h"
#import "Park.h"

@interface TaipeiParks ()

@property (strong, nonatomic) NSMutableArray *parks;

@property (strong, nonatomic) NSString *notificationName;

@end

@implementation TaipeiParks

-(instancetype)init {
    
    self = [super init];

    if (self) {
        
        self.parks = [[NSMutableArray alloc] init];
        
        self.notificationName = @"DidRecieveDatasFromServer";
    }
    
    return self;
}

-(NSInteger)numberOfSectionInTableView {
    
    return 1;
}

-(NSInteger)numberOfRowInSection:(NSInteger)section {
    
    return [self.parks count];
}

-(id) objectForCellAtRow:(NSInteger)row section:(NSInteger) section{
    
    return self.parks[row];
}

-(void)requestParks {
    
    static NSInteger dataOffset = 0;
    
    TaipeiParkNetworkHandler* networkHandler = [TaipeiParkNetworkHandler sharedInstance];

    [networkHandler setLimit:30 andOffset:dataOffset];
    
    __weak TaipeiParks* weakSelf = self;

    [networkHandler makeRequestWithMethod:GET andEndPoint:limitWithOffset dataCompletion:^void(NSData *data) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        NSDictionary *result = dict[@"result"];
        
        NSArray *results = result[@"results"];
        
        for (NSDictionary *item in [results objectEnumerator]) {
            
            Park *park = [Park createParkWithDictionary:item];
            
            [weakSelf.parks addObject:park];
        }
        
        dataOffset += 30;

        [weakSelf postDidGetDatasFromServerNotification];
    }];
}

-(NSString *)getDidRecieveDatasFromSeverNotificationString {

    return self.notificationName;
}

-(void) postDidGetDatasFromServerNotification {

    [[NSNotificationCenter defaultCenter] postNotificationName:self.notificationName object:self];
}

-(void) requestImageWithRow:(NSInteger)row andSection:(NSInteger)section completion:(void(^)(NSData*))completion {
    
    NSString *imageString = [self.parks[row] getImageUrl];
    
    TaipeiParkNetworkHandler* networkHandler = [TaipeiParkNetworkHandler sharedInstance];
    
    [networkHandler downloadDataWith:imageString completion:completion];
}

@end



























