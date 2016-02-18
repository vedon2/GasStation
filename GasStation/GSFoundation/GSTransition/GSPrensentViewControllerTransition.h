//
//  GSPrensentViewControllerTransition.h
//  GasStation
//
//  Created by vedon on 2/18/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZFModalTransitionAnimator.h"

@interface GSPrensentViewControllerTransition : NSObject

+ (id<UIViewControllerTransitioningDelegate>)defaultTransitionWithViewController:(UIViewController *)controller;

@end
