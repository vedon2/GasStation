//
//  AppDelegateExt+initProcess.m
//  GasStation
//
//  Created by vedon on 2/11/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import "AppDelegateExt+initProcess.h"
#import "GSMapManager.h"
#import "UMSocial.h"
#import "GSAccountDefine.h"


@implementation AppDelegateExt (initProcess)

- (void)initProcessBeforeMainUI
{
    [[GSMapManager shareManager] initialize];
    
    [UMSocialData setAppKey:kUmengkey];
}

@end
