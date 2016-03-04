//
//  GSAbouViewController.m
//  GasStation
//
//  Created by vedon on 2/16/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import "GSAbouViewController.h"
#import "BlocksKit+UIKit.h"
@interface GSAbouViewController ()
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;

@end

@implementation GSAbouViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] bk_initWithImage:[UIImage imageNamed:@"icon_back"] style:UIBarButtonItemStylePlain handler:^(id sender) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];

    self.contentTextView.text = @"We are the best !";
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)title
{
    return @"版本信息";
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
