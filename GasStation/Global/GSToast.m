//
//  GSToast.m
//  GasStation
//
//  Created by vedon on 2/26/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import "GSToast.h"
#import "MBProgressHUD.h"
@implementation GSToast


+ (void)showToastWithText:(NSString *)text inView:(UIView *)view
{
    assert(view);
    
    MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hub.mode = MBProgressHUDModeText;
    hub.labelText = text;
    [hub hide:YES afterDelay:2.f];

}

+ (void)showProgressToastInView:(UIView *)view
{
    [MBProgressHUD showHUDAddedTo:view animated:YES];
}

+ (void)hideProgressToastInView:(UIView *)view
{
    [MBProgressHUD hideHUDForView:view animated:YES];
}

@end
