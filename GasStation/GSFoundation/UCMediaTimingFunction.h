//
//  UCMediaTimingFunction.h
//  UCUIKit
//
//  Created by lijun on 15/7/24.
//  Copyright (c) 2015年 samuelyang. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum
{
    UCMediaTimingQuadraticEaseIn,
    UCMediaTimingQuadraticEaseOut,
    UCMediaTimingQuadraticEaseInOut,
    
    UCMediaTimingCubicEaseIn,
    UCMediaTimingCubicEaseOut,
    UCMediaTimingCubicEaseInOut,
    
    UCMediaTimingQuarticEaseIn,
    UCMediaTimingQuarticEaseOut,
    UCMediaTimingQuarticEaseInOut,
    
    UCMediaTimingQuinticEaseIn,
    UCMediaTimingQuinticEaseOut,
    UCMediaTimingQuinticEaseInOut,
    
    UCMediaTimingSineEaseIn,
    UCMediaTimingSineEaseOut,
    UCMediaTimingSineEaseInOut,
    
    UCMediaTimingCircularEaseIn,
    UCMediaTimingCircularEaseOut,
    UCMediaTimingCircularEaseInOut,
    
    UCMediaTimingExpoEaseIn,
    UCMediaTimingExpoEaseOut,
    UCMediaTimingExpoEaseInOut,
    
    UCMediaTimingBackEaseIn,
    UCMediaTimingBackEaseOut,
    UCMediaTimingBackEaseInOut,
}UCMediaTimingFunctionMode;

@interface UCMediaTimingFunction : NSObject

+ (CAMediaTimingFunction *)mediaTimingFunctionForMode:(UCMediaTimingFunctionMode)mode;

@end
