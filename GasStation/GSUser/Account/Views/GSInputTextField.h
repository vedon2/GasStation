//
//  GSInputTextField.h
//  GasStation
//
//  Created by vedon on 2/14/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^AccessoryButtonAction)();

@interface GSInputTextField : UIView


- (instancetype)initWithFrame:(CGRect)frame image:(UIImage *)image  placeholderText:(NSString *)placeHolderText accessoryButtonTitle:(NSString *)accessoryButtonTitle accessoryButtonAction:(AccessoryButtonAction)action;


- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title placeholderText:(NSString *)placeholderText accessoryButton:(UIButton *)accessoryButton;

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title placeholderText:(NSString *)placeholderText accessoryButtonTitle:(NSString *)accessoryButtonTitle accessoryButtonAction:(AccessoryButtonAction)action;


- (void)configureWithImage:(UIImage *)image placeholderText:(NSString *)placeHolderText accessoryButtonTitle:(NSString *)accessoryButtonTitle accessoryButtonAction:(AccessoryButtonAction)action;

- (void)configureWithTitle:(NSString *)title placeholderText:(NSString *)placeholderText accessoryButtonTitle:(NSString *)accessoryButtonTitle accessoryButtonAction:(AccessoryButtonAction)action;

- (NSString *)text;


@end
