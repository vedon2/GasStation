//
//  GSUserMainViewController.m
//  GasStation
//
//  Created by vedon on 2/11/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#define kAnnotationIdentifier @"annotationIdentifier"
#define kMapViewContentXPadding 15
#define kMapViewContentYPadding 10
#define kAdViewHeight 117

#import "GSUserMainViewController.h"
#import "PureLayout.h"
#import "GSMapManager.h"
#import "GSMapBottomBar.h"
#import "GSMapNavView.h"
#import "GSMapSearchBtn.h"
#import "GSSearchViewController.h"
#import "GSUserRegisterViewController.h"
#import "GSUserCenterViewController.h"
#import "GSCardViewController.h"
#import "GSCouponViewController.h"
#import "GSUserManager.h"
#import "GSPrensentViewControllerTransition.h"
#import "CRNavigationController.h"

#import "GSEditUserProfileViewController.h"
#import "SDCycleScrollView.h"

@interface GSUserMainViewController ()<BMKMapViewDelegate,GSMapManagerProtocol,GSMapBottomBarDelegate,GSMapNavViewDelegate,GSMapSearchBtnDelegate,SDCycleScrollViewDelegate>
@property (nonatomic,strong) BMKMapView *mapView;
@property (nonatomic,strong) GSMapBottomBar *bottomBar;
@property (nonatomic,strong) GSMapNavView *navView;
@property (nonatomic,strong) GSMapSearchBtn *searchBtn;
@property (nonatomic,strong) UIView *topBarContainerView;
@property (nonatomic,strong) SDCycleScrollView *adView;
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
    [self.bottomBar initialize];
    
    [self.mapView addSubview:self.topBarContainerView];
    [self.topBarContainerView autoSetDimension:ALDimensionHeight toSize:(64+kAdViewHeight)];
    [self.topBarContainerView autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.mapView];
    [self.topBarContainerView autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.mapView];
    [self.topBarContainerView autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.mapView];
    
    
    [self.topBarContainerView addSubview:self.searchBtn];
    [self.searchBtn autoSetDimensionsToSize:CGSizeMake(50, 50)];
    [self.searchBtn autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.topBarContainerView withOffset:-kMapViewContentXPadding];
    [self.searchBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.topBarContainerView withOffset:kMapViewContentYPadding];
    
    
    [self.topBarContainerView addSubview:self.adView];
    
    
    
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
    NSString *viewControllerName = nil;
    BOOL isPresent = NO;
    switch (index) {
        case 0:
        {
            //我要加油
            return;
            break;
        }
        case 1:
        {
            //优惠
            viewControllerName = @"GSCouponViewController";
            break;
        }
        case 2:
        {
            //加油卡
            if ([[GSUserManager shareManager] isLogin])
            {
                viewControllerName = @"GSCardViewController";
            }
            else
            {
                [GSUserRegisterViewController presentRegisterView];
                return;
            }
            break;
        }
        case 3:
        {
            //我
            if ([[GSUserManager shareManager] isLogin])
            {
                viewControllerName = @"GSUserCenterViewController";
                isPresent = YES;
            }
            else
            {
//                viewControllerName = @"GSEditUserProfileViewController";
                
                [GSUserRegisterViewController presentRegisterView];
                return;
            }
            break;
        }
            
        default:
            break;
    }
    
    assert(viewControllerName.length);
    if (viewControllerName.length)
    {
        UIViewController *vc = [[NSClassFromString(viewControllerName) alloc] initWithNibName:viewControllerName bundle:nil];
        if (isPresent)
        {
            [self presentViewController:vc animated:YES completion:nil];
        }
        else
        {
            CRNavigationController *nav = [[CRNavigationController alloc] initWithRootViewController:vc];
            [self presentViewController:nav animated:YES completion:nil];
            nav = nil;
        }
        vc = nil;
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

#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    
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
        for (int i = 0; i < 4; i++)
        {
            GSBottomButtonInfo *info = [[GSBottomButtonInfo alloc] initWithTitle:[NSString stringWithFormat:@"按钮%d",i] image:[UIImage imageNamed:@"first_selected"]];
            [buttonsInfos addObject:info];
        }
        self.bottomBar = [[GSMapBottomBar alloc] initWithButtons:buttonsInfos delegate:self];
        self.bottomBar.backgroundColor = [UIColor redColor];
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
        _searchBtn = [[GSMapSearchBtn alloc] initWithDelegate:self image:[UIImage imageNamed:@"second_normal"] edgeInset:UIEdgeInsetsMake(8, 8, 8, 0)];
    }
    return _searchBtn;
}

- (UIView *)topBarContainerView
{
    if (!_topBarContainerView)
    {
        _topBarContainerView = [[UIView alloc] init];
        _topBarContainerView.backgroundColor = [UIColor redColor];
    }
    return _topBarContainerView;
}

- (SDCycleScrollView *)adView
{
    if (!_adView)
    {
        _adView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 64, self.view.frame.size.width, kAdViewHeight) delegate:self placeholderImage:nil];
        
        NSArray *imagesURLStrings = @[
                                      @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
                                      @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
                                      @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"
                                      ];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            _adView.imageURLStringsGroup = imagesURLStrings;
        });
    }
    return _adView;
}
@end
