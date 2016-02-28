//
//  GSColor.h
//  GasStation
//
//  Created by vedon on 2/21/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface GSColor : NSObject

+ (UIColor *)mainColor;

+ (UIColor *)registerButtonSelectedColor;

+ (UIColor *)registerPhoneTextFieldColor;

+ (UIColor *)registerTextColor;

+ (UIColor *)forgetPwdTextFieldIndicatorTextColor;


//用户中心
+ (UIColor *)userCenterBackgroundColor;

+ (UIColor *)userCenterCollectionCellTextColor;

//加油站
+ (UIColor *)cardDetailSubTitleColor;

+ (UIColor *)cardDetailTitleColor;

//GSCardTableViewCell
+ (UIColor *)firstCardDetailButtonColor;

+ (UIColor *)secondCardDetailButtonColor;
@end
