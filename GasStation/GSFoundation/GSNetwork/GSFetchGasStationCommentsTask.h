//
//  GSFetchGasStationCommentsTask.h
//  GasStation
//
//  Created by vedon on 3/1/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import "GSBaseRequest.h"

@interface GSFetchGasStationCommentsTask : GSBaseRequest

- (instancetype)initWithStationId:(NSString *)stationId pageSize:(NSString *)pageSize pageIndex:(NSString *)pageIndex;

@end
