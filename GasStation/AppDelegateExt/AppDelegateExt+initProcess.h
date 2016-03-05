//
//  AppDelegateExt+initProcess.h
//  GasStation
//
//  Created by vedon on 2/11/16.
//  Copyright © 2016 vedon. All rights reserved.
//


#import "AppDelegateExt.h"

@class UIApplication;

@interface AppDelegateExt (initProcess)

- (void)initProcessBeforeMainUI;

- (void)applicationDidEnterBackground:(UIApplication *)application;

- (void)applicationWillEnterForeground:(UIApplication *)application;

- (void)pingppJandleOpenUrl:(NSURL *)url;

@end
