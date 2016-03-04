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
#define kSearchBtnSize 50
#define kTopbarHeight 64
#define kSearchButtonEdgeInsets UIEdgeInsetsMake(21, 26, 13, 5)
#define kBottomBarHeight 48

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
#import "GSQueryBreakRuleViewController.h"
#import "GSGasPriceOrderViewController.h"
#import "GSEditUserProfileViewController.h"
#import "SDCycleScrollView.h"
#import "GSColor.h"
#import "GSGasStationAnnotationView.h"
#import "GSGasStationAnnotationData.h"
#import "GSWebViewController.h"

@interface GSUserMainViewController ()<BMKMapViewDelegate,GSMapManagerProtocol,GSMapBottomBarDelegate,GSMapNavViewDelegate,GSMapSearchBtnDelegate,SDCycleScrollViewDelegate>
@property (nonatomic,strong) BMKMapView *mapView;
@property (nonatomic,strong) GSMapBottomBar *bottomBar;
@property (nonatomic,strong) GSMapNavView *navView;
@property (nonatomic,strong) GSMapSearchBtn *searchBtn;
@property (nonatomic,strong) UIView *topBarContainerView;
@property (nonatomic,strong) SDCycleScrollView *adView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) BMKUserLocation *currentUserLocation;
@property (nonatomic,strong) NSMutableArray<GSGasStationAnnotationData *> *annotationDataContainer;
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
    [self.bottomBar autoSetDimension:ALDimensionHeight toSize:kBottomBarHeight];
    [self.bottomBar initialize];
    
    [self.mapView addSubview:self.topBarContainerView];
    [self.topBarContainerView autoSetDimension:ALDimensionHeight toSize:(kTopbarHeight+kAdViewHeight)];
    [self.topBarContainerView autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.mapView];
    [self.topBarContainerView autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.mapView];
    [self.topBarContainerView autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.mapView];
    
    
    [self.topBarContainerView addSubview:self.titleLabel];
    [self.titleLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.topBarContainerView withOffset:20];
    [self.titleLabel autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [self.titleLabel autoSetDimensionsToSize:CGSizeMake(100, 40)];
    
    [self.topBarContainerView addSubview:self.searchBtn];
    [self.searchBtn autoSetDimensionsToSize:CGSizeMake(kSearchBtnSize, kSearchBtnSize)];
    [self.searchBtn autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.topBarContainerView withOffset:-kMapViewContentXPadding];
    [self.searchBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.titleLabel withOffset:(-kSearchButtonEdgeInsets.top)/2];
    
    
    [self.topBarContainerView addSubview:self.adView];
    
    [self.mapView addSubview:self.navView];
    [self.navView autoSetDimensionsToSize:CGSizeMake([GSMapNavView buttinSize], 3*[GSMapNavView buttinSize]+10)];
    [self.navView autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:self.bottomBar withOffset:-20];
    [self.navView autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.bottomBar];
    
    
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

#pragma mark - Private

- (void)getAnnotationsForSearchResult
{
    for (int i =0; i<10; i++)
    {
        
        CGFloat randomNumberX = (arc4random() % 10)  * 0.004;
        CGFloat randomNumberY = (arc4random() % 20)  * 0.01;
        
        GSGasStationAnnotationData *annotationData = [[GSGasStationAnnotationData alloc] init];

        BMKPointAnnotation *pointAnnotation = [[BMKPointAnnotation alloc]init];
        CLLocationCoordinate2D coor;
        coor.latitude = self.currentUserLocation.location.coordinate.latitude + randomNumberX;
        coor.longitude = self.currentUserLocation.location.coordinate.longitude + randomNumberY;
        pointAnnotation.coordinate = coor;
        pointAnnotation.title = @"test";
        pointAnnotation.subtitle = @"此Annotation可拖拽!";
        
        annotationData.annotation = pointAnnotation;
        annotationData.isCooperation = YES;
        annotationData.reuseIdentifier = kAnnotationIdentifier;
        annotationData.annotationSize = CGSizeMake(20, 20);
        
        [self.annotationDataContainer addObject:annotationData];
        [self.mapView addAnnotation:pointAnnotation];
    }
}

- (GSGasStationAnnotationData *)annotationDataForAnnotation:(BMKPointAnnotation *)annotation
{
    assert(annotation);
    
    
    __block GSGasStationAnnotationData *data = nil;
    [self.annotationDataContainer enumerateObjectsUsingBlock:^(GSGasStationAnnotationData * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
       if ([annotation isEqual:obj.annotation])
       {
           data = obj;
           *stop = YES;
       }
    }];
    
    assert(data);
    return data;
    
}


#pragma mark - BMKMapViewDelegate

- (BMKAnnotationView *)mapView:(BMKMapView *)view viewForAnnotation:(id <BMKAnnotation>)annotation
{
    GSGasStationAnnotationView* annotationView = (GSGasStationAnnotationView *)[view dequeueReusableAnnotationViewWithIdentifier:kAnnotationIdentifier];
    GSGasStationAnnotationData *data = [self annotationDataForAnnotation:annotation];
    if (annotationView == nil) {
        annotationView = [[GSGasStationAnnotationView alloc] initWithAnnotationData:data];
    }
    else
    {
        [annotationView configureWithData:data];
    }
    
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
    self.currentUserLocation = location;
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
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self getAnnotationsForSearchResult];
            });
            return;
            break;
        }
        case 1:
        {
            //礼品
            viewControllerName = @"GSCouponViewController";
            break;
        }
        case 2:
        {
            //查违章
            viewControllerName = @"GSQueryBreakRuleViewController";
            break;
        }
        case 3:
        {
            //油价排行
            viewControllerName = @"GSGasPriceOrderViewController";
            break;
        }
        case 4:
        {
            //我
            viewControllerName = @"GSUserCenterViewController";
            isPresent = YES;
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
    CRNavigationController *nav = [[CRNavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:nil];
    nav = nil;
    vc = nil;
}

#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    GSWebViewController *vc = [[GSWebViewController alloc] initWithTitle:@"广告" requestUrl:@"http://www.baidu.com"];
    CRNavigationController *nav = [[CRNavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:nil];
    nav = nil;
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
        _mapView.logoPosition = BMKLogoPositionLeftTop;

        BMKLocationViewDisplayParam *param = [[BMKLocationViewDisplayParam alloc] init];
        param.locationViewImgName = @"icon_home_location3";
        [_mapView updateLocationViewWithParam:param];
    }
    
    return _mapView;
}

