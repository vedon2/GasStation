//
//  GSTextField.h
//  GasStation
//
//  Created by vedon on 2/20/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GSTextField;
@protocol GSTextFieldProtocol <NSObject>

- (CGSize)textFieldAccessorySize:(GSTextField *)textField;

- (UIView *)textFieldAccessoryView:(GSTextField *)textField;

- (NSString *)textFieldPlaceHolderText:(GSTextField *)textField;

- (UIImage *)textFieldTitleImage:(GSTextField *)textField;

- (NSString *)textFieldIndicatorText:(GSTextField *)textField;

- (UIEdgeInsets)textFieldSeperateInsets:(GSTextField *)textField;

@end

@protocol GSTextFieldColorProtocol <NSObject>

@optional

- (UIColor *)textFieldPlaceHolderTextColor:(GSTextField *)textField;

- (UIColor *)textFieldIndicatorTextColor:(GSTextField *)textField;

- (UIColor *)textFieldTextColor:(GSTextField *)textField;

- (UIColor *)textFieldSeperateLineColor:(GSTextField *)textField;
@end


@interface GSTextField : UIView
@property (nonatomic,weak) id<GSTextFieldProtocol>delegate;
@property (nonatomic,weak) id<GSTextFieldColorProtocol>colorDelegate;
@property (nonatomic,strong,readonly) UITextField *textField;

- (instancetype)initWithDelegate:(id<GSTextFieldProtocol>)delegate;

- (instancetype)initWithFrame:(CGRect)frame image:(UIImage *)image placeHolderText:(NSString *)placeHolderText;

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title placeHolderText:(NSString *)placeHolderText;

- (void)configureWithImage:(UIImage *)image title:(NSString *)title placeHolderText:(NSString *)placeHolderText;

- (void)configureWithDelegate:(id<GSTextFieldProtocol>)delegate;

@end
