//
//  GSMapManager.h
//  GasStation
//
//  Created by vedon on 2/1/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>

@protocol GSMapManagerProtocol <NSObject>

- (void)didGetUserCurrentLocation:(BMKUserLocation *)location;

- (void)didFailToGetUserLocation;

@end

@interface GSMapManager : NSObject

+ (instancetype)shareManager;

- (void)addObserver:(id<GSMapManagerProtocol>)observer;

- (void)removeObserver:(id<GSMapManagerProtocol>)observer;

- (void)initialize;

- (void)startLocateMyLocation;

- (void)stopLocateMyLocation;

- (BMKUserLocation *)userLocation;

- (void)startPOISearchWithName:(NSString *)name completedBlock:(void (^)(NSArray <BMKPointAnnotation *> *annotations,NSError *error))completedBlock;

@end
