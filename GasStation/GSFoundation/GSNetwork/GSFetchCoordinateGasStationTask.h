//
//  GSFetchCoordinateGasStationTask.h
//  GasStation
//
//  Created by vedon on 2/24/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import "GSBaseRequest.h"
#import "GSFetchCoordinateGasStationData.h"

@interface GSFetchCoordinateGasStationTask : GSBaseRequest

- (instancetype)initWithFetchData:(GSFetchCoordinateGasStationData *)fetchData;

@end
