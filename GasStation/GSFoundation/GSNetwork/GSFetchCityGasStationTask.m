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
    return @"/oil/api/station/city";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPost;
}

- (id)requestArgument {
    return @{
             @"region": self.fetchData.region,
             @"token": self.fetchData.token,
             @"query":self.fetchData.keyword,
             @"pageIndex":self.fetchData.pageIndex,
             @"pageSize":self.fetchData.pageSize,
             };
}

#pragma mark - GSBaseRequestMockProtocol

- (id)mockData
{
    return @{@"statusCode":@(200)};
}

@end
