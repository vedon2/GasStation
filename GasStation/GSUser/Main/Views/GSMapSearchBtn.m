//
//  GSMapSearchBtn.m
//  GasStation
//
//  Created by vedon on 2/12/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import "GSMapSearchBtn.h"
#import "PureLayout.h"

@interface GSMapSearchBtn ()
@property (nonatomic,strong) UIImageView *searchBtn;
@end

@implementation GSMapSearchBtn

- (instancetype)initWithDelegate:(id<GSMapSearchBtnDelegate>)delegate image:(UIImage *)image edgeInset:(UIEdgeInsets)inset
{
    self = [super initForAutoLayout];
    if (self)
    {
        self.delegate = delegate;
        self.searchBtn.image = image;
        [self addSubview:self.searchBtn];
        [self.searchBtn autoPinEdgesToSuperviewEdgesWithInsets:inset];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapSearchBtn)];
        [self addGestureRecognizer:tap];
        tap = nil;
        
    }
    return self;
}

- (void)didTapSearchBtn
{
    if ([self.delegate respondsToSelector:@selector(didTapSearchBtn)])
    {
        [self.delegate didTapSearchBtn];
    }
}

#pragma mark - Getter & Setter 

- (UIImageView *)searchBtn
{
    if (!_searchBtn)
    {
        _searchBtn = [[UIImageView alloc] initForAutoLayout];
        _searchBtn.backgroundColor = [UIColor redColor];
        _searchBtn.contentMode = UIViewContentModeScaleAspectFit;
    }
    return  _searchBtn;
}

@end
