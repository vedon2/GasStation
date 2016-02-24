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
@property (nonatomic,strong) NSString *keyword;
@property (nonatomic,strong) NSNumber *pageIndex;
@property (nonatomic,strong) NSNumber *pageSize;

@end
