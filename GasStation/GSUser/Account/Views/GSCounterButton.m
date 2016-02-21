//
//  GSCounterButton.m
//  GasStation
//
//  Created by vedon on 2/20/16.
//  Copyright © 2016 vedon. All rights reserved.
//
#define kCounterLoop 60

#import "GSCounterButton.h"
#import "PureLayout.h"
#import "GSColor.h"


@interface GSCounterButton ()
@property (nonatomic,strong) UIButton *counterButton;
@property (nonatomic,strong) NSTimer *counterTimer;
@property (nonatomic,assign) NSInteger counterLoop;
@end

@implementation GSCounterButton

- (instancetype)initWithImage:(UIImage *)image counterText:(NSString *)text delegate:(id<GSCountetButtonDelegate>)delegate
{
    self = [super init];
    if (self)
    {
        self.delegate = delegate;
        self.counterButton.imageView.image = image;
        [self.counterButton setTitle:text forState:UIControlStateNormal];
        self.counterLoop = kCounterLoop;
    }
    return self;
}

- (void)initialize
{
    
    [self addSubview:self.counterButton];
    [self.counterButton autoPinEdgesToSuperviewEdges];
}

- (void)didTapCounterButton:(id)sender
{
    [self startCounter];
    self.counterButton.enabled = NO;
}

#pragma mark - Public

- (void)startCounter
{
    [self stopCounter];
    
    self.counterLoop = kCounterLoop;
    self.counterLoop -= 1;
    self.counterTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    
}

- (void)stopCounter
{
    [self releaseTimer];
}

#pragma mark - Private

- (void)timerAction
{
    NSString *counterText = nil;
    if (self.counterLoop == 0)
    {
        counterText = @"重发";
        self.counterButton.enabled = YES;
        [self stopCounter];
    }
    else
    {
        counterText = [NSString stringWithFormat:@"重发 %ld秒",(long)self.counterLoop];
        self.counterLoop -= 1;
    }
    [self.counterButton setTitle:counterText forState:UIControlStateNormal];
}

- (void)releaseTimer
{
    if (self.counterTimer)
    {
        if (self.counterTimer.isValid)
        {
            [self.counterTimer invalidate];
        }
        
        self.counterTimer = nil;
    }
}

#pragma mark - Getter & Setter

//- (UIImageView *)bgImageView
//{
//    if (!_bgImageView)
//    {
//        _bgImageView = [[UIImageView alloc] initForAutoLayout];
//        _bgImageView.backgroundColor = [UIColor purpleColor];
//        _bgImageView.contentMode = UIViewContentModeScaleAspectFit;
//    }
//    return _bgImageView;
//}
//
//- (UILabel *)counterLabel
//{
//    if (!_counterLabel)
//    {
//        _counterLabel = [[UILabel alloc] initForAutoLayout];
//        _counterLabel.textColor = [UIColor lightGrayColor];
//        _counterLabel.backgroundColor = [UIColor clearColor];
//        _counterLabel.font = [UIFont systemFontOfSize:14];
//    }
//    return _counterLabel;
//}

- (UIButton *)counterButton
{
    if (!_counterButton)
    {
        _counterButton = [[UIButton alloc] initForAutoLayout];
        [_counterButton addTarget:self action:@selector(didTapCounterButton:) forControlEvents:UIControlEventTouchUpInside];
        [_counterButton setTitleColor:[GSColor registerTextColor] forState:UIControlStateNormal];
        _counterButton.titleLabel.font = [UIFont systemFontOfSize:14];
        _counterButton.layer.cornerRadius = 6.0;
        _counterButton.layer.borderColor = [[GSColor registerTextColor] CGColor];
        _counterButton.layer.borderWidth = 1.0;
    }
    return _counterButton;
}

@end
