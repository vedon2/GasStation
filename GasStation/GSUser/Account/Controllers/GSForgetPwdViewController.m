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

@interface GSForgetPwdViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *contentTable;
@property (strong,nonatomic) GSTextField *phoneTextField;
@property (strong,nonatomic) GSTextField *smsCodeTextField;
@property (strong,nonatomic) GSTextField *resetPwdTextField;
@property (strong,nonatomic) UIButton *accessoryButton;
@end

@implementation GSForgetPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.contentTable.scrollEnabled = NO;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kCellHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    switch (indexPath.row) {
        case 0:
            [self.phoneTextField removeFromSuperview];
            [cell.contentView addSubview:self.phoneTextField];
            break;
        case 1:
            [self.smsCodeTextField removeFromSuperview];
            [cell.contentView addSubview:self.smsCodeTextField];
            break;
        case 2:
            [self.resetPwdTextField removeFromSuperview];
            [cell.contentView addSubview:self.resetPwdTextField];
            break;
        default:
            break;
    }
    
    return cell;
}

- (void)didTapGetSmsCodeButton
{
    
}

- (CGRect)rectForTextField
{
    CGRect rect = CGRectZero;
    rect.size = CGSizeMake(self.contentTable.frame.size.width, kCellHeight);
    return rect;
}

- (IBAction)backAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Getter & Setter

- (GSTextField *)phoneTextField
{
    if (!_phoneTextField)
    {
        _phoneTextField = [[GSTextField alloc] initWithFrame:[self rectForTextField] title:@"手机号" placeHolderText:nil];
        
    }
    return  _phoneTextField;
}

- (GSTextField *)smsCodeTextField
{
    if (!_smsCodeTextField)
    {
        _smsCodeTextField = [[GSTextField alloc] initWithFrame:[self rectForTextField] title:@"验证码" placeHolderText:@"请输入验证码"];

    }
    return  _smsCodeTextField;
}

- (GSTextField *)resetPwdTextField
{
    if (!_resetPwdTextField)
    {
        
        _resetPwdTextField = [[GSTextField alloc] initWithFrame:[self rectForTextField] title:@"新密码" placeHolderText:@"6-15位密码"];
    }
    return _resetPwdTextField;
}

- (UIButton *)accessoryButton
{
    if (!_accessoryButton)
    {
        _accessoryButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
        _accessoryButton.backgroundColor = [UIColor clearColor];
        [_accessoryButton setTitle:@"获取" forState:UIControlStateNormal];
        [_accessoryButton addTarget:self action:@selector(didTapGetSmsCodeButton) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return  _accessoryButton;
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
