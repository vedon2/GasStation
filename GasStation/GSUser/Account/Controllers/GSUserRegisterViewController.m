//
//  GSUserRegisterViewController.m
//  GasStation
//
//  Created by vedon on 2/13/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import "GSUserRegisterViewController.h"
#import "GSInputTextField.h"
#import "GSUserLoginViewController.h"
#import "GSUserManager.h"

@interface GSUserRegisterViewController ()<GSUserManagerDelegate>

@property (weak, nonatomic) IBOutlet GSInputTextField *phoneTextField;
@property (weak, nonatomic) IBOutlet GSInputTextField *smsCodeTextField;
@property (weak, nonatomic) IBOutlet GSInputTextField *pwdTextField;
@end

@implementation GSUserRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.phoneTextField configureWithImage:[UIImage imageNamed:@"foregroundStar"] placeholderText:@"手机号" accessoryButtonTitle:nil accessoryButtonAction:nil];
    
    [self.smsCodeTextField configureWithImage:[UIImage imageNamed:@"foregroundStar"] placeholderText:@"验证码" accessoryButtonTitle:@"获取" accessoryButtonAction:^{
        
        NSLog(@"Accessory Button Action");
        
    }];
    
    [self.pwdTextField configureWithImage:[UIImage imageNamed:@"foregroundStar"] placeholderText:@"6-15 位密码" accessoryButtonTitle:nil accessoryButtonAction:nil];
    
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
    
}

#pragma mark - GSUserManagerDelegate

- (void)userRegisterSuccess
{
    
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
