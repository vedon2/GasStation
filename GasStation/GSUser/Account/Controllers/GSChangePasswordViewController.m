//
//  GSChangePasswordViewController.m
//  GasStation
//
//  Created by vedon on 2/16/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#define kCellHeight 50
#import "GSChangePasswordViewController.h"
#import "GSTextField.h"
#import "GSColor.h"
#import "UIImage+YYAdd.h"
#import "PureLayout.h"
#import "BlocksKit+UIKit.h"
#import "GSToast.h"
#import "GSStringValidator.h"
#import "GSResetPassworkTask.h"

static NSString *changePwdCellIdentifier = @"changePwdCellIdentifier";

@interface GSChangePasswordViewController ()<GSTextFieldProtocol,GSTextFieldColorProtocol>

@property (weak, nonatomic) IBOutlet GSTextField *originalPwdTextField;
@property (weak, nonatomic) IBOutlet GSTextField *resetPwdTextField;
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;
@property (strong,nonatomic) UIButton *originalSecurePwdTextFieldButton;
@property (strong,nonatomic) UIButton *resetSecurePwdTextFieldButton;
@end

@implementation GSChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.originalPwdTextField.colorDelegate = self;
    self.resetPwdTextField.colorDelegate = self;
    
    [self.originalPwdTextField configureWithDelegate:self];
    [self.resetPwdTextField configureWithDelegate:self];
    
    self.resetPwdTextField.textField.secureTextEntry = NO;
    self.originalPwdTextField.textField.secureTextEntry = NO;
    self.originalSecurePwdTextFieldButton.selected = YES;
    self.resetSecurePwdTextFieldButton.selected = YES;
    
    self.confirmButton.backgroundColor = [UIColor clearColor];
    UIImage *strechImage = [UIImage imageWithColor:[GSColor mainColor] size:self.confirmButton.frame.size];
    [self.confirmButton setBackgroundImage:strechImage forState:UIControlStateNormal];
    self.confirmButton.layer.cornerRadius = 6.0;
    self.confirmButton.layer.masksToBounds = YES;
    strechImage = [UIImage imageWithColor:[GSColor mainColor] size:self.confirmButton.frame.size];
    [self.confirmButton setBackgroundImage:strechImage forState:UIControlStateSelected];
    [self.confirmButton setBackgroundImage:strechImage forState:UIControlStateHighlighted];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] bk_initWithImage:[UIImage imageNamed:@"icon_back"] style:UIBarButtonItemStylePlain handler:^(id sender) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)title
{
    return @"修改密码";
}

#pragma mark - Action

- (IBAction)confirmAction:(id)sender
{
    NSString *originalPwd = self.originalPwdTextField.textField.text;
    NSString *resetPwd = self.resetPwdTextField.textField.text;
    
    if (originalPwd.length == 0)
    {
        [GSToast showToastWithText:@"原密码不能为空" inView:self.view];
        return;
    }
    
    if (resetPwd.length == 0)
    {
        [GSToast showToastWithText:@"新密码不能为空" inView:self.view];
        return;
    }
    
    if ([originalPwd isEqualToString:resetPwd])
    {
        [GSToast showToastWithText:@"新旧密码不能一样" inView:self.view];
        return;
    }
    
    if (![GSStringValidator checkPassword:resetPwd])
    {
        [GSToast showToastWithText:@"密码为6-15数字或者字母组合" inView:self.view];
        return;
    }
    
//    [GSResetPassworkTask alloc] initWithNewPassword:originalPwd oldPassword:resetPwd veriCode:<#(NSString *)#> phone:<#(NSString *)#>
    
}

- (void)securePwdTextField:(id)sender
{
    if ([sender isEqual:self.originalSecurePwdTextFieldButton])
    {
        self.originalPwdTextField.textField.secureTextEntry = !self.originalPwdTextField.textField.secureTextEntry;
        self.originalSecurePwdTextFieldButton.selected = !self.originalSecurePwdTextFieldButton.selected;
    }
    else
    {
        self.resetPwdTextField.textField.secureTextEntry = !self.resetPwdTextField.textField.secureTextEntry;
        self.resetSecurePwdTextFieldButton.selected = !self.resetSecurePwdTextFieldButton.selected;
    }
    
}

#pragma mark - GSTextFieldProtocol

- (CGSize)textFieldAccessorySize:(GSTextField *)textField
{
    return CGSizeMake(50, 40);
}

- (UIView *)textFieldAccessoryView:(GSTextField *)textField
{
    if ([textField isEqual:_originalPwdTextField])
    {
        return self.originalSecurePwdTextFieldButton;
    }
    else
    {
        return self.resetSecurePwdTextFieldButton;
    }
    
    return nil;
}

- (NSString *)textFieldPlaceHolderText:(GSTextField *)textField
{
    if ([textField isEqual:_originalPwdTextField])
    {
        return @"请输入原始密码";
    }
    else
    {
        return @"6-15 数字或者字母组合";
    }
    
}

- (UIImage *)textFieldTitleImage:(GSTextField *)textField
{
    return nil;
}

- (NSString *)textFieldIndicatorText:(GSTextField *)textField
{
    if ([textField isEqual:_originalPwdTextField])
    {
        return @"原密码";
    }
    else
    {
        return @"新密码";
    }
}

- (UIEdgeInsets)textFieldSeperateInsets:(GSTextField *)textField
{
    return UIEdgeInsetsMake(5, 0, 5, 0);
}

#pragma mark - GSTextFieldColorProtocol

- (UIColor *)textFieldIndicatorTextColor:(GSTextField *)textField
{
    return [GSColor registerTextColor];
}

- (UIColor *)textFieldPlaceHolderTextColor:(GSTextField *)textField
{
    return [UIColor lightGrayColor];
}

- (UIColor *)textFieldTextColor:(GSTextField *)textField
{
    return [GSColor registerTextColor];
}


#pragma mark - Getter & Setter

- (UIButton *)originalSecurePwdTextFieldButton
{
    if (!_originalSecurePwdTextFieldButton)
    {
        _originalSecurePwdTextFieldButton = [[UIButton alloc] initForAutoLayout];
        [_originalSecurePwdTextFieldButton setImage:[UIImage imageNamed:@"icon_hide"] forState:UIControlStateNormal];
        [_originalSecurePwdTextFieldButton setImage:[UIImage imageNamed:@"icon_see"] forState:UIControlStateSelected];
        _originalSecurePwdTextFieldButton.imageEdgeInsets = UIEdgeInsetsMake(0, 30, 0, 0);
        [_originalSecurePwdTextFieldButton addTarget:self action:@selector(securePwdTextField:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _originalSecurePwdTextFieldButton;
}

- (UIButton *)resetSecurePwdTextFieldButton
{
    if (!_resetSecurePwdTextFieldButton)
    {
        _resetSecurePwdTextFieldButton = [[UIButton alloc] initForAutoLayout];
        [_resetSecurePwdTextFieldButton setImage:[UIImage imageNamed:@"icon_hide"] forState:UIControlStateNormal];
        [_resetSecurePwdTextFieldButton setImage:[UIImage imageNamed:@"icon_see"] forState:UIControlStateSelected];
        _resetSecurePwdTextFieldButton.imageEdgeInsets = UIEdgeInsetsMake(0, 30, 0, 0);
        [_resetSecurePwdTextFieldButton addTarget:self action:@selector(securePwdTextField:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _resetSecurePwdTextFieldButton;
}
@end
