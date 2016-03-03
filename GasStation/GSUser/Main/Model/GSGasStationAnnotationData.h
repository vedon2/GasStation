//
//  GSGasStationAnnotationData.h
//  GasStation
//
//  Created by vedon on 3/3/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BaiduMapAPI_Map/BMKAnnotation.h>

@interface GSGasStationAnnotationData : NSObject
@property (nonatomic,strong) id<BMKAnnotation> annotation;
@property (nonatomic,strong) NSString *reuseIdentifier;
@property (nonatomic,assign) BOOL isCooperation;
@property (nonatomic,assign) CGSize annotationSize;
@end
