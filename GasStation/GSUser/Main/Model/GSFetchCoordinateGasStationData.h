//
//  GSFetchCoordinateGasStationData.h
//  GasStation
//
//  Created by vedon on 3/1/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GSFetchCoordinateGasStationData : NSObject
//location	string	是	"116.4321,38.76623" 百度加密经纬度
//radius	float	是	半径，米
//sortby	string	是	distance:1 distance:0
//q	string	是	关键字
//page_index	string	是
//page_size	0	是

@property (nonatomic,strong) NSString *location;
@property (nonatomic,strong) NSNumber *radius;
@property (nonatomic,strong) NSString *sortby;
@property (nonatomic,strong) NSString *q;
@property (nonatomic,strong) NSString *page_index;
@property (nonatomic,strong) NSString *page_size;

- (instancetype)initWithLocation:(NSString *)location radius:(NSNumber *)radius sortBy:(NSString *)soryBy keyword:(NSString *)keyword pageIndex:(NSString *)pageIndex pageSize:(NSString *)pageSize;


@end
