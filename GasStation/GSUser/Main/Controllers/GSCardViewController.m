//
//  GSCardViewController.m
//  GasStation
//
//  Created by vedon on 2/20/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import "GSCardViewController.h"
#import "BlocksKit+UIKit.h"

@interface GSCardViewController ()

@end

@implementation GSCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] bk_initWithImage:[UIImage imageNamed:@"icon_back"] style:UIBarButtonItemStylePlain handler:^(id sender) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
