//
//  GSFetchCityGasStationTask.m
//  GasStation
//
//  Created by vedon on 2/24/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import "GSFetchCityGasStationTask.h"
#import "GSFetchCityGasStationData.h"

@interface GSFetchCityGasStationTask ()
@property (strong,nonatomic) GSFetchCityGasStationData *fetchData;
@end

@implementation GSFetchCityGasStationTask

- (instancetype)initWithFetchData:(GSFetchCityGasStationData *)fetchData
{
    self = [super init];
    if (self)
    {
        self.fetchData = fetchData;
    }
    return self;
}

- (NSString *)requestUrl {
    return @"/station/city";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGet;
}

- (id)requestArgument {
    return @{
             @"region": self.fetchData.region,
             @"query":self.fetchData.q,
             @"sortby":self.fetchData.sortBy,//distance:1 降序 distance:0 升序
             @"pageSize":self.fetchData.pageSize,
             @"page":self.fetchData.pageIndex,
             };
}

#pragma mark - GSBaseRequestMockProtocol

- (id)mockData
{
    return @{@"statusCode":@(10000)};
}

@end
