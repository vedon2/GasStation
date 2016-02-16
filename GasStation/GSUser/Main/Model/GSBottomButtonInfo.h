//
//  GSBottomButtonInfo.h
//  GasStation
//
//  Created by vedon on 2/11/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GSBottomButtonInfo : NSObject

@property (nonatomic,strong,readonly) NSString *title;
@property (nonatomic,strong,readonly) UIImage *image;

- (instancetype)initWithTitle:(NSString *)title image:(UIImage *)image;

@end
