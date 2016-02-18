//
//  GSPrensentViewControllerTransition.m
//  GasStation
//
//  Created by vedon on 2/18/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import "GSPrensentViewControllerTransition.h"



@implementation GSPrensentViewControllerTransition

+ (id<UIViewControllerTransitioningDelegate>)defaultTransitionWithViewController:(UIViewController *)controller
{
    ZFModalTransitionAnimator *animator = [[ZFModalTransitionAnimator alloc] initWithModalViewController:controller];
    animator.dragable = YES;
    animator.bounces = NO;
    animator.behindViewAlpha = 0.9f;
    animator.behindViewScale = 1.0f;
    animator.transitionDuration = 0.5f;
    animator.direction = ZFModalTransitonDirectionRight;
    return animator;
}

@end
