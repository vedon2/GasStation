//
//  AppDelegateExt+initProcess.m
//  GasStation
//
//  Created by vedon on 2/11/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#define kUmengkey @"56c32d8267e58efee0000bd0"
#define kSmsKey @"f6e19a611dc8"
#define kSmsSecret  @"86678a50120c6439b8cc74b612cd4c0e"
#define kMeiQiaKey @""
#define EMKey       @"vedon#gasstation"

#import "AppDelegateExt+initProcess.h"
#import "GSMapManager.h"
#import "UMSocial.h"
#import "GSAccountDefine.h"
#import <SMS_SDK/SMSSDK.h>
#import <MeiQiaSDK/MQManager.h>

#import "CRNavigationBar.h"
#import "GSColor.h"
#import <UIKit/UIKit.h>

#import "EMSDK.h"
#import "UIImage+YYAdd.h"
#import "YTKNetworkConfig.h"


#import "GSGetSmsCodeTask.h"
#import "GSRegisterTask.h"

@implementation AppDelegateExt (initProcess)

- (void)initProcessBeforeMainUI
{
    
    [[GSMapManager shareManager] initialize];
    [UMSocialData setAppKey:kUmengkey];
    
    [SMSSDK registerApp:kSmsKey
             withSecret:kSmsSecret];
    
//    [MQManager initWithAppkey:kMeiQiaKey completion:^(NSString *clientId, NSError *error) {
//        assert(error == nil);
//    }];
    
    
//    GSGetSmsCodeTask *task = [[GSGetSmsCodeTask alloc] initWithPhone:@"15018492358"];
//    [task startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
//        ;
//    } failure:^(__kindof YTKBaseRequest *request) {
//        ;
//    }];
    
    YTKNetworkConfig *config = [YTKNetworkConfig sharedInstance];
    config.baseUrl = @"http://192.168.1.102:8888/oil/api";
    
//    GSRegisterTask *task = [[GSRegisterTask alloc] initWithPhone:@"15018492358" password:@"123456" veriCode:@"7437"];
//    [task startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
//        ;
//    } failure:^(__kindof YTKBaseRequest *request) {
//        ;
//    }];

    
    
    EMOptions *options = [EMOptions optionsWithAppkey:EMKey];
//    options.apnsCertName = @"istore_dev";
    [[EMClient sharedClient] initializeSDKWithOptions:options];
 
    
    
    

    
    UIImage *image = [[UIImage imageNamed:@"icon_back"]resizableImageWithCapInsets:UIEdgeInsetsMake(0, 20, 0, 0)];
    [[UIBarButtonItem appearance]setBackButtonBackgroundImage:image forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    [[CRNavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName ,nil]];
    [[CRNavigationBar appearance] setTintColor:[UIColor whiteColor]];

    
    UIImage *tempImage = [UIImage imageWithColor:[GSColor mainColor] size:CGSizeMake(20, 64)];
    UIImage *strechImage = [tempImage resizableImageWithCapInsets:UIEdgeInsetsMake(2, 2, 2, 2)];
    [[CRNavigationBar appearance] setBackgroundImage:strechImage forBarMetrics:UIBarMetricsDefault];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [[EMClient sharedClient] applicationDidEnterBackground:application];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    [[EMClient sharedClient] applicationWillEnterForeground:application];
}

@end
