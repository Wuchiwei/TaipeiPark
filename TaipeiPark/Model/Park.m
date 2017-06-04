//
//  Park.m
//  TaipeiPark
//
//  Created by WU CHIH WEI on 2017/6/3.
//  Copyright © 2017年 WU CHIH WEI. All rights reserved.
//

#import "Park.h"

@interface Park ()

@property (strong, nonatomic) NSString* placeId;
@property (strong, nonatomic) NSString* parkName;
@property (strong, nonatomic) NSString* variety;
@property (strong, nonatomic) NSString* note;
@property (strong, nonatomic) NSString* image;

@end

@implementation Park

+(instancetype) createParkWithDictionary: (NSDictionary*) dict {
    
    Park *park = [Park alloc];
    
    park.placeId = dict[@"_id"];
    park.parkName = dict[@"ParkName"];
    park.variety = dict[@"Name"];
    park.note = dict[@"Introduction"];
    park.image = dict[@"Image"];
    
    return park;
}

-(NSString *)getImageUrl {
    return self.image;
}

-(NSString *)getParkName {
    return self.parkName;
}

-(NSString *)getParkNote {
    return self.note;
}

-(NSString *)getParkVariety {
    return self.variety;
}

@end
