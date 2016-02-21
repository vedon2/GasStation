//
//  GSForgetPwdViewController.m
//  GasStation
//
//  Created by vedon on 2/15/16.
//  Copyright © 2016 vedon. All rights reserved.
//
#define kCellHeight 60

#import "GSForgetPwdViewController.h"
#import "GSTextField.h"
#import "PureLayout.h"
#import "BlocksKit+UIKit.h"
#import "GSColor.h"
#import "UIImage+YYAdd.h"
#import "GSCounterButton.h"

@interface GSForgetPwdViewController ()<GSTextFieldColorProtocol,GSTextFieldProtocol,GSCountetButtonDelegate>

@property (weak, nonatomic) IBOutlet GSTextField *phoneTextField;
@property (weak, nonatomic) IBOutlet GSTextField *smsCodeTextField;
@property (weak, nonatomic) IBOutlet GSTextField *resetPwdTextField;
@property (strong,nonatomic) GSCounterButton *counterButton;
@property (strong,nonatomic) UIButton *clearPhoneTextFieldButton;
@property (strong,nonatomic) UIButton *securePwdTextFieldButton;

@property (weak, nonatomic) IBOutlet UIButton *confirmButton;
@property (strong,nonatomic) UIButton *accessoryButton;
@end

@implementation GSForgetPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] bk_initWithImage:[UIImage imageNamed:@"icon_back"] style:UIBarButtonItemStylePlain handler:^(id sender) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    self.phoneTextField.colorDelegate = self;
    self.smsCodeTextField.colorDelegate = self;
    self.resetPwdTextField.colorDelegate = self;
    
    [self.phoneTextField configureWithDelegate:self];
    [self.smsCodeTextField configureWithDelegate:self];
    [self.resetPwdTextField configureWithDelegate:self];

    self.resetPwdTextField.textField.secureTextEntry = NO;
    self.securePwdTextFieldButton.selected = YES;
    
    UIImage *strechImage = [UIImage imageWithColor:[GSColor mainColor] size:self.confirmButton.frame.size];
    [self.confirmButton setBackgroundImage:strechImage forState:UIControlStateNormal];
    self.confirmButton.layer.cornerRadius = 6.0;
    self.confirmButton.layer.masksToBounds = YES;
    strechImage = [UIImage imageWithColor:[GSColor registerButtonSelectedColor] size:self.confirmButton.frame.size];
    [self.confirmButton setBackgroundImage:strechImage forState:UIControlStateSelected];
    [self.confirmButton setBackgroundImage:strechImage forState:UIControlStateHighlighted];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)title
{
    return @"忘记密码";
}

#pragma mark - Action

- (IBAction)confirmAction:(id)sender
{
    
}

- (void)clearPhoneTextFieldText
{
    self.phoneTextField.textField.text = @"";
}

- (void)securePwdTextField
{
    self.resetPwdTextField.textField.secureTextEntry = !self.resetPwdTextField.textField.secureTextEntry;
    self.securePwdTextFieldButton.selected = !self.securePwdTextFieldButton.selected;
}

#pragma mark - GSTextFieldProtocol

- (CGSize)textFieldAccessorySize:(GSTextField *)textField
{
    if ([textField isEqual:self.phoneTextField])
    {
        return CGSizeMake(50, 30);
    }
    if ([textField isEqual:self.smsCodeTextField])
    {
        return CGSizeMake(80, 30);
    }
    if ([textField isEqual:self.resetPwdTextField])
    {
        return CGSizeMake(50, 30);
    }
    
    return CGSizeZero;
}

- (UIView *)textFieldAccessoryView:(GSTextField *)textField
{
    if ([textField isEqual:self.phoneTextField])
    {
        return  self.clearPhoneTextFieldButton;
    }
    if ([textField isEqual:self.smsCodeTextField])
    {
        return self.counterButton;
    }
    if ([textField isEqual:self.resetPwdTextField])
    {
        return self.securePwdTextFieldButton;
    }
    return nil;
}

