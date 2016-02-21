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

+ (UIColor *)registerButtonSelectedColor
{
    return [UIColor colorWithHexString:@"c8332a"];
}

+ (UIColor *)registerPhoneTextFieldColor
{
    return [UIColor colorWithHexString:@"333333"];
}

+ (UIColor*)registerTextColor
{
    return [UIColor colorWithHexString:@"cccccc"];
}

+ (UIColor *)forgetPwdTextFieldIndicatorTextColor
{
    return [UIColor colorWithHexString:@"666666"];
}

+ (UIColor *)userCenterBackgroundColor
{
    return [UIColor colorWithHexString:@"efeff4"];
}

+ (UIColor *)userCenterCollectionCellTextColor
{
    return [UIColor colorWithHexString:@"666666"];
}

@end