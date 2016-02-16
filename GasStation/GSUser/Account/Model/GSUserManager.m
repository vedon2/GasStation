//
//  GSUserManager.m
//  GasStation
//
//  Created by vedon on 2/13/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import "GSUserManager.h"
#import "GSUserManagerRequester.h"
#import "ObserverContainer.h"


@interface GSUserManager ()<GSUserManagerRequesterDelegate>
@property (nonatomic,strong) GSUserManagerRequester *requester;
@property (nonatomic,strong) ObserverContainer *observers;
@end

@implementation GSUserManager

+ (id)shareManager
{
    static GSUserManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[GSUserManager alloc] init];
    });
    
    return manager;
}

- (BOOL)isLogin
{
    return YES;
}

- (void)addObserver:(id<GSUserManagerDelegate>)observer
{
    if (observer)
    {
        [self.observers addObserver:observer];
    }
}

- (void)removeObserver:(id<GSUserManagerDelegate>)observer
{
    if (observer)
    {
        [self.observers removeObserver:observer];
    }
}

#pragma mark - GSUserInfoBaseProtocol

- (void)getSmsCodeWithPhont:(NSString *)phone
{
    assert(phone);
    if (phone)
    {
        [self.requester getSmsCodeWithPhont:phone];
    }
    
}


- (void)registerWithPhone:(NSString *)phone password:(NSString *)password
{
    assert(password);
    if (password)
    {
        [self.requester registerWithPhone:phone password:password];
    }
}

- (void)resetPasswordWithNewPassword:(NSString *)pwd
{
    assert(pwd);
    if (pwd)
    {
        [self.requester resetPasswordWithNewPassword:pwd];
    }
}

- (void)updateUserProfile:(id)profileData
{
    
}

#pragma mark - GSUserManagerRequesterDelegate


- (void)requester:(GSUserManagerRequester *)requester taskType:(GSRequestType)type didFinishWithData:(id)responseObject
{
    switch (type) {
        case GSRequestType_GetSmsCode:
            ;
            break;
        case GSRequestType_Register:
            ;
            break;
        case GSRequestType_ResetPwd:
            ;
            break;
        case GSRequestType_UpdateProfile:
            ;
            break;
        default:
            break;
    }

}

- (void)requester:(GSUserManagerRequester *)requester taskType:(GSRequestType)type didFailedWithData:(id)responseObject error:(NSError *)error
{
    switch (type) {
        case GSRequestType_GetSmsCode:
            ;
            break;
        case GSRequestType_Register:
            ;
            break;
        case GSRequestType_ResetPwd:
            ;
            break;
        case GSRequestType_UpdateProfile:
            ;
            break;
        default:
            break;
    }

}

///< 管理端
#pragma mark - GSUserManagerProtocol

- (NSArray *)currentVisitor
{
    return [NSArray array];
}

- (NSArray *)currentChatterList
{
    return [NSArray array];
}

#pragma mark - Getter & Setter 

- (GSUserManagerRequester *)requester
{
    if (!_requester)
    {
        _requester = [[GSUserManagerRequester alloc] initWithDelegate:self];
    }
    return _requester;
}

- (ObserverContainer *)observers
{
    if (!_observers)
    {
        _observers = [[ObserverContainer alloc] init];
    }
    return _observers;
}

@end
