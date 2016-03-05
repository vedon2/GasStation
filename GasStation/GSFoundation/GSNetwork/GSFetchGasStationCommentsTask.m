//
//  GSFetchGasStationCommentsTask.m
//  GasStation
//
//  Created by vedon on 3/1/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import "GSFetchGasStationCommentsTask.h"

@interface GSFetchGasStationCommentsTask ()
@property (nonatomic,strong) NSString *stationId;
@property (nonatomic,strong) NSString *pageSize;
@property (nonatomic,strong) NSString *pageIndex;
@end

@implementation GSFetchGasStationCommentsTask

- (instancetype)initWithStationId:(NSString *)stationId pageSize:(NSString *)pageSize pageIndex:(NSString *)pageIndex
{
    self = [super init];
    if (self)
    {
        self.stationId = stationId;
        self.pageSize = pageSize;
        self.pageIndex = pageIndex;
    }
    return self;
}

- (NSString *)requestUrl {
    return @"/comment/list";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGet;
}

- (id)requestArgument {
    return @{
             @"stationId": self.stationId,
             };
}

#pragma mark - GSBaseRequestMockProtocol

- (id)mockData
{
    return @{@"statusCode":@(1000)};
}


@end
