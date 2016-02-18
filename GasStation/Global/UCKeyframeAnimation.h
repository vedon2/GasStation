//
//  UCKeyframeAnimation.h
//  AHEasing
//
//  Created by lijun on 15/7/28.
//  Copyright (c) 2015年 Auerhaus Development, LLC. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#include "easing.h"

@interface UCKeyframeAnimation : CAKeyframeAnimation

@property (nonatomic,retain) id fromValue;
@property (nonatomic,retain) id toValue;

//普通动画
@property (nonatomic) AHEasingFunction easingFunction;

//带因子的动画，目前支持的back相关动画
@property (nonatomic) float factor;
@property (nonatomic) AHEasingFactorFunction factorFunction;

- (void)buildAnimation;

@end
