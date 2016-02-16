//
//  GSMapBottomBar.m
//  GasStation
//
//  Created by vedon on 2/11/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import "GSMapBottomBar.h"
#import "PureLayout.h"

@interface GSMapBottomBar ()
@property (nonatomic,strong) UIImageView *bgView;
@end

@implementation GSMapBottomBar

- (instancetype)initWithButtons:(NSArray <GSBottomButtonInfo *> *)buttons delegate:(id<GSMapBottomBarDelegate>)delegate
{
    assert(buttons.count);
    self = [super initForAutoLayout];
    if (self)
    {
        self.delegate = delegate;
        __block UIButton *tempButton = nil;
        [buttons enumerateObjectsUsingBlock:^(GSBottomButtonInfo * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
           
            UIButton *button = [[UIButton alloc] initForAutoLayout];
            [button setTitle:obj.title forState:UIControlStateNormal];
            button.titleLabel.textAlignment = NSTextAlignmentCenter;
            [button setBackgroundImage:obj.image forState:UIControlStateNormal];
            button.backgroundColor = [UIColor lightGrayColor];
            [button addTarget:self action:@selector(tap:) forControlEvents:UIControlEventTouchUpInside];
            button.tag = idx;
            
            [self addSubview:button];
            [button autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:self];
            [button autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self];
            if ((buttons.count - 1) == idx)
            {
                [button autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self];
            }
            
            if (tempButton)
            {
                [button autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:tempButton];
            }
            else
            {
                [button autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self];
            }
            tempButton = button;
            
        }];
    }
    return self;
}

- (void)tap:(id)sender
{
    UIButton *btn = sender;
    if ([self.delegate respondsToSelector:@selector(didSelectButtonIndex:)])
    {
        [self.delegate didSelectButtonIndex:btn.tag];
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
