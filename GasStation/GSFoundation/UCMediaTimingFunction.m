//
//  case UCMediaTimingFunction.m
//  UCUIKit
//
//  Created by lijun on 15/7/24.
//  Copyright (c) 2015年 samuelyang. All rights reserved.
//

#import "UCMediaTimingFunction.h"

@implementation UCMediaTimingFunction

+ (CAMediaTimingFunction *)mediaTimingFunctionForMode:(UCMediaTimingFunctionMode)mode
{
    switch (mode) {
        case UCMediaTimingQuadraticEaseIn:
            return [CAMediaTimingFunction functionWithControlPoints:0.55: 0.085: 0.68: 0.53];
        case UCMediaTimingQuadraticEaseOut:
            return [CAMediaTimingFunction functionWithControlPoints:0.25: 0.46: 0.45: 0.94];
        case UCMediaTimingQuadraticEaseInOut:
            return [CAMediaTimingFunction functionWithControlPoints:0.455: 0.03: 0.515: 0.955];
        case UCMediaTimingCubicEaseIn:
            return [CAMediaTimingFunction functionWithControlPoints:0.55: 0.055: 0.675: 0.19];
        case UCMediaTimingCubicEaseOut:
            return [CAMediaTimingFunction functionWithControlPoints:0.215: 0.61: 0.355: 1];
        case UCMediaTimingCubicEaseInOut:
            return [CAMediaTimingFunction functionWithControlPoints:0.645: 0.045: 0.355: 1];
        case UCMediaTimingQuarticEaseIn:
            return [CAMediaTimingFunction functionWithControlPoints:0.895: 0.03: 0.685: 0.22];
        case UCMediaTimingQuarticEaseOut:
            return [CAMediaTimingFunction functionWithControlPoints:0.165: 0.84: 0.44: 1];
        case UCMediaTimingQuarticEaseInOut:
            return [CAMediaTimingFunction functionWithControlPoints:0.77: 0: 0.175: 1];
        case UCMediaTimingQuinticEaseIn:
            return [CAMediaTimingFunction functionWithControlPoints:0.755: 0.05: 0.855: 0.06];
        case UCMediaTimingQuinticEaseOut:
            return [CAMediaTimingFunction functionWithControlPoints:0.23: 1: 0.32: 1];
        case UCMediaTimingQuinticEaseInOut:
            return [CAMediaTimingFunction functionWithControlPoints:0.86: 0: 0.07: 1];
        case UCMediaTimingSineEaseIn:
            return [CAMediaTimingFunction functionWithControlPoints:0.47 :0 :0.745 :0.715];
        case UCMediaTimingSineEaseOut:
            return [CAMediaTimingFunction functionWithControlPoints:0.39 :0.575 :0.565 :1];
        case UCMediaTimingSineEaseInOut:
            return [CAMediaTimingFunction functionWithControlPoints:0.445 :0.05 :0.55 :0.95];
        case UCMediaTimingCircularEaseIn:
            return [CAMediaTimingFunction functionWithControlPoints:0.6: 0.04: 0.98: 0.335];
        case UCMediaTimingCircularEaseOut:
            return [CAMediaTimingFunction functionWithControlPoints:0.075: 0.82: 0.165: 1];
        case UCMediaTimingCircularEaseInOut:
            return [CAMediaTimingFunction functionWithControlPoints:0.785: 0.135: 0.15: 0.86];
        case UCMediaTimingExpoEaseIn:
            return [CAMediaTimingFunction functionWithControlPoints:0.95: 0.05: 0.795: 0.035];
        case UCMediaTimingExpoEaseOut:
            return [CAMediaTimingFunction functionWithControlPoints:0.19: 1: 0.22: 1];
        case UCMediaTimingExpoEaseInOut:
            return [CAMediaTimingFunction functionWithControlPoints:1: 0: 0: 1];
        case UCMediaTimingBackEaseIn:
            return [CAMediaTimingFunction functionWithControlPoints:0.6: -0.28: 0.735: 0.045];
        case UCMediaTimingBackEaseOut:
            return [CAMediaTimingFunction functionWithControlPoints:0.175: 0.885: 0.32: 1.275];
        case UCMediaTimingBackEaseInOut:
            return [CAMediaTimingFunction functionWithControlPoints:0.68: -0.55: 0.265: 1.55];
        default:
            return nil;
    }
}

@end
