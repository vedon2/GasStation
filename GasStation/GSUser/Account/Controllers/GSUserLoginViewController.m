
//
//  GSUserLoginViewController.m
//  GasStation
//
//  Created by vedon on 2/14/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import "GSUserLoginViewController.h"
#import "GSTextField.h"
#import "GSUserManager.h"
#import "GSForgetPwdViewController.h"
#import "UIImage+YYAdd.h"
#import "GSColor.h"
#import "PureLayout.h"
#import "GSKeyBoardManger.h"
#import "CRNavigationController.h"

@interface GSUserLoginViewController ()<GSUserManagerDelegate,GSTextFieldColorProtocol,GSTextFieldProtocol,GSKeyBoardMangerObserver>
@property (weak, nonatomic) IBOutlet GSTextField *phoneTextField;
@property (weak, nonatomic) IBOutlet GSTextField *pwdTextField;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topViewTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *avatarTopConstraint;
@property (strong,nonatomic) UIButton *clearPhoneTextFieldButton;
@property (strong,nonatomic) UIButton *securePwdTextFieldButton;
@end

@implementation GSUserLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.phoneTextField.colorDelegate = self;
    self.pwdTextField.colorDelegate = self;
    
    [self.phoneTextField configureWithDelegate:self];
    [self.pwdTextField configureWithDelegate:self];
    
    self.phoneTextField.textField.secureTextEntry = NO;
    self.securePwdTextFieldButton.selected = YES;
//    [self.phoneTextField configureWithImage:[UIImage imageNamed:@"foregroundStar"] title:nil placeHolderText:@"手机号"];
//    [self.pwdTextField configureWithImage:[UIImage imageNamed:@"foregroundStar"] title:nil placeHolderText:@"6-15 位密码"];
    UIImage *strechImage = [UIImage imageWithColor:[GSColor mainColor] size:self.registerButton.frame.size];
    [self.registerButton setBackgroundImage:strechImage forState:UIControlStateNormal];
    self.registerButton.layer.cornerRadius = 6.0;
    self.registerButton.layer.masksToBounds = YES;
    strechImage = [UIImage imageWithColor:[GSColor mainColor] size:self.registerButton.frame.size];
    [self.registerButton setBackgroundImage:strechImage forState:UIControlStateSelected];
    [self.registerButton setBackgroundImage:strechImage forState:UIControlStateHighlighted];
    
    [[GSUserManager shareManager] addObserver:self];
    [[GSKeyBoardManger shareManager] addObserver:self toView:self.view];
    
//    self.topViewHeightConstraint.constant -= 60;
//    self.avatarTopConstraint.constant -= 50;
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [[GSUserManager shareManager] removeObserver:self];
    [[GSKeyBoardManger shareManager] removeObserver:self];
}

#pragma mark - Public

+ (void)presentLoginViewController
{
    GSUserLoginViewController *vc = [[GSUserLoginViewController alloc] initWithNibName:@"GSUserLoginViewController" bundle:nil];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:vc animated:YES completion:nil];
    vc = nil;
}


#pragma mark - Action

- (IBAction)registerAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)loginAction:(id)sender
{
    
}
- (IBAction)dismissAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)finePwdAction:(id)sender
{
    GSForgetPwdViewController *vc = [[GSForgetPwdViewController alloc] initWithNibName:@"GSForgetPwdViewController" bundle:nil];
    CRNavigationController *nav = [[CRNavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:nil];
    vc = nil;
    nav = nil;
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

#pragma mark - GSTextFieldProtocol

- (CGSize)textFieldAccessorySize:(GSTextField *)textField
{
    if ([textField isEqual:self.phoneTextField])
    {
        return CGSizeMake(50, 30);
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

    if ([textField isEqual:self.pwdTextField])
    {
        placeHolderText = @"6-15 位密码";
    }
    return placeHolderText;
}

- (UIImage *)textFieldTitleImage:(GSTextField *)textField
{
    if ([textField isEqual:self.phoneTextField])
    {
        return [UIImage imageNamed:@"icon_accounts"];
    }
    if ([textField isEqual:self.pwdTextField])
    {
        return [UIImage imageNamed:@"icon_key"];
    }
    return nil;
}

- (NSString *)textFieldIndicatorText:(GSTextField *)textField
{
    return nil;
}

- (UIEdgeInsets )textFieldSeperateInsets:(GSTextField *)textField
{
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

#pragma mark - GSUserManagerDelegate

- (void)userLoginOk
{
    
}

- (void)userLoginFailed
{
    
}

#pragma mark - GSKeyBoardMangerObserver

- (void)keyBoardDidHidden
{
    if (self.topViewTopConstraint.constant < 0)
    {
        self.topViewTopConstraint.constant += (self.topView.frame.size.height/2);
        [UIView animateWithDuration:0.3 animations:^{
            [self.view layoutIfNeeded];
        }];
    }
}

- (void)keyBoardDidShow
{
    if (self.topViewTopConstraint.constant >= 0)
    {
        self.topViewTopConstraint.constant -= (self.topView.frame.size.height/2);
        [UIView animateWithDuration:0.3 animations:^{
            [self.view layoutIfNeeded];
        }];
    }

}

#pragma mark - Getter & Setter


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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
