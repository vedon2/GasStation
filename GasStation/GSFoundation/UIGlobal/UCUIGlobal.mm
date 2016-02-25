/*
 *****************************************************************************
 * Copyright (C) 2005-2014 UC Mobile Limited. All Rights Reserved
 * File			: UCUIGlobal.mm
 *
 * Description	: UCUIGlobal
 *
 * Author		: zengsq@ucweb.com
 *
 * History		: Creation, 14-10-13, zengsq@ucweb.com, Create the file
 ******************************************************************************
 **/

#import "UCUIGlobal.h"
#import "UIViewAdditions.h"

@implementation UCUIGlobal

+ (CGSize)portraitScreenSize
{
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    return CGSizeMake(MIN(screenSize.width, screenSize.height), MAX(screenSize.width, screenSize.height));
}

+ (CGSize)landscapeScreenSize
{
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    return CGSizeMake(MAX(screenSize.width, screenSize.height), MIN(screenSize.width, screenSize.height));
}

+ (BOOL)is35inchDisplay
{
    return [self portraitScreenSize].height < 568;
}

+ (BOOL)is4inchDisplay
{
    return [self portraitScreenSize].height >= 568;
}

+ (BOOL)is47inchDisplay
{
    return [self portraitScreenSize].height >= 667;
}

+ (BOOL)is55inchDisplay
{
    return [self portraitScreenSize].height >= 736;
}

+ (UIWindow *)applicationWindow
{
    return [[[UIApplication sharedApplication] delegate] window];
}

+ (DeviceDisplayType)deviceDisplayType
{
    static DeviceDisplayType type = EUnuseDiaplayType;
    
    if (type == EUnuseDiaplayType) {
        
        type = E35inchDisplayType;
        
        if ([UCUIGlobal is55inchDisplay])
        {
            type = E55inchDisplayType;
        }
        else if([UCUIGlobal is47inchDisplay])
        {
            type = E47inchDisplayType;
        }
        else if([UCUIGlobal is4inchDisplay])
        {
            type = E4inchDisplayType;
        }
    }

    return type;
}

+ (BOOL)isPortraitScreen    ///< 是否竖屏
{
    UIInterfaceOrientation statusBarOrientation = [UIApplication sharedApplication].statusBarOrientation;
    return UIInterfaceOrientationIsPortrait(statusBarOrientation);
}

+ (CGFloat)getStatusHeight
{
    if ([UIApplication sharedApplication].statusBarHidden)
    {
        return 0;
    }
    
    CGRect statusBarFrame = [UIApplication sharedApplication].statusBarFrame;
    CGFloat height = statusBarFrame.size.height;
    
    if ([UIView isNeedToFixScreenSize])
    {
        height = statusBarFrame.size.width;
    }
    
    assert(height < 100);
    return height;
}

+ (CGRect)deviceScreenBounds
{
    CGRect frame = CGRectZero;
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    UIDeviceOrientation orit = [[UIDevice currentDevice] orientation];
    
    CGFloat max = MAX(screenBounds.size.width, screenBounds.size.height);
    CGFloat min = MIN(screenBounds.size.width, screenBounds.size.height);
    
    if (UIDeviceOrientationIsLandscape(orit))
    {
        frame = CGRectMake(0, 0, max, min);
    }
    else
    {
        frame = CGRectMake(0, 0, min, max);
    }
    
    return frame;
}


@end
