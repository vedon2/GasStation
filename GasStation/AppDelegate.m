//
//  AppDelegate.m
//  GasStation
//
//  Created by vedon on 2/1/16.
//  Copyright © 2016 vedon. All rights reserved.
//


#import "AppDelegate.h"
#import "GSMapManager.h"
#import "AppDelegateExt.h"
#import "AppDelegateExt+initProcess.h"

#import "GSUserMainViewController.h"
#import "GSManagerMainViewController.h"

@interface AppDelegate ()
@property (nonatomic,strong) AppDelegateExt *appDelegateExt;
@property (nonatomic,strong) UIViewController *rootVc;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.appDelegateExt = [[AppDelegateExt alloc] init];
    [self.appDelegateExt initProcessBeforeMainUI];
    
    NSString *storyBoardName = nil;
#ifdef GSUser
    storyBoardName = @"GSUserScreen";
#else
    storyBoardName = @"GSManagerScreen";
#endif
    
    assert(storyBoardName);
    
    NSLog(@"%@",storyBoardName);
    UIStoryboard *storyBoard=[UIStoryboard storyboardWithName:storyBoardName bundle:nil];
    self.rootVc =  storyBoard.instantiateInitialViewController;
    self.window.rootViewController = self.rootVc;
    // Override point for customization after application launch.
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    [self.appDelegateExt applicationDidEnterBackground:application];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
    [self.appDelegateExt applicationWillEnterForeground:application];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
