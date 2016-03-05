//
//  GSFetchCityGasStationData.m
//  GasStation
//
//  Created by vedon on 2/24/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import "GSFetchCityGasStationData.h"

@implementation GSFetchCityGasStationData

- (instancetype)initWithRegion:(NSString *)region token:(NSString *)token sortBy:(NSString *)soryBy keyword:(NSString *)keyword pageIndex:(NSString *)pageIndex pageSize:(NSString *)pageSize
{
    self = [super init];
    if (self)
    {
        self.region = region;
        self.token = token;
        self.sortBy = soryBy;
        self.q = keyword;
        self.pageIndex = pageIndex;
        self.pageSize = pageSize;
    }
    return self;
}

@end
