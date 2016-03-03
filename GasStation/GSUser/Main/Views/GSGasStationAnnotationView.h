//
//  GSGasStationAnnotationView.h
//  GasStation
//
//  Created by vedon on 3/3/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import "GSGasStationAnnotationData.h"

@interface GSGasStationAnnotationView : BMKAnnotationView

- (instancetype)initWithAnnotationData:(GSGasStationAnnotationData *)data;

- (void)configureWithData:(GSGasStationAnnotationData *)data;

@end
