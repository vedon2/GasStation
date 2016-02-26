//
//  GSToast.h
//  GasStation
//
//  Created by vedon on 2/26/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GSToast : NSObject

+ (void)showToastWithText:(NSString *)text inView:(UIView *)view;

+ (void)showProgressToastInView:(UIView *)view;

+ (void)hideProgressToastInView:(UIView *)view;

@end
