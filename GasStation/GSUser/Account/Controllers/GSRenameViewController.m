//
//  GSRenameViewController.m
//  GasStation
//
//  Created by vedon on 2/25/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import "GSRenameViewController.h"
#import "BlocksKit+UIKit.h"
#import "GSColor.h"
#import "MBProgressHUD.h"

@interface GSRenameViewController ()
@property (weak, nonatomic) IBOutlet UIView *textViewContainerView;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (strong,nonatomic) NSString *nickname;
@end

@implementation GSRenameViewController

- (instancetype)initWithNickname:(NSString *)nickname
{
    self = [super init];
    if (self)
    {
        self.nickname = nickname;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textField.text = self.nickname;
    self.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.textField.borderStyle = UITextBorderStyleNone;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] bk_initWithTitle:@"保存" style:UIBarButtonItemStylePlain handler:^(id sender) {
        
        
        if (self.textField.text.length == 0)
        {
            MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hub.mode = MBProgressHUDModeText;
            hub.labelText = @"昵称不能为空";
            [hub hide:YES afterDelay:2.f];

        }
        else
        {
            
        }
        
    }];
    
    self.view.backgroundColor = [GSColor userCenterBackgroundColor];
    self.textViewContainerView.backgroundColor = [UIColor whiteColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [self.view addGestureRecognizer:tap];
    tap = nil;
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)title
{
    return @"昵称";
}


- (void)tap
{
    [self.textField resignFirstResponder];
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
