//
//  GSSanViewController.m
//  GasStation
//
//  Created by vedon on 2/18/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import "GSSanViewController.h"
#import "GSScanner.h"


@interface GSSanViewController ()<GSScannetDelegate>
@property (weak, nonatomic) IBOutlet UIView *sannerContainer;
@property (strong ,nonatomic) GSScanner *scanner;
@end

@implementation GSSanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.scanner = [[GSScanner alloc] initWithFrame:self.sannerContainer.bounds delegate:self];
    [self.sannerContainer addSubview:self.scanner.scannerView];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.scanner start];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.scanner stop];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - GSScannetDelegate

- (void)didGetResult:(NSString *)result
{
    
}

#pragma mark - Getter & Setter


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
