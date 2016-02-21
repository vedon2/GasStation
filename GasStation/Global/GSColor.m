//
//  GSColor.m
//  GasStation
//
//  Created by vedon on 2/21/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import "GSColor.h"
#import "UIColor+YYAdd.h"

@implementation GSColor

+ (UIColor *)mainColor
{
    return [UIColor colorWithHexString:@"d43c33"];
}

+ (UIColor *)registerPhoneTextFieldColor
{
    return [UIColor colorWithHexString:@"333333"];
}

+ (UIColor*)registerTextColor
{
    return [UIColor colorWithHexString:@"cccccc"];
}

@end
