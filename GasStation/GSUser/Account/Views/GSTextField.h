//
//  GSTextField.h
//  GasStation
//
//  Created by vedon on 2/20/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GSTextFieldProtocol <NSObject>

@required
- (CGSize)accessorySize;

- (UIView *)accessoryView;

- (NSString *)placeHolderText;

- (UIImage *)textFieldTitleImage;

- (NSString *)textFieldIndicatorText;

@end

@interface GSTextField : UIView
@property (nonatomic,weak) id<GSTextFieldProtocol>delegate;

- (instancetype)initWithDelegate:(id<GSTextFieldProtocol>)delegate;

- (instancetype)initWithFrame:(CGRect)frame image:(UIImage *)image placeHolderText:(NSString *)placeHolderText;

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title placeHolderText:(NSString *)placeHolderText;

- (void)configureWithImage:(UIImage *)image title:(NSString *)title placeHolderText:(NSString *)placeHolderText;

- (void)configureWithDelegate:(id<GSTextFieldProtocol>)delegate;

@end
