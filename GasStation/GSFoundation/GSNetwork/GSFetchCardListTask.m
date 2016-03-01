//
//  GSFetchCardListTask.m
//  GasStation
//
//  Created by vedon on 3/1/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import "GSFetchCardListTask.h"

@interface GSFetchCardListTask ()
@property (nonatomic,strong) NSString *pageIndex;
@property (nonatomic,strong) NSString *pageSize;
@end

@implementation GSFetchCardListTask

- (instancetype)initWithPageIndex:(NSString *)pageIndex pageSize:(NSString *)pageSize
{
    self = [super init];
    if (self)
    {
        self.pageIndex = pageIndex;
        self.pageSize = pageSize;
    }
    return self;
}


- (NSString *)requestUrl {
    return @"/tickets/list";
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
