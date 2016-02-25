//
// Copyright 2009-2010 Facebook
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
//#import "../../iStdafx.h"
#import "UIViewAdditions.h"
//#import "NSObject_Event.h"
#import "UCFDNDevice.h"
#import "SystemUtility.h"

/*
#ifdef UC_IMAGE_CACHE
#import "UIImage_cache.h"
#endif
*/
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation UIView (TTCategory)


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)left {
    return self.frame.origin.x;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setLeft:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)top {
    return self.frame.origin.y;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setTop:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)centerX {
    return self.center.x;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setCenterX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)centerY {
    return self.center.y;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)width {
    return self.frame.size.width;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)height {
    return self.frame.size.height;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)ttScreenX {
    CGFloat x = 0;
    for (UIView* view = self; view; view = view.superview) {
        x += view.left;
    }
    return x;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)ttScreenY {
    CGFloat y = 0;
    for (UIView* view = self; view; view = view.superview) {
        y += view.top;
    }
    return y;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)screenViewX {
    CGFloat x = 0;
    for (UIView* view = self; view; view = view.superview) {
        x += view.left;
        
        if ([view isKindOfClass:[UIScrollView class]]) {
            UIScrollView* scrollView = (UIScrollView*)view;
            x -= scrollView.contentOffset.x;
        }
    }
    
    return x;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)screenViewY {
    CGFloat y = 0;
    for (UIView* view = self; view; view = view.superview) {
        y += view.top;
        
        if ([view isKindOfClass:[UIScrollView class]]) {
            UIScrollView* scrollView = (UIScrollView*)view;
            y -= scrollView.contentOffset.y;
        }
    }
    return y;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGRect)screenFrame {
    return CGRectMake(self.screenViewX, self.screenViewY, self.width, self.height);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGPoint)originPoint {
    return self.frame.origin;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setOriginPoint:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGSize)size {
    return self.frame.size;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)orientationWidth {
    //  return UIInterfaceOrientationIsLandscape(TTInterfaceOrientation())
    //    ? self.height : self.width;
	return 0;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)orientationHeight {
    //  return UIInterfaceOrientationIsLandscape(TTInterfaceOrientation())
    //    ? self.width : self.height;
	return 0;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (UIView*)descendantOrSelfWithClass:(Class)cls {
    if ([self isKindOfClass:cls])
        return self;
    
    for (UIView* child in self.subviews) {
        UIView* it = [child descendantOrSelfWithClass:cls];
        if (it)
            return it;
    }
    
    return nil;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (UIView*)ancestorOrSelfWithClass:(Class)cls {
    if ([self isKindOfClass:cls]) {
        return self;
    } else if (self.superview) {
        return [self.superview ancestorOrSelfWithClass:cls];
    } else {
        return nil;
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)removeAllSubviews
{
    while (self.subviews.count) {
        UIView* child = self.subviews.lastObject;
        [child removeFromSuperview];
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGPoint)offsetFromView:(UIView*)otherView {
    CGFloat x = 0, y = 0;
    for (UIView* view = self; view && view != otherView; view = view.superview) {
        x += view.left;
        y += view.top;
    }
    return CGPointMake(x, y);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (UIViewController*)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

+ (CGSize)keyboardSizeForKeyboardNotification:(NSNotification *)notification
{
    NSDictionary *info = [notification userInfo];
    NSValue *beginValue = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGSize keyboardSize = [beginValue CGRectValue].size;
    
    if ([self isNeedToFixScreenSize])
    {
        CGFloat temp = keyboardSize.height;
        keyboardSize.height = keyboardSize.width;
        keyboardSize.width = temp;
    }
    
    return keyboardSize;
}

// IOS8后横屏屏幕大小回归正常化
+ (BOOL)isNeedToFixScreenSize
{
#ifdef __IPHONE_8_0
    return [UCFDNDevice systemVersion] < 8.0f && UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation);
#else
    return UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation);
#endif
}

+ (CGRect)screenBounds
{
    CGRect bounds = [UIScreen mainScreen].bounds;
    
    if ([self isNeedToFixScreenSize])
    {
        CGFloat height = bounds.size.width;
        bounds.size.width = bounds.size.height;
        bounds.size.height = height;
    }
    
    return bounds;
}

+ (CGSize)getAppFrameSize
{
	CGSize frameSize = [UIScreen mainScreen].applicationFrame.size;
    
    if ([self isNeedToFixScreenSize])
    {
        frameSize = CGSizeMake(frameSize.height, frameSize.width);
    }
    
    return frameSize;
}

+ (CGRect)getAppFrameBounds
{
	CGSize appFrameSize = [UIView getAppFrameSize];
	return CGRectMake(0, 0, appFrameSize.width, appFrameSize.height);
}

+ (CGRect)getAppFrame
{
	CGRect appFrame = [UIScreen mainScreen].applicationFrame;
	appFrame.size = [UIView getAppFrameSize];
	return appFrame;
}

+ (BOOL)isInterfacePortrait
{
    BOOL isPortrait = NO;
    
    if (iGetSystemVersion() > 8.99)
    {
        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
        isPortrait = (window.frame.size.width < window.frame.size.height);
    }
    else
    {
        //statusBarOriention 9.0及以后被废弃
        UIInterfaceOrientation io = [[UIApplication sharedApplication] statusBarOrientation];
        isPortrait =  (io == UIInterfaceOrientationPortrait || io == UIInterfaceOrientationPortraitUpsideDown) ? YES : NO;
    }
    
    return isPortrait;
}

+ (void)postAnOrientationChangedNotification
{
    const NSNumber *value = [NSNumber numberWithBool: YES];
    const NSString *key = @"UIDeviceOrientationRotateAnimatedUserInfoKey";
    
    NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:value, key, Nil];
    
    NSNotification *notif = [NSNotification notificationWithName: UIDeviceOrientationDidChangeNotification
                                                          object: [UIDevice currentDevice]
                                                        userInfo: userInfo];
    
    [[NSNotificationCenter defaultCenter] postNotification: notif];
}

+ (BOOL)isKeyboardShowing
{
	UIWindow* keyWindow = [[UIApplication sharedApplication] keyWindow];
	
	UIView* firstResponder = [self findFirstResponder:keyWindow];
	
	BOOL bRet = [firstResponder isKindOfClass:[UITextField class]];
	if (!bRet)
	{
		bRet = [firstResponder isKindOfClass:[UITextView class]];
	}
	
	return bRet;
}

+ (void)dismissGlobalKeyboard
{
	BOOL bRet = [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
	if (!bRet)
	{
		UIWindow* keyWindow = [[UIApplication sharedApplication] keyWindow];
		
		UIView* firstResponder = [self findFirstResponder:keyWindow];
		[firstResponder resignFirstResponder];
	}
}

+ (UIView*)findFirstResponder:(UIView*)topView
{
    if ([topView isFirstResponder])
    {
        return topView;
    }
    
    UIView* firstResponder = nil;
    NSArray* sv = topView.subviews;
    for (UIView* v in sv)
    {
        firstResponder = [self findFirstResponder:v];
        if (firstResponder != nil)
        {
            break;
        }
    }
    
    return firstResponder;
}

- (UIView*)subviewWithTag:(NSInteger)tag
{
	for (UIView* aSubview in self.subviews)
	{
		if (aSubview.tag == tag)
		{
			return aSubview;
		}
	}
	
	return nil;
}

+ (UIView*)getRootview
{
	UIView* rootView = nil;
	UIApplication* application = [UIApplication sharedApplication];
	for (UIView* view in application.keyWindow.subviews)
	{
		if ([view isKindOfClass:[UIView class]])
		{
			rootView = view;
			break;
		}
	}
	
	return rootView;
}

- (UIView*)findSubiewOfClassName:(NSString*)className
{
	for (UIView* aSubview in self.subviews)
	{
		if ([[[aSubview class] description] isEqualToString:className])
		{
			return aSubview;
		}
		else
		{
			UIView* result = [aSubview findSubiewOfClassName:className];
			if (result)
			{
				return result;
			}
		}
	}
	
	return nil;
}

@end



/**
 * Additions.
 */
@implementation UIFont (TTCategory)


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)ttLineHeight {
	return (self.ascender - self.descender) + 1;
}

@end

@implementation UIButton (UCWEB)
- (void)removeAllTargets
{
	[self removeTarget:nil 
                action:NULL 
      forControlEvents:UIControlEventAllEvents]; 
}
@end

@implementation CALayer (CleanUp)

- (void)cleanUpLayerContents
{
	if (![self.delegate isKindOfClass:[UIScrollView class]]
		&& ![self.delegate isKindOfClass:[UIImageView class]])
	{
		self.contents = nil;
	}
	
    for (CALayer* sublayer in self.sublayers)
    {
        [sublayer cleanUpLayerContents];
    }
}

@end

#ifndef __IPHONE_7_0

@protocol CompilerSilencer <NSObject>

- (void)drawViewHierarchyInRect:(CGRect)rect afterScreenUpdates:(BOOL)shouldUpdate;

@end

#endif

@implementation UIView (Capture)

- (UIImage*)snapshotImageInRect:(CGRect)rect
{
	if (CGRectIsEmpty(rect))
	{
		rect = self.bounds;
	}
	
    UIImage *img = nil;
    
    UIGraphicsBeginImageContextWithOptions(rect.size, self.opaque, 0.0);
	CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    if (ctx != nil)
    {
        CGContextTranslateCTM(ctx, -rect.origin.x, -rect.origin.y);
        
        if ([self respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)])
        {
            // iOS7
            UIView* superview = self.superview;
            NSUInteger index = [self.superview.subviews indexOfObject:self];
            
            FAUXPAS_IGNORED_ON_LINE(APIAvailability)[(id)self drawViewHierarchyInRect:self.bounds afterScreenUpdates:NO];
            
            [superview insertSubview:self atIndex:index];
        }
        else
        {
            [self.layer renderInContext:ctx];
        }
        
        img = UIGraphicsGetImageFromCurrentImageContext();
    }

    UIGraphicsEndImageContext();
    
    return img;
}

- (UIImage*)oldSnapshotImageInRect:(CGRect)rect
{
    if (CGRectIsEmpty(rect))
	{
		rect = self.bounds;
	}
	
    UIGraphicsBeginImageContextWithOptions(rect.size, self.opaque, 0.0);
	CGContextRef ctx = UIGraphicsGetCurrentContext();
	CGContextTranslateCTM(ctx, -rect.origin.x, -rect.origin.y);
	
    [self.layer renderInContext:ctx];
	
	UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}

@end

@implementation UIView (UCAnimate)

- (void)rotate
{
    [self rotateWithDuration:1];
}

- (void)rotateWithDuration:(double)duration
{
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation.duration = duration;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = HUGE_VALF;
    
    [self.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}
@end


