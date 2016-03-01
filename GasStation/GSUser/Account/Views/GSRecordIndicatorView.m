//
//  GSRecordIndicatorView.m
//  GasStation
//
//  Created by vedon on 3/2/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import "GSRecordIndicatorView.h"

@interface GSRecordIndicatorView ()
@property (nonatomic,strong) UIImageView *microphoneImageView;
@property (nonatomic,strong) UILabel *indicatorLabel;
@end

@implementation GSRecordIndicatorView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self addSubview:self.microphoneImageView];
        
    }
    return self;
}

#pragma mark - Public

- (void)startAnimation
{
    [self.microphoneImageView startAnimating];
}

- (void)stopAnimation
{
    [self.microphoneImageView stopAnimating];
}

#pragma mark - Getter & Setter

- (UIImageView *)microphoneImageView
{
    if (!_microphoneImageView)
    {
        _microphoneImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 60)];
        _microphoneImageView.backgroundColor = [UIColor clearColor];
        
        NSMutableArray *animationImages = [NSMutableArray array];
        for (int i = 0; i< 10; i++) {
            NSString *imageName = [NSString stringWithFormat:@"icon_voice_%d",i];
            [animationImages addObject:[UIImage imageNamed:imageName]];
        }
        _microphoneImageView.animationImages = animationImages;
    }
    
    return _microphoneImageView;
}

@end
