//
//  GSFetchCityGasStationData.h
//  GasStation
//
//  Created by vedon on 2/24/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GSFetchCityGasStationData : NSObject
@property (nonatomic,strong) NSString *region;
@property (nonatomic,strong) NSString *token;
@property (nonatomic,strong) NSString *q;
@property (nonatomic,strong) NSString *sortBy;
@property (nonatomic,strong) NSString *pageIndex;
@property (nonatomic,strong) NSString *pageSize;

- (instancetype)initWithRegion:(NSString *)region token:(NSString *)token sortBy:(NSString *)soryBy keyword:(NSString *)keyword pageIndex:(NSString *)pageIndex pageSize:(NSString *)pageSize;

@end
