//
//  GSUserRegisterViewController.m
//  GasStation
//
//  Created by vedon on 2/13/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import "GSUserRegisterViewController.h"
#import "GSUserLoginViewController.h"
#import "GSEditUserProfileViewController.h"
#import "GSUserManager.h"
#import "GSCounterButton.h"
#import "GSTextField.h"
#import "GSColor.h"
#import "UIImage+YYAdd.h"
#import "GSKeyBoardManger.h"
#import "PureLayout.h"
#import "CRNavigationController.h"
#import "GSAccountMacro.h"
#import "GSToast.h"

@interface GSUserRegisterViewController ()<GSUserManagerDelegate,GSTextFieldProtocol,GSCountetButtonDelegate,GSTextFieldColorProtocol,GSKeyBoardMangerObserver>
@property (weak, nonatomic) IBOutlet GSTextField *phoneTextField;
@property (weak, nonatomic) IBOutlet GSTextField *smsCodeTextField;
@property (weak, nonatomic) IBOutlet GSTextField *pwdTextField;
@property (strong,nonatomic) GSCounterButton *counterButton;
@property (strong,nonatomic) UIButton *clearPhoneTextFieldButton;
@property (strong,nonatomic) UIButton *securePwdTextFieldButton;

@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *avatarImageViewTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topViewTopConstraint;
@property (assign,nonatomic) CGFloat keyboardAnimationOffset;
@end

@implementation GSUserRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.phoneTextField.colorDelegate = self;
    self.smsCodeTextField.colorDelegate = self;
    self.pwdTextField.colorDelegate = self;
    
    [self.phoneTextField configureWithDelegate:self];
    [self.smsCodeTextField configureWithDelegate:self];
    [self.pwdTextField configureWithDelegate:self];
    
    self.phoneTextField.textField.secureTextEntry = NO;
    self.securePwdTextFieldButton.selected = YES;
    
    self.registerButton.backgroundColor = [UIColor clearColor];
    UIImage *strechImage = [UIImage imageWithColor:[GSColor mainColor] size:self.registerButton.frame.size];
    [self.registerButton setBackgroundImage:strechImage forState:UIControlStateNormal];
    self.registerButton.layer.cornerRadius = 6.0;
    self.registerButton.layer.masksToBounds = YES;
    strechImage = [UIImage imageWithColor:[GSColor mainColor] size:self.registerButton.frame.size];
    [self.registerButton setBackgroundImage:strechImage forState:UIControlStateSelected];
    [self.registerButton setBackgroundImage:strechImage forState:UIControlStateHighlighted];
    
    
    
    [[GSUserManager shareManager] addObserver:self];
    [[GSKeyBoardManger shareManager] addObserver:self toView:self.view];
    
    //TODO: 根据屏幕大小调整位置
//    self.topViewHeightConstraint.constant -= 60;
//    self.avatarImageViewTopConstraint.constant -= 60;

}


- (void)dealloc
{
    [[GSKeyBoardManger shareManager] removeObserver:self];
    [[GSUserManager shareManager] removeObserver:self];
    [self.counterButton stopCounter];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Public

+ (void)presentRegisterView
{
    GSUserRegisterViewController *vc = [[GSUserRegisterViewController alloc] initWithNibName:@"GSUserRegisterViewController" bundle:nil];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:vc animated:YES completion:nil];
    vc = nil;
}

#pragma mark - Gesture & Action
- (IBAction)backAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)loginAction:(id)sender
{
    GSUserLoginViewController *vc = [[GSUserLoginViewController alloc] initWithNibName:@"GSUserLoginViewController" bundle:nil];
    [self presentViewController:vc animated:YES completion:nil];
    
    vc = nil;
}

- (IBAction)registerAction:(id)sender
{
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    
    NSString *pwd = self.pwdTextField.textField.text;
    NSString *phone = self.phoneTextField.textField.text;
    NSString *veriCode = self.smsCodeTextField.textField.text;
    
    
    if (phone.length == 0)
    {
        [GSToast showToastWithText:@"手机号码不能为空" inView:self.view];
        return;
    }
    if (veriCode.length == 0)
    {
        [GSToast showToastWithText:@"验证码不能为空" inView:self.view];
        return;
    }
    if (pwd.length == 0)
    {
        [GSToast showToastWithText:@"密码不能为空" inView:self.view];
        return;
    }
    
    [GSToast showProgressToastInView:self.view];
    [[GSUserManager shareManager] registerWithPhone:phone password:pwd veriCode:veriCode];
}

- (void)clearPhoneTextFieldText
{
    self.phoneTextField.textField.text = @"";
}

- (void)securePwdTextField
{
    self.pwdTextField.textField.secureTextEntry = !self.pwdTextField.textField.secureTextEntry;
    self.securePwdTextFieldButton.selected = !self.securePwdTextFieldButton.selected;
}

#pragma mark - GSUserManagerDelegate

- (void)userRegisterSuccess
{
    [GSToast hideProgressToastInView:self.view];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    //注册成功后打开编辑个人信息界面
//    GSEditUserProfileViewController *vc = [[GSEditUserProfileViewController alloc] initWithNibName:@"GSEditUserProfileViewController" bundle:nil];
//    CRNavigationController *nav = [[CRNavigationController alloc] initWithRootViewController:vc];
//    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:nil];
//    nav = nil;
//    vc = nil;
}

- (void)userRegisterFail
{
    [GSToast hideProgressToastInView:self.view];
    GSLog(@"注册失败");
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
    if ([textField isEqual:self.pwdTextField])
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
    if ([textField isEqual:self.pwdTextField])
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
    if ([textField isEqual:self.pwdTextField])
    {
        placeHolderText = @"6-15 位密码";
    }
    return placeHolderText;
}

- (UIImage *)textFieldTitleImage:(GSTextField *)textField
{
    if ([textField isEqual:self.smsCodeTextField])
    {
        return [UIImage imageNamed:@"icon_captchas"];
    }
    if ([textField isEqual:self.pwdTextField])
    {
        return [UIImage imageNamed:@"icon_key"];
    }
    return nil;
}

- (NSString *)textFieldIndicatorText:(GSTextField *)textField
{
    if ([textField isEqual:self.phoneTextField])
    {
        return @"+86";
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
    return [GSColor mainColor];
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

#pragma mark -  GSKeyBoardMangerObserver

- (void)keyBoardDidShow:(CGRect)keyboardViewFrame
{
    if (self.topViewTopConstraint.constant >= 0)
    {
        
        CGRect registerRect = [self.view convertRect:self.registerButton.frame fromView:self.registerButton.superview];
        self.keyboardAnimationOffset = registerRect.origin.y + registerRect.size.height - keyboardViewFrame.origin.y ;
        
        self.topViewTopConstraint.constant -= self.keyboardAnimationOffset;
        [UIView animateWithDuration:0.3 animations:^{
            [self.view layoutIfNeeded];
        }];
    }
   
}

- (void)keyBoardDidHidden:(CGRect)keyboardViewFrame
{
    if (self.topViewTopConstraint.constant < 0)
    {
        self.topViewTopConstraint.constant += self.keyboardAnimationOffset;
        [UIView animateWithDuration:0.3 animations:^{
            [self.view layoutIfNeeded];
        }];
    }
    
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
