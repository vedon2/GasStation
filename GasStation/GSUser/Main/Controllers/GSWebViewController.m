

//
//  GSWebViewController.m
//  GasStation
//
//  Created by vedon on 3/4/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import "GSWebViewController.h"
#import <WebKit/WebKit.h>
#import "PureLayout.h"
#import "BlocksKit+UIKit.h"

@interface GSWebViewController ()
@property (nonatomic,strong) WKWebView *webView;
@property (nonatomic,strong) NSString *requestUrl;

@end

@implementation GSWebViewController

- (instancetype)initWithTitle:(NSString *)title requestUrl:(NSString *)url
{
    self = [super init];
    if (self)
    {
        self.requestUrl = url;
        self.title = title;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] bk_initWithImage:[UIImage imageNamed:@"icon_back"] style:UIBarButtonItemStylePlain handler:^(id sender) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [self.view addSubview:self.webView];
    [self.webView autoPinEdgesToSuperviewEdges];
    
    
    if (self.requestUrl)
    {
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.requestUrl]];
        [self.webView loadRequest:request];
    }
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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


@end
