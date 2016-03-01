//
//  GSFetchGasStationDetailInfo.m
//  GasStation
//
//  Created by vedon on 3/1/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import "GSFetchGasStationDetailInfoTask.h"

@interface GSFetchGasStationDetailInfoTask ()
@property (nonatomic,strong) NSString *gsId;
@end

@implementation GSFetchGasStationDetailInfoTask

- (instancetype)initWithGasStationId:(NSString *)gsId
{
    assert(gsId);
    self = [super init];
    if (self)
    {
        self.gsId = gsId;
    }
    return self;
}

- (NSString *)requestUrl {
    return @"/api/station/detail";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGet;
}

- (id)requestArgument {
    return @{
             @"id": self.gsId,
             };
}

#pragma mark - GSBaseRequestMockProtocol

- (id)mockData
{
    return @{@"statusCode":@(1000)};
}


@end
