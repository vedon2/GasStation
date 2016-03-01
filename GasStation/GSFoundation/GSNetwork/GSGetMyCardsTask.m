//
//  GSGetMyCardsTask.m
//  GasStation
//
//  Created by vedon on 3/1/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import "GSGetMyCardsTask.h"

@interface GSGetMyCardsTask ()
@property (nonatomic,strong) NSString *userId;
@property (nonatomic,strong) NSString *pageIndex;
@property (nonatomic,strong) NSString *pageSize;
@end

@implementation GSGetMyCardsTask

- (instancetype)initWithUserId:(NSString *)userId pageIndex:(NSString *)pageIndex pageSize:(NSString *)pageSize
{
    self = [super init];
    if (self)
    {
        self.userId = userId;
        self.pageIndex = pageIndex;
        self.pageSize = pageSize;
    }
    return self;
}

- (NSString *)requestUrl {
    return @"/tickets/mine";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGet;
}

- (id)requestArgument {
    return @{
             @"pageIndex": self.pageIndex,
             @"pageSize": self.pageSize,
             };
}

#pragma mark - GSBaseRequestMockProtocol

- (id)mockData
{
    return @{@"statusCode":@(1000)};
}


@end
