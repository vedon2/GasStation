
//
//  GSUserLoginViewController.m
//  GasStation
//
//  Created by vedon on 2/14/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import "GSUserLoginViewController.h"
#import "GSInputTextField.h"
#import "GSUserManager.h"
#import "GSForgetPwdViewController.h"


@interface GSUserLoginViewController ()<GSUserManagerDelegate>
@property (weak, nonatomic) IBOutlet GSInputTextField *phoneTextField;
@property (weak, nonatomic) IBOutlet GSInputTextField *pwdTextField;

@end

@implementation GSUserLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.phoneTextField configureWithImage:[UIImage imageNamed:@"foregroundStar"] placeholderText:@"手机号" accessoryButtonTitle:nil accessoryButtonAction:nil];
    
    [self.pwdTextField configureWithImage:[UIImage imageNamed:@"foregroundStar"] placeholderText:@"6-15 位密码" accessoryButtonTitle:nil accessoryButtonAction:nil];
    
    [[GSUserManager shareManager] addObserver:self];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [[GSUserManager shareManager] removeObserver:self];
}

- (IBAction)registerAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)loginAction:(id)sender
{
    
}

- (IBAction)finePwdAction:(id)sender
{
    GSForgetPwdViewController *vc = [[GSForgetPwdViewController alloc] initWithNibName:@"GSForgetPwdViewController" bundle:nil];
    [self presentViewController:vc animated:YES completion:nil];
    vc = nil;
}
#pragma mark - GSUserManagerDelegate

- (void)userLoginOk
{
    
}

- (void)userLoginFailed
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
