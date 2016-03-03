//
//  GSMapNavView.m
//  GasStation
//
//  Created by vedon on 2/12/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#define kButtonSize 30

#import "GSMapNavView.h"
#import "PureLayout.h"

@interface GSMapNavView ()

@property (nonatomic,strong) UIView *containerView;
@property (nonatomic,strong) UIButton *zoomInBtn;
@property (nonatomic,strong) UIButton *zoomOutBtn;
@property (nonatomic,strong) UIButton *navBtn;
@end

@implementation GSMapNavView

- (instancetype)initWithDelegate:(id<GSMapNavViewDelegate>)delegate
{
    self = [super init];
    if (self)
    {
        self.delegate = delegate;
        
        [self addSubview:self.containerView];
        [self.containerView autoPinEdgesToSuperviewEdges];
        
        [self.containerView addSubview:self.zoomInBtn];
        [self.zoomInBtn autoSetDimensionsToSize:CGSizeMake(kButtonSize, kButtonSize)];
        [self.zoomInBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.containerView];
        [self.zoomInBtn autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.containerView];
        
        [self.containerView addSubview:self.zoomOutBtn];
        [self.zoomOutBtn autoSetDimensionsToSize:CGSizeMake(kButtonSize, kButtonSize)];
        [self.zoomOutBtn autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.zoomInBtn];
        [self.zoomOutBtn autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.containerView];
        
        [self.containerView addSubview:self.navBtn];
        [self.navBtn autoSetDimensionsToSize:CGSizeMake(kButtonSize, kButtonSize)];
        [self.navBtn autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.containerView];
        [self.navBtn autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.containerView];
    }
    return self;
}

+ (CGFloat)buttinSize
{
    return kButtonSize;
}

#pragma mark - Gesture && Action

- (void)zoomInAction
{
    if ([self.delegate respondsToSelector:@selector(navViewDidTapZoomInBtn:)])
    {
        [self.delegate navViewDidTapZoomInBtn:self];
    }
}

- (void)zoomOutAction
{
    if ([self.delegate respondsToSelector:@selector(navViewDidTapZoomOutBtn:)])
    {
        [self.delegate navViewDidTapZoomOutBtn:self];
    }
}

- (void)navAction
{
    if ([self.delegate respondsToSelector:@selector(navViewDidTapNavBtn:)])
    {
        [self.delegate navViewDidTapNavBtn:self];
    }
}

#pragma mark - Getter && Setter

- (UIView *)containerView
{
    if (!_containerView)
    {
        _containerView = [[UIView alloc] initForAutoLayout];
        _containerView.backgroundColor = [UIColor clearColor];
    }
    return _containerView;
}

- (UIButton *)zoomInBtn
{
    if (!_zoomInBtn)
    {
        _zoomInBtn = [[UIButton alloc] initForAutoLayout];
        _zoomInBtn.backgroundColor = [UIColor clearColor];
        [_zoomInBtn setImage:[UIImage imageNamed:@"icon_map_enlarge"] forState:UIControlStateNormal];
        [_zoomInBtn addTarget:self action:@selector(zoomInAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _zoomInBtn;
}

- (UIButton *)zoomOutBtn
{
    if (!_zoomOutBtn)
    {
        _zoomOutBtn = [[UIButton alloc] initForAutoLayout];
        _zoomOutBtn.backgroundColor = [UIColor clearColor];
        [_zoomOutBtn setImage:[UIImage imageNamed:@"icon_map_narrow"] forState:UIControlStateNormal];
        [_zoomOutBtn addTarget:self action:@selector(zoomOutAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _zoomOutBtn;
}

- (UIButton *)navBtn
{
    if (!_navBtn)
    {
        _navBtn = [[UIButton alloc] initForAutoLayout];
        _navBtn.backgroundColor = [UIColor clearColor];
        [_navBtn setImage:[UIImage imageNamed:@"icon_map_location"] forState:UIControlStateNormal];
        [_navBtn addTarget:self action:@selector(navAction) forControlEvents:UIControlEventTouchUpInside];}
    return _navBtn;
}

@end
