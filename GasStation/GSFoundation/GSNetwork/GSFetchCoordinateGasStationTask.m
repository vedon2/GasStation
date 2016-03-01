//
//  GSFetchCoordinateGasStationTask.m
//  GasStation
//
//  Created by vedon on 2/24/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import "GSFetchCoordinateGasStationTask.h"

@interface GSFetchCoordinateGasStationTask ()
@property (nonatomic,strong) GSFetchCoordinateGasStationData *fetchData;
@end

@implementation GSFetchCoordinateGasStationTask

- (instancetype)initWithFetchData:(GSFetchCoordinateGasStationData *)fetchData
{
    assert(fetchData);
    self = [super init];
    if (self)
    {
        self.fetchData = fetchData;
    }
    return self;
}

- (NSString *)requestUrl {
    return @"/api/station/location";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGet;
}

- (id)requestArgument {
    return @{
             @"location": self.fetchData.location,
             @"radius": self.fetchData.radius,
             @"q":self.fetchData.q,
             @"sortby":self.fetchData.sortby,//distance:1 降序 distance:0 升序
             @"pageIndex":self.fetchData.page_index,
             @"pageSize":self.fetchData.page_size,
             };
}

#pragma mark - GSBaseRequestMockProtocol

- (id)mockData
{
    return @{@"statusCode":@(1000)};
}

@end
