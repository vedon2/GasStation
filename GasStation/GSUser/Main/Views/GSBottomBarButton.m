//
//  GSBottomBarButton.m
//  GasStation
//
//  Created by vedon on 2/20/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#define kLabelPadding 2
#define kImageViewPadding 3
#import "GSBottomBarButton.h"
#import "PureLayout.h"


@interface GSBottomBarButton ()
@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) UILabel *label;
@end

@implementation GSBottomBarButton

- (instancetype)initWithImage:(UIImage *)image title:(NSString *)title delegate:(id<GSBottomBarButtonDelegate>)delegate
{
    self = [super initForAutoLayout];
    if (self) {
        
        
        self.imageView = [[UIImageView alloc] initForAutoLayout];
        self.imageView.image = image;
        self.imageView.backgroundColor = [UIColor clearColor];
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        self.label = [[UILabel alloc] initForAutoLayout];
        self.label.backgroundColor = [UIColor clearColor];
        self.label.text = title;
        self.label.textColor = [UIColor lightGrayColor];
        self.label.font = [UIFont systemFontOfSize:12];
        self.label.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:self.imageView];
        [self addSubview:self.label];
        [self.imageView autoSetDimensionsToSize:CGSizeMake(15, 15)];
        [self.imageView autoAlignAxis:ALAxisVertical toSameAxisOfView:self];
        [self.imageView autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self withOffset:kImageViewPadding];
        
        [self.label autoAlignAxis:ALAxisVertical toSameAxisOfView:self];
        [self.label autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.imageView withOffset:kLabelPadding];

        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickButton)];
        [self addGestureRecognizer:tapGesture];
        tapGesture = nil;
        
        self.delegate = delegate;
    }
    return self;
}

#pragma mark - Gesture & Acton

- (void)didClickButton
{
    if ([self.delegate respondsToSelector:@selector(buttonDidClick:)])
    {
        [self.delegate buttonDidClick:self];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
