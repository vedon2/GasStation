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

#import "AppDelegateExt+initProcess.h"
#import "GSMapManager.h"
#import "UMSocial.h"
#import "GSAccountDefine.h"
#import <SMS_SDK/SMSSDK.h>
#import <MeiQiaSDK/MQManager.h>

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
    
}

@end
