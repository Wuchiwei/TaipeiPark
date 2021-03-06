//
//  TaipeiParkNetworkHandler.m
//  TaipeiPark
//
//  Created by WU CHIH WEI on 2017/6/4.
//  Copyright © 2017年 WU CHIH WEI. All rights reserved.
//

#import "TaipeiParkNetworkHandler.h"

@interface TaipeiParkNetworkHandler ()

@property (strong, nonatomic) NSString *baseURI;
@property NSInteger limit;
@property NSInteger offset;

@end

@implementation TaipeiParkNetworkHandler

+(instancetype)sharedInstance {
    
    static TaipeiParkNetworkHandler *instance = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        instance = [[TaipeiParkNetworkHandler alloc] init];
    });

    return instance;
}

-(instancetype) init {
    self = [super init];
    
    if (self) {
        self.baseURI = @"http://data.taipei/opendata/datalist/apiAccess?scope=resourceAquire&rid=bf073841-c734-49bf-a97f-3757a6013812";
        self.limit = 30;
        self.offset = 0;
    }
    
    return self;
}

-(void)setLimit:(NSInteger)limit andOffset:(NSInteger)offset {
    
    self.limit = limit;
    self.offset = offset;
}

-(void)makeRequestWithMethod: (Method) method andEndPoint: (EndPoint) endPoint
              dataCompletion: (void(^)(NSData*)) completion {
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    NSURL *url = [[NSURL alloc] initWithString:[self.baseURI stringByAppendingString:[self getNSStringWithEndPoint:endPoint]]];
    
    if (url) {
        request.URL = url;
    } else {
        //Error Handle
        return;
    }
    
    request.HTTPMethod = [self getMethodString:method];
    
    NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if(error) {
            //Error handle
            printf("Here is error");
            return;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(data);
        });
    }];
    
    task.priority = NSURLSessionTaskPriorityHigh;
    
    [task resume];
}

-(void)downloadDataWith:(NSString*)urlString completion: (void(^)(NSData*)) completion {

    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSURL *imageURL = [NSURL URLWithString:urlString];
    
    if (imageURL) {
        
        NSURLSessionTask *task = [session downloadTaskWithURL:imageURL completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
           
            if (error) {
                //Error handle
                NSLog(@"%@", error);
            }
            
            NSData *data = [NSData dataWithContentsOfURL:imageURL];
            
            if (data) {
                
                dispatch_async(dispatch_get_main_queue(), ^(){
                    completion(data);
                });
            }

        }];
        
        [task resume];
    }
}

-(NSString*)getNSStringWithEndPoint: (EndPoint)endPoint {
    
    NSString *endString;
    
    NSMutableString *path = [NSMutableString stringWithString:@""];
    
    NSString *limitCount = [NSString stringWithFormat:@"%ld",(long)self.limit];
    
    NSString *offsetCount = [NSString stringWithFormat:@"%ld",(long)self.offset];
    
    switch (endPoint) {
        case limit:
            
            endString = @"&limit=";

            [path appendString:endString];
 
            [path appendString:limitCount];
            
            break;
        
        case offset:
            
            endString = @"&offset=";
            
            [path appendString:endString];
            
            [path appendString:offsetCount];
            
            break;
            
        case limitWithOffset:
            
            [path appendString: [self getNSStringWithEndPoint:limit]];
            
            [path appendString: [self getNSStringWithEndPoint:offset]];
            
            break;
            
        default:
            break;
    }
    
    return path;
}

-(NSString*)getMethodString: (Method) method {
    NSString *methodString = @"";
    
    switch (method) {
    
        case GET:
            methodString = @"GET";
            break;
            
        default:
            break;
    }
    
    return methodString;
}
@end



