- (GSMapBottomBar *)bottomBar
{
    if (!_bottomBar)
    {
        NSMutableArray *buttonsInfos = [NSMutableArray array];
        NSArray *images = @[@"icon_home_gas-station",@"icon_home_discount",@"icon_home_query",@"icon_home_ranking",@"icon_home_my"];
        
        NSArray *titles = @[@"我要加油",@"礼品街",@"查违章",@"油价排行",@"我"];
        for (int i = 0; i < 5; i++)
        {
            NSString *imageName = [images objectAtIndex:i];
            NSString *title = [titles objectAtIndex:i];
            
            GSBottomButtonInfo *info = [[GSBottomButtonInfo alloc] initWithTitle:title image:[UIImage imageNamed:imageName]];
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
        _searchBtn = [[GSMapSearchBtn alloc] initWithDelegate:self image:[UIImage imageNamed:@"icon_home_search"] edgeInset:kSearchButtonEdgeInsets];
    }
    return _searchBtn;
}

- (UIView *)topBarContainerView
{
    if (!_topBarContainerView)
    {
        _topBarContainerView = [[UIView alloc] init];
        _topBarContainerView.backgroundColor = [GSColor mainColor];
    }
    return _topBarContainerView;
}

- (SDCycleScrollView *)adView
{
    if (!_adView)
    {
        _adView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 64, self.view.frame.size.width, kAdViewHeight) delegate:self placeholderImage:nil];
        _adView.backgroundColor = [UIColor clearColor];
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

- (UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [[UILabel alloc] initForAutoLayout];
        _titleLabel.text = @"快快加油";
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font = [UIFont systemFontOfSize:17];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (NSMutableArray *)annotationDataContainer
{
    if (!_annotationDataContainer)
    {
        _annotationDataContainer = [[NSMutableArray alloc] init];
    }
    return _annotationDataContainer;
}

@end
