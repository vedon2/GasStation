//
//  GSUserManager.h
//  GasStation
//
//  Created by vedon on 2/13/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GSUserInfoBaseProtocol.h"
#import "GSUserManagerProtocol.h"

@protocol GSUserManagerDelegate <NSObject>

@optional
- (void)userLoginOk;

- (void)userLoginFailed;

- (void)userRegisterSuccess;

- (void)userRegisterFail;

@end

#ifdef GSUser
@interface GSUserManager : NSObject<GSUserInfoBaseProtocol>
#else
@interface GSUserManager : NSObject<GSUserInfoBaseProtocol,GSUserManagerProtocol>
#endif

+ (id)shareManager;

- (void)addObserver:(id<GSUserManagerDelegate>)observer;

- (void)removeObserver:(id<GSUserManagerDelegate>)observer;

- (BOOL)isLogin;
@end
