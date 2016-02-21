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

@interface GSUserRegisterViewController ()<GSUserManagerDelegate,GSTextFieldProtocol,GSCountetButtonDelegate>
@property (weak, nonatomic) IBOutlet GSTextField *phoneTextField;
@property (weak, nonatomic) IBOutlet GSTextField *smsCodeTextField;
@property (weak, nonatomic) IBOutlet GSTextField *pwdTextField;
@property (strong,nonatomic) GSCounterButton *counterButton;
@end

@implementation GSUserRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.phoneTextField configureWithImage:[UIImage imageNamed:@"foregroundStar"] title:nil placeHolderText:@"手机号"];
    [self.smsCodeTextField configureWithDelegate:self];
    [self.pwdTextField configureWithImage:[UIImage imageNamed:@"foregroundStar"] title:nil placeHolderText:@"6-15 位密码"];
    
    [[GSUserManager shareManager] addObserver:self];
    // Do any additional setup after loading the view from its nib.
}

- (void)dealloc
{
    [[GSUserManager shareManager] removeObserver:self];
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
    //注册成功后打开编辑个人信息界面
    GSEditUserProfileViewController *vc = [[GSEditUserProfileViewController alloc] initWithNibName:@"GSEditUserProfileViewController" bundle:nil];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:nil];
    nav = nil;
    vc = nil;
}

#pragma mark - GSUserManagerDelegate

- (void)userRegisterSuccess
{
    
}

#pragma mark - GSTextFieldProtocol

- (CGSize)textFieldAccessorySize:(GSTextField *)textField
{
    return CGSizeMake(80, 40);
}

- (UIView *)textFieldAccessoryView:(GSTextField *)textField
{
    return self.counterButton;
}

- (NSString *)textFieldPlaceHolderText:(GSTextField *)textField
{
    return @"验证码";
}

- (UIImage *)textFieldTitleImage:(GSTextField *)textField
{
    return [UIImage imageNamed:@"foregroundStar"];
}

- (NSString *)textFieldIndicatorText:(GSTextField *)textField
{
    return nil;
}

#pragma mark - GSCountetButtonDelegate

- (void)didTapCounterButton:(GSCounterButton *)button
{
    
}

#pragma mark - GSCounterButton

- (GSCounterButton *)counterButton
{
    if (!_counterButton)
    {
        _counterButton = [[GSCounterButton alloc] initWithImage:nil counterText:@"获取验证码" delegate:self];
        [_counterButton initialize];
    }
    return _counterButton;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
