//
//  GSFetchGasStationDetailInfo.h
//  GasStation
//
//  Created by vedon on 3/1/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import "GSBaseRequest.h"

@interface GSFetchGasStationDetailInfoTask : GSBaseRequest

- (instancetype)initWithGasStationId:(NSString *)gsId;

@end
