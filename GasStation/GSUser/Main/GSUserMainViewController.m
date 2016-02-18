//
//  GSUserMainViewController.m
//  GasStation
//
//  Created by vedon on 2/11/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#define kAnnotationIdentifier @"annotationIdentifier"
#define kMapViewContentXPadding 15
#define kMapViewContentYPadding 25

#import "GSUserMainViewController.h"
#import "PureLayout.h"
#import "GSMapManager.h"
#import "GSMapBottomBar.h"
#import "GSMapNavView.h"
#import "GSMapSearchBtn.h"
#import "GSSearchViewController.h"
#import "GSUserRegisterViewController.h"
#import "GSUserCenterViewController.h"
#import "GSUserManager.h"
#import "GSPrensentViewControllerTransition.h"

@interface GSUserMainViewController ()<BMKMapViewDelegate,GSMapManagerProtocol,GSMapBottomBarDelegate,GSMapNavViewDelegate,GSMapSearchBtnDelegate>
@property (nonatomic,strong) BMKMapView *mapView;
@property (nonatomic,strong) GSMapBottomBar *bottomBar;
@property (nonatomic,strong) GSMapNavView *navView;
@property (nonatomic,strong) GSMapSearchBtn *searchBtn;
@end

@implementation GSUserMainViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self.view addSubview:self.mapView];
    [self.mapView autoPinEdgesToSuperviewEdges];
    
    [self.mapView addSubview:self.bottomBar];
    [self.bottomBar autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.mapView withOffset:-10];
    [self.bottomBar autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.mapView withOffset:kMapViewContentXPadding];
    [self.bottomBar autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.mapView withOffset:-kMapViewContentXPadding];
    [self.bottomBar autoSetDimension:ALDimensionHeight toSize:40];
    
    
    [self.mapView addSubview:self.searchBtn];
    [self.searchBtn autoSetDimensionsToSize:CGSizeMake(30, 30)];
    [self.searchBtn autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.mapView withOffset:-kMapViewContentXPadding];
    [self.searchBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.mapView withOffset:kMapViewContentYPadding];
    
    [self.mapView addSubview:self.navView];
    [self.navView autoSetDimensionsToSize:CGSizeMake([GSMapNavView buttinSize], 3*[GSMapNavView buttinSize]+10)];
    [self.navView autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:self.bottomBar withOffset:-20];
    [self.navView autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.bottomBar];
    
    
    [[GSMapManager shareManager] addObserver:self];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[GSMapManager shareManager] startLocateMyLocation];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[GSMapManager shareManager] stopLocateMyLocation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - BMKMapViewDelegate

- (BMKAnnotationView *)mapView:(BMKMapView *)view viewForAnnotation:(id <BMKAnnotation>)annotation
{
    NSString *AnnotationViewID = kAnnotationIdentifier;
    BMKAnnotationView* annotationView = [view dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
    
    if (annotationView == nil) {
        annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
        ((BMKPinAnnotationView*)annotationView).pinColor = BMKPinAnnotationColorRed;
        // 设置重天上掉下的效果(annotation)
        ((BMKPinAnnotationView*)annotationView).animatesDrop = YES;
    }
    
    annotationView.centerOffset = CGPointMake(0, -(annotationView.frame.size.height * 0.5));
    annotationView.annotation = annotation;
    annotationView.canShowCallout = YES;
    annotationView.draggable = NO;
    
    return annotationView;
}

- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view
{
    [mapView bringSubviewToFront:view];
    [mapView setNeedsDisplay];
}

- (void)mapView:(BMKMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    NSLog(@"didAddAnnotationViews");
}

#pragma mark - GSMapManagerProtocol

- (void)didGetUserCurrentLocation:(BMKUserLocation *)location
{
    [self.mapView updateLocationData:location];
}

- (void)didFailToGetUserLocation
{
    
}

#pragma mark - GSMapBottomBarDelegate

- (void)didSelectButtonIndex:(NSUInteger)index
{
    switch (index) {
        case 0:
        {
            break;
        }
        case 1:
        {
            break;
        }
        case 2:
        {
            if ([[GSUserManager shareManager] isLogin])
            {
                GSUserCenterViewController *vc = [[GSUserCenterViewController alloc] initWithNibName:@"GSUserCenterViewController" bundle:nil];
#ifdef kUserDragableAnimation
                vc.modalPresentationStyle = UIModalPresentationCustom;
                self.defaultPrensentAnimation = [GSPrensentViewControllerTransition defaultTransitionWithViewController:vc];
                vc.transitioningDelegate = self.defaultPrensentAnimation;
                [self presentViewController:vc animated:YES completion:nil];
#else
                UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
                [self presentViewController:nav animated:YES completion:nil];
                nav = nil;
#endif
                vc = nil;
               
                
            }
            else
            {
                GSUserRegisterViewController *vc = [[GSUserRegisterViewController alloc] initWithNibName:@"GSUserRegisterViewController" bundle:nil];
                [self presentViewController:vc animated:YES completion:nil];
                vc = nil;
            }
            
            
            break;
        }
            
            
        default:
            break;
    }
    NSLog(@"%lu",(unsigned long)index);
}

#pragma mark - GSMapNavViewDelegate

- (void)navViewDidTapZoomInBtn:(GSMapNavView *)view
{
    [self.mapView zoomIn];
}

- (void)navViewDidTapZoomOutBtn:(GSMapNavView *)view
{
    [self.mapView zoomOut];
}

- (void)navViewDidTapNavBtn:(GSMapNavView *)view
{
    _mapView.showsUserLocation = NO;
    _mapView.userTrackingMode = BMKUserTrackingModeFollow;
    _mapView.showsUserLocation = YES;
    
    [_mapView updateLocationData:[[GSMapManager shareManager] userLocation]];
}

#pragma mark - GSMapSearchBtnDelegate

- (void)didTapSearchBtn
{
    GSSearchViewController *vc = [[GSSearchViewController alloc] initWithNibName:nil bundle:nil];
    [self presentViewController:vc animated:YES completion:nil];
    vc = nil;
}

#pragma mark - Getter && Setter

- (BMKMapView *)mapView
{
    if(!_mapView)
    {
        _mapView = [[BMKMapView alloc] initForAutoLayout];
        _mapView.zoomLevel = 15;
        _mapView.minZoomLevel = 5;
        _mapView.maxZoomLevel = 30;
        _mapView.showsUserLocation = NO;
        _mapView.userTrackingMode = BMKUserTrackingModeFollow;
        _mapView.showsUserLocation = YES;
        _mapView.delegate = self;
        
    }
    
    return _mapView;
}

- (GSMapBottomBar *)bottomBar
{
    if (!_bottomBar)
    {
        NSMutableArray *buttonsInfos = [NSMutableArray array];
        for (int i = 0; i < 3; i++)
        {
            GSBottomButtonInfo *info = [[GSBottomButtonInfo alloc] initWithTitle:[NSString stringWithFormat:@"按钮%d",i] image:nil];
            [buttonsInfos addObject:info];
        }
        self.bottomBar = [[GSMapBottomBar alloc] initWithButtons:buttonsInfos delegate:self];
    }
    return _bottomBar;
}

- (GSMapNavView *)navView
{
    if (!_navView)
    {
        _navView = [[GSMapNavView alloc] initWithDelegate:self];
    }
    return _navView;
}

- (GSMapSearchBtn *)searchBtn
{
    if (!_searchBtn)
    {
        _searchBtn = [[GSMapSearchBtn alloc] initWithDelegate:self];
    }
    return _searchBtn;
}
@end
