//
//  GSQueryBreakRuleViewController.m
//  GasStation
//
//  Created by vedon on 3/2/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import "GSQueryBreakRuleViewController.h"
#import <WebKit/WebKit.h>
#import "PureLayout.h"
#import "BlocksKit+UIKit.h"

@interface GSQueryBreakRuleViewController ()
@property (nonatomic,strong) WKWebView *webView;
@end

@implementation GSQueryBreakRuleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] bk_initWithImage:[UIImage imageNamed:@"icon_back"] style:UIBarButtonItemStylePlain handler:^(id sender) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [self.view addSubview:self.webView];
    [self.webView autoPinEdgesToSuperviewEdges];
    
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]];
    [self.webView loadRequest:request];

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)title
{
    return @"查违章";
}

#pragma mark - Getter & Getter

- (WKWebView *)webView
{
    if (!_webView)
    {
        _webView = [[WKWebView alloc] initForAutoLayout];
    }
    return _webView;
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
