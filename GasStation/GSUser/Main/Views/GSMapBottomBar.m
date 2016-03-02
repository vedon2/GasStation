//
//  GSMapBottomBar.m
//  GasStation
//
//  Created by vedon on 2/11/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#define kButtonPadding 5
#define kFirstButtonPadding 6

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
    
    [self addSubview:self.bgView];
    [self.bgView autoPinEdgesToSuperviewEdges];
    
    
    CGFloat width = (self.frame.size.width - (2 * kFirstButtonPadding))/self.buttons.count;
    [self.buttons enumerateObjectsUsingBlock:^(GSBottomButtonInfo * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        GSBottomBarButton *button = [[GSBottomBarButton alloc] initWithImage:obj.image title:obj.title delegate:weakSelf];
        [weakSelf addSubview:button];
        
        [button autoSetDimensionsToSize:CGSizeMake(width, weakSelf.frame.size.height - 2 * kButtonPadding)];
        [button autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:weakSelf withOffset:kButtonPadding];
        button.tag = idx;
        
        if (tempButton)
        {
            [button autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:tempButton];
        }
        else
        {
            [button autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:weakSelf withOffset:kFirstButtonPadding];
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
        _bgView = [[UIImageView alloc] initForAutoLayout];
        
        UIImage *strechImage = [[UIImage imageNamed:@"nav_home_bg"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
        
        _bgView.backgroundColor = [UIColor clearColor];
        _bgView.image = strechImage;
    }
    return _bgView;
}
@end
