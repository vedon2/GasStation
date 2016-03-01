//
//  GSStartUpTask.m
//  GasStation
//
//  Created by vedon on 3/1/16.
//  Copyright © 2016 vedon. All rights reserved.
//


#import "GSStartUpTask.h"

@interface GSStartUpTask ()
@property (nonatomic,strong) NSString *platform; //0-ios; 1-android
@property (nonatomic,strong) NSString *version;
@property (nonatomic,strong) NSString *edtion; //0-用户app; 1-管理端app
@end

@implementation GSStartUpTask

- (instancetype)initWithPlatform:(NSString *)platform version:(NSString *)version edition:(NSString *)edtion
{
    self = [super init];
    if (self) {
        self.platform = platform;
        self.version = version;
        self.edtion = edtion;
    }
    return self;
}


- (NSString *)requestUrl {
    return @"/app/startup";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGet;
}

- (id)requestArgument {
    return @{
             @"platform": self.platform,
             @"version": self.version,
             @"edition": self.edtion,

             };
}

#pragma mark - GSBaseRequestMockProtocol

- (id)mockData
{
    return @{@"statusCode":@(1000)};
}


@end
