//
//  GSFetchCoordinateGasStationData.m
//  GasStation
//
//  Created by vedon on 3/1/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import "GSFetchCoordinateGasStationData.h"

@implementation GSFetchCoordinateGasStationData

- (instancetype)initWithLocation:(NSString *)location radius:(NSNumber *)radius sortBy:(NSString *)soryBy keyword:(NSString *)keyword pageIndex:(NSString *)pageIndex pageSize:(NSString *)pageSize
{
    self = [super init];
    if (self)
    {
        self.location = location;
        self.radius =radius;
        self.sortby = soryBy;
        self.q = keyword;
        self.page_index = pageIndex;
        self.page_size = pageSize;
    }
    return self;
}

@end
