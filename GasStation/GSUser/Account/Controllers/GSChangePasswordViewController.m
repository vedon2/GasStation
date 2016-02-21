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

static NSString *changePwdCellIdentifier = @"changePwdCellIdentifier";

@interface GSChangePasswordViewController ()<UITableViewDelegate,UITableViewDataSource,GSTextFieldProtocol>
@property (weak, nonatomic) IBOutlet UITableView *contentTable;
@property (nonatomic,strong) GSTextField *originalPwdTextField;
@property (nonatomic,strong) GSTextField *resetPwdTextField;
@end

@implementation GSChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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

- (CGRect)rectForTextField
{
    CGRect rect = CGRectZero;
    rect.size = CGSizeMake(self.contentTable.frame.size.width, kCellHeight);
    return rect;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kCellHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:changePwdCellIdentifier];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:changePwdCellIdentifier];
    }
    switch (indexPath.row) {
        case 0:
            [self.originalPwdTextField removeFromSuperview];
            [cell.contentView addSubview:self.originalPwdTextField];
            [_originalPwdTextField configureWithImage:nil title:nil placeHolderText:nil];
            break;
        case 1:
            [self.resetPwdTextField removeFromSuperview];
            [cell.contentView addSubview:self.resetPwdTextField];
            [_resetPwdTextField configureWithImage:nil title:nil placeHolderText:nil];
            break;
        default:
            break;
    }
    return cell;

}

#pragma mark - GSTextFieldProtocol

- (CGSize)textFieldAccessorySize:(GSTextField *)textField
{
    return CGSizeMake(80, 40);
}

- (UIView *)textFieldAccessoryView:(GSTextField *)textField
{
    if ([textField isEqual:_originalPwdTextField])
    {
        
    }
    else
    {
        
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

#pragma mark - Getter & Setter 

- (GSTextField *)originalPwdTextField
{
    if (!_originalPwdTextField)
    {
        _originalPwdTextField = [[GSTextField alloc] initWithDelegate:self];
        
    }
    return _originalPwdTextField;
}  

- (GSTextField *)resetPwdTextField
{
    if (!_resetPwdTextField)
    {
        _resetPwdTextField = [[GSTextField alloc] initWithDelegate:self];
    }
    return _resetPwdTextField;
}

@end
