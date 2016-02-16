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
@property (nonatomic,strong) UIButton *searchBtn;
@end

@implementation GSMapSearchBtn

- (instancetype)initWithDelegate:(id<GSMapSearchBtnDelegate>)delegate
{
    self = [super initForAutoLayout];
    if (self)
    {
        self.delegate = delegate;
        
        [self addSubview:self.searchBtn];
        [self.searchBtn autoPinEdgesToSuperviewEdges];
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

- (UIButton *)searchBtn
{
    if (!_searchBtn)
    {
        _searchBtn = [[UIButton alloc] initForAutoLayout];
        [_searchBtn addTarget:self action:@selector(didTapSearchBtn) forControlEvents:UIControlEventTouchUpInside];
        _searchBtn.backgroundColor = [UIColor redColor];
    }
    return  _searchBtn;
}

@end
