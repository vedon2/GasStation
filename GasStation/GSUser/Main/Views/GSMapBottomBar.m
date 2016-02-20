//
//  GSMapBottomBar.m
//  GasStation
//
//  Created by vedon on 2/11/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import "GSMapBottomBar.h"
#import "PureLayout.h"
#import "GSBottomBarButton.h"

@interface GSMapBottomBar ()<GSBottomBarButtonDelegate>
@property (nonatomic,strong) UIImageView *bgView;
@property (nonatomic,strong) NSArray *buttons;
@end

@implementation GSMapBottomBar

- (instancetype)initWithButtons:(NSArray <GSBottomButtonInfo *> *)buttons delegate:(id<GSMapBottomBarDelegate>)delegate
{
    assert(buttons.count);
    self = [super initForAutoLayout];
    if (self)
    {
        self.delegate = delegate;
        self.buttons = buttons;
    }
    return self;
}

- (void)initialize
{
    __block GSBottomBarButton *tempButton = nil;
    __weak GSMapBottomBar *weakSelf = self;
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
    
    [self.buttons enumerateObjectsUsingBlock:^(GSBottomButtonInfo * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        GSBottomBarButton *button = [[GSBottomBarButton alloc] initWithImage:obj.image title:obj.title delegate:weakSelf];
        [button autoSetDimensionsToSize:CGSizeMake(weakSelf.frame.size.width/weakSelf.buttons.count, weakSelf.frame.size.height)];
        button.tag = idx;
        [weakSelf addSubview:button];
        [button autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:self];
        [button autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:weakSelf];
        if ((weakSelf.buttons.count - 1) == idx)
        {
            [button autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:weakSelf];
        }
        
        if (tempButton)
        {
            [button autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:tempButton];
        }
        else
        {
            [button autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:weakSelf];
        }
        tempButton = button;
        
    }];
}

#pragma mark - GSBottomBarButtonDelegate

- (void)buttonDidClick:(GSBottomBarButton *)button
{
    if ([self.delegate respondsToSelector:@selector(didSelectButtonIndex:)])
    {
        [self.delegate didSelectButtonIndex:button.tag];
    }
}

#pragma mark - Getter && Setter

- (UIImageView *)bgView
{
    if (!_bgView)
    {
        _bgView = [[UIImageView alloc] init];
        _bgView.backgroundColor = [UIColor lightGrayColor];
    }
    return _bgView;
}
@end