- (NSString *)textFieldPlaceHolderText:(GSTextField *)textField
{
    NSString *placeHolderText = nil;
    if ([textField isEqual:self.phoneTextField])
    {
        placeHolderText = @"手机号";
    }
    if ([textField isEqual:self.smsCodeTextField])
    {
        placeHolderText = @"请输入验证码";
    }
    if ([textField isEqual:self.resetPwdTextField])
    {
        placeHolderText = @"6-15 位密码";
    }
    return placeHolderText;
}

- (UIImage *)textFieldTitleImage:(GSTextField *)textField
{
    return nil;
}

- (NSString *)textFieldIndicatorText:(GSTextField *)textField
{
    
    if ([textField isEqual:self.phoneTextField])
    {
        return @"手机号";
    }
    if ([textField isEqual:self.smsCodeTextField])
    {
       return @"验证码";
    }
    if ([textField isEqual:self.resetPwdTextField])
    {
        return @"新密码";
    }
    return nil;
}

- (UIEdgeInsets )textFieldSeperateInsets:(GSTextField *)textField
{
    if ([textField isEqual:self.smsCodeTextField])
    {
        return UIEdgeInsetsMake(5, 0, 0, 80 + 15);
    }
    return UIEdgeInsetsMake(5, 0, 0, 0);
}

#pragma mark - GSTextFieldColorProtocol

- (UIColor *)textFieldIndicatorTextColor:(GSTextField *)textField
{
    return [GSColor forgetPwdTextFieldIndicatorTextColor];
}

- (UIColor *)textFieldPlaceHolderTextColor:(GSTextField *)textField
{
    return [UIColor lightGrayColor];
}

- (UIColor *)textFieldTextColor:(GSTextField *)textField
{
    if ([textField isEqual:self.phoneTextField])
    {
        return [GSColor registerPhoneTextFieldColor];
    }
    else
    {
        return [GSColor registerTextColor];
    }
}

#pragma mark - GSCountetButtonDelegate

- (void)didTapCounterButton:(GSCounterButton *)button
{
    
}

#pragma mark - Getter & Setter


- (GSCounterButton *)counterButton
{
    if (!_counterButton)
    {
        _counterButton = [[GSCounterButton alloc] initWithImage:nil counterText:@"获取" delegate:self];
        [_counterButton initialize];
    }
    return _counterButton;
}

- (UIButton *)clearPhoneTextFieldButton
{
    if (!_clearPhoneTextFieldButton)
    {
        _clearPhoneTextFieldButton = [[UIButton alloc] initForAutoLayout];
        [_clearPhoneTextFieldButton setImage:[UIImage imageNamed:@"icon_entry_delete"] forState:UIControlStateNormal];
        _clearPhoneTextFieldButton.imageEdgeInsets = UIEdgeInsetsMake(0, 30, 0, 0);
        [_clearPhoneTextFieldButton addTarget:self action:@selector(clearPhoneTextFieldText) forControlEvents:UIControlEventTouchUpInside];
    }
    return _clearPhoneTextFieldButton;
}


- (UIButton *)securePwdTextFieldButton
{
    if (!_securePwdTextFieldButton)
    {
        _securePwdTextFieldButton = [[UIButton alloc] initForAutoLayout];
        [_securePwdTextFieldButton setImage:[UIImage imageNamed:@"icon_hide"] forState:UIControlStateNormal];
        [_securePwdTextFieldButton setImage:[UIImage imageNamed:@"icon_see"] forState:UIControlStateSelected];
        _securePwdTextFieldButton.imageEdgeInsets = UIEdgeInsetsMake(0, 30, 0, 0);
        [_securePwdTextFieldButton addTarget:self action:@selector(securePwdTextField) forControlEvents:UIControlEventTouchUpInside];
    }
    return _securePwdTextFieldButton;
}



@end
