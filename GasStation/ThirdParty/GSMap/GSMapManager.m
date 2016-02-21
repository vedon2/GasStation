//
//  GSMapManager.m
//  GasStation
//
//  Created by vedon on 2/1/16.
//  Copyright © 2016 vedon. All rights reserved.
//


#import "GSMapManager.h"
#import "GSMapMacro.h"
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
#import "ObserverContainer.h"
#import "GSAccountDefine.h"

@interface GSMapManager ()<BMKGeneralDelegate,BMKMapViewDelegate,BMKLocationServiceDelegate>
@property (nonatomic,strong) BMKMapManager *mapManager;
@property (nonatomic,strong) BMKLocationService *locService;

@property (nonatomic,strong) ObserverContainer *observers;
@end

@implementation GSMapManager

+ (instancetype)shareManager
{
    static GSMapManager *_shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareInstance = [[GSMapManager alloc] init];
    });
    
    return _shareInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.mapManager = [[BMKMapManager alloc]init];
        self.locService = [[BMKLocationService alloc] init];
        self.locService.delegate = self;
    }
    return self;
}

#pragma mark - Public

- (void)initialize
{
    BOOL ret = [_mapManager start:kMapAppKey generalDelegate:self];
    if (!ret) {
        assert(0);
    }
}

- (void)addObserver:(id<GSMapManagerProtocol>)observer
{
    assert(observer);
    if (observer)
    {
        [self.observers addObserver:observer];
    }
}

- (void)removeObserver:(id<GSMapManagerProtocol>)observer
{
    assert(observer);
    if (observer)
    {
        [self.observers removeObserver:observer];
    }
}

- (void)startLocateMyLocation
{
    [self.locService startUserLocationService];
}

- (void)stopLocateMyLocation
{
    [self.locService stopUserLocationService];
}

- (BMKUserLocation *)userLocation
{
    return self.locService.userLocation;
}

- (void)startPOISearchWithName:(NSString *)name completedBlock:(void (^)(NSArray <BMKPointAnnotation *> *annotations,NSError *error))completedBlock
{
    
}

#pragma mark - BMKLocationServiceDelegate

- (void)willStartLocatingUser
{
//    GSLog(@"开始定位");
}

- (void)didStopLocatingUser
{
//    GSLog(@"停止定位");
}

- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    if (self.observers.observerCount)
    {
        [self.observers enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj respondsToSelector:@selector(didGetUserCurrentLocation:)])
            {
                [obj didGetUserCurrentLocation:userLocation];
            }
        }];
    }
}

- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
//    GSLog(@"成功定位");
//    GSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    if (self.observers.observerCount)
    {
        [self.observers enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj respondsToSelector:@selector(didGetUserCurrentLocation:)])
            {
                [obj didGetUserCurrentLocation:userLocation];
            }
        }];
    }
}

- (void)didFailToLocateUserWithError:(NSError *)error
{
    GSLog(@"定位失败");
    if (self.observers.observerCount)
    {
        [self.observers enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj respondsToSelector:@selector(didFailToGetUserLocation)])
            {
                [obj didFailToGetUserLocation];
            }
        }];
    }
}


#pragma mark - Getter && Setter

- (ObserverContainer *)observers
{
    if (!_observers)
    {
        _observers = [[ObserverContainer alloc] init];
    }
    return _observers;
}
@end
