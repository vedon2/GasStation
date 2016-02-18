//
//  UCKeyframeAnimation.m
//  AHEasing
//
//  Created by lijun on 15/7/28.
//  Copyright (c) 2015年 Auerhaus Development, LLC. All rights reserved.
//

#import "UCKeyframeAnimation.h"

@interface UCKeyframeAnimation()

@property (nonatomic) int frameCount;

@end

@implementation UCKeyframeAnimation

- (void)dealloc
{
    self.fromValue = nil;
    self.toValue = nil;
    
    [super dealloc];
}

- (void)buildAnimation
{
    if(self.duration <= 0)
    {
        return;
    }
    self.frameCount = 60 * self.duration;
    if(self.frameCount == 0) self.frameCount = 1;
    
    if(self.fromValue && [self.fromValue class] == [self.toValue class])
    {
        //float 
        if([self.fromValue isKindOfClass:[NSNumber class]])
        {
            [self buildScalarAnimation];
        }
        else if([self.fromValue isKindOfClass:[NSValue class]])
        {
            if(strcmp([(NSValue*)self.fromValue objCType], @encode(CGSize)) == 0)
            {
                [self buildSizeAnimation];
            }
            else if(strcmp([(NSValue*)self.fromValue objCType], @encode(CGPoint)) == 0)
            {
                [self buildPointAnimaiton];
            }
            else if(strcmp([(NSValue*)self.fromValue objCType], @encode(CGAffineTransform)) == 0)
            {
                [self buildAffineTransformAnimation];
            }
        }
    }
}

- (CGFloat)valueForTime:(CGFloat)t
{
    if(self.factorFunction)
    {
        return self.factorFunction(t,self.factor);
    }
    else if(self.easingFunction)
    {
        return self.easingFunction(t);
    }
    return t;
}

- (void)buildScalarAnimation
{
    CGFloat fromValue = [self.fromValue floatValue];
    CGFloat toValue = [self.toValue floatValue];
    NSMutableArray *values = [NSMutableArray arrayWithCapacity:self.frameCount];
    CGFloat t = 0.0;
    CGFloat dt = 1.0 / (self.frameCount - 1);
    for(int frame = 0; frame < self.frameCount; ++frame, t += dt)
    {
        CGFloat value = fromValue + [self valueForTime:t] * (toValue - fromValue);
        [values addObject:[NSNumber numberWithFloat:(float)value]];
    }
    
    [self setValues:values];
}

- (void)buildSizeAnimation
{
    NSMutableArray *values = [NSMutableArray arrayWithCapacity:self.frameCount];
    
    CGFloat t = 0.0;
    CGFloat dt = 1.0 / (self.frameCount - 1);
    CGSize fromValue = [self.fromValue CGSizeValue];
    CGSize toValue = [self.toValue CGSizeValue];
    for(int frame = 0; frame < self.frameCount; ++frame, t += dt)
    {
        CGFloat w = fromValue.width + [self valueForTime:t] * (toValue.width - fromValue.width);
        CGFloat h = fromValue.height + [self valueForTime:t] * (toValue.height - fromValue.height);
        [values addObject:[NSValue valueWithCGSize:CGSizeMake(w, h)]];
    }
    
    [self setValues:values];
}

- (void)buildPointAnimaiton
{
    NSMutableArray *values = [NSMutableArray arrayWithCapacity:self.frameCount];
    
    CGFloat t = 0.0;
    CGFloat dt = 1.0 / (self.frameCount - 1);
    CGPoint fromValue = [self.fromValue CGPointValue];
    CGPoint toValue = [self.toValue CGPointValue];
    for(size_t frame = 0; frame < self.frameCount; ++frame, t += dt)
    {
        CGFloat x = fromValue.x + [self valueForTime:t] * (toValue.x - fromValue.x);
        CGFloat y = fromValue.y + [self valueForTime:t] * (toValue.y - fromValue.y);
        [values addObject:[NSValue valueWithCGPoint:CGPointMake(x, y)]];
    }
    
    [self setValues:values];
}

- (void)buildAffineTransformAnimation
{
    NSMutableArray *values = [NSMutableArray arrayWithCapacity:self.frameCount];
    
    CGAffineTransform fromTransform = [self.fromValue CGAffineTransformValue];
    CGAffineTransform toTransform = [self.toValue CGAffineTransformValue];
    
    CGPoint fromTranslation = CGPointMake(fromTransform.tx, fromTransform.ty);
    CGPoint toTranslation = CGPointMake(toTransform.tx, toTransform.ty);
    
    CGFloat fromScale = hypot(fromTransform.a, fromTransform.c);
    CGFloat toScale = hypot(toTransform.a, toTransform.c);
    
    CGFloat fromRotation = atan2(fromTransform.c, fromTransform.a);
    CGFloat toRotation = atan2(toTransform.c, toTransform.a);
    
    CGFloat deltaRotation = toRotation - fromRotation;
    
    if (deltaRotation < -M_PI)
        deltaRotation += (2 * M_PI);
    else if (deltaRotation > M_PI)
        deltaRotation -= (2 * M_PI);
    
    CGFloat t = 0.0;
    CGFloat dt = 1.0 / (self.frameCount - 1);
    for(size_t frame = 0; frame < self.frameCount; ++frame, t += dt)
    {
        CGFloat interp = [self valueForTime:t];
        
        CGFloat translateX = fromTranslation.x + interp * (toTranslation.x - fromTranslation.x);
        CGFloat translateY = fromTranslation.y + interp * (toTranslation.y - fromTranslation.y);
        
        CGFloat scale = fromScale + interp * (toScale - fromScale);
        
        CGFloat rotate = fromRotation + interp * deltaRotation;
        
        CGAffineTransform affineTransform = CGAffineTransformMake(scale * cos(rotate), -scale * sin(rotate),
                                                                  scale * sin(rotate), scale * cos(rotate),
                                                                  translateX, translateY);
        
        CATransform3D transform = CATransform3DMakeAffineTransform(affineTransform);
        
        [values addObject:[NSValue valueWithCATransform3D:transform]];
    }
    
    [self setValues:values];
}
@end
