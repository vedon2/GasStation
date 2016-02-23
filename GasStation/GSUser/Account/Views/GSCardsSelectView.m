//
//  GSCardsSelectView.m
//  GasStation
//
//  Created by vedon on 2/22/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#define kUnderLineHeight 1
#define kSeperateLineWidth 1
#define kSeperateLineTopPadding 5

#import "GSCardsSelectView.h"
#import "PureLayout.h"
#import "GSCardsSelectViewItemInfo.h"
#import "GSColor.h"

@interface GSCardsSelectView ()
@property (nonatomic,strong) NSArray *itemsInfo;
@property (nonatomic,strong) UIView *underLine;
@property (nonatomic,strong) UIView *underSelectedLine;
@property (nonatomic,strong) NSLayoutConstraint *underSelectedLineLeftConstraint;
@property (nonatomic,strong) NSMutableArray *buttons;
@end

@implementation GSCardsSelectView

- (instancetype)initWithDelegate:(id<GSCardsSelectViewProtocol>)delegate numberOfButtons:(NSArray *)itemsInfo selectedIndex:(NSUInteger)index;
{
    self = [super initForAutoLayout];
    if (self)
    {
        self.delegate = delegate;
        self.itemsInfo = itemsInfo;
        self.currentSelectedIndex = index;
        self.buttons = [NSMutableArray array];
    }
    return self;
}

- (void)initialize
{
    UIButton *tempButton = nil;
    CGFloat buttonWidth = self.frame.size.width/self.itemsInfo.count;
    for (int i =0; i<self.itemsInfo.count; i++)
    {
        GSCardsSelectViewItemInfo *info = [self.itemsInfo objectAtIndex:i];
        UIButton *button = [[UIButton alloc] initForAutoLayout];
        button.tag = i;
        [self addSubview:button];
        
        if (i == self.currentSelectedIndex)
        {
            button.selected = YES;
        }

        [button setAttributedTitle:[self attributeTextForSelectedItem:info] forState:UIControlStateSelected];
        [button setTitle:info.title forState:UIControlStateNormal];
        [button setTitleColor:[GSColor registerPhoneTextFieldColor] forState:UIControlStateNormal];
        [button autoPinEdge:ALEdgeLeft toEdge:(tempButton != nil?ALEdgeRight:ALEdgeLeft) ofView:(tempButton != nil?tempButton:self)];
        [button autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self];
        [button autoSetDimensionsToSize:CGSizeMake(buttonWidth, self.frame.size.height - kUnderLineHeight)];
        
        
        if (tempButton)
        {
            UIView *seperateLine = [[UIView alloc] initForAutoLayout];
            seperateLine.backgroundColor = [GSColor registerTextColor];
            [button addSubview:seperateLine];
            [seperateLine autoSetDimensionsToSize:CGSizeMake(kSeperateLineWidth, self.frame.size.height - 2* kSeperateLineTopPadding)];
            [seperateLine autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:button];
            [seperateLine autoPinEdge: ALEdgeTop toEdge:ALEdgeTop ofView:button withOffset:kSeperateLineTopPadding];
        }
        
        
        [button addTarget:self action:@selector(didTapButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.buttons addObject:button];
        tempButton = button;
        button = nil;
        
    }
    
    
    self.underLine = [[UIView alloc] initForAutoLayout];
    self.underLine.backgroundColor = [GSColor registerTextColor];
    [self addSubview:self.underLine];
    [self.underLine autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self];
    [self.underLine autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self];
    [self.underLine autoSetDimensionsToSize:CGSizeMake(self.frame.size.width, kUnderLineHeight)];
    
    self.underSelectedLine = [[UIView alloc] initForAutoLayout];
    self.underSelectedLine.backgroundColor = [GSColor mainColor];
    [self addSubview:self.underSelectedLine];
    [self.underSelectedLine autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self];
    self.underSelectedLineLeftConstraint = [self.underSelectedLine autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self withOffset:self.currentSelectedIndex * buttonWidth];
    [self.underSelectedLine autoSetDimensionsToSize:CGSizeMake(buttonWidth, kUnderLineHeight)];
    
}

- (NSAttributedString *)attributeTextForSelectedItem:(GSCardsSelectViewItemInfo *)itemInfo
{
    assert(itemInfo);
    NSMutableAttributedString *attributeText = [[NSMutableAttributedString alloc] initWithString:itemInfo.title];

    UIColor *foregroundColor = [GSColor mainColor];
    NSDictionary *attrsDic = @{NSForegroundColorAttributeName: foregroundColor,
                               };
    
    [attributeText addAttributes:attrsDic range:NSMakeRange(0, attributeText.length)];
    return [attributeText copy];
}

#pragma mark - Action

- (void)didTapButton:(id)sender
{
    UIButton *button = (UIButton *)sender;
    _currentSelectedIndex = button.tag;
    
    self.underSelectedLineLeftConstraint.constant = self.currentSelectedIndex * self.frame.size.width / self.itemsInfo.count;
    [UIView animateWithDuration:0.3 animations:^{
        [self layoutIfNeeded];
    }completion:^(BOOL finished) {
        if ([self.delegate respondsToSelector:@selector(cardView:didSelectIndex:)])
        {
            [self.delegate cardView:self didSelectIndex:button.tag];
        }
    }];
    
}

- (void)setCurrentSelectedIndex:(NSUInteger)currentSelectedIndex
{
    _currentSelectedIndex = currentSelectedIndex;
    
    [self.buttons enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *button = obj;
        if (button.tag == _currentSelectedIndex)
        {
            button.selected = YES;
        }else
        {
            button.selected = NO;
        }
    }];
    self.underSelectedLineLeftConstraint.constant = self.currentSelectedIndex * self.frame.size.width / self.itemsInfo.count;
    [UIView animateWithDuration:0.3 animations:^{
        [self layoutIfNeeded];
    }];
}

@end
