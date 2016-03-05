//
//  GSCreateChargeTask.m
//  GasStation
//
//  Created by vedon on 3/6/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import "GSCreateChargeTask.h"

@interface GSCreateChargeTask ()
@property (nonatomic,strong) NSString *targetId;
@end

@implementation GSCreateChargeTask

- (instancetype)initWithTargetId:(NSString *)targetId
{
    self = [super init];
    if (self)
    {
        self.targetId =targetId;
    }
    return self;
}


- (NSString *)requestUrl {
    return @"/orders/create";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPost;
}

- (id)requestArgument {
    return @{
             @"targetId": self.targetId
             };
}

#pragma mark - GSBaseRequestMockProtocol

- (id)mockData
{
    return @{@"statusCode":@(1000)};
}


@end
