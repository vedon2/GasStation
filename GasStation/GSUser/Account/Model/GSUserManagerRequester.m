//
//  GSUserManagerRequester.m
//  GasStation
//
//  Created by vedon on 2/13/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import "GSUserManagerRequester.h"
#import "GSGetSmsCodeTask.h"
#import "GSRegisterTask.h"
#import "GSResetPassworkTask.h"
#import "GSUpdateUserProfileTask.h"

@interface GSUserManagerRequester ()<GSRequestBaseTaskDelegate>
@property (nonatomic,strong) GSGetSmsCodeTask *smsCodeTask;
@property (nonatomic,strong) GSRegisterTask *registerTask;
@property (nonatomic,strong) GSResetPassworkTask *resetPwdTask;
@end

@implementation GSUserManagerRequester

- (instancetype)initWithDelegate:(id<GSUserManagerRequesterDelegate>)delegate
{
    self = [super init];
    if (self)
    {
        self.delegate = delegate;
    }
    return self;
}

#pragma mark - GSUserInfoBaseProtocol


- (void)getSmsCodeWithPhont:(NSString *)phone
{
    assert(phone);
    if (self.smsCodeTask)
    {
        [self.smsCodeTask cancel];
    }
    
    self.smsCodeTask = [[GSGetSmsCodeTask alloc] initWithPhone:phone delegate:self];
    [self.smsCodeTask start];
}

- (void)registerWithPhone:(NSString *)phone password:(NSString *)password
{
    assert(phone);
    assert(password);
    if (self.registerTask)
    {
        [self.registerTask cancel];
    }
    
    if (phone.length && password.length)
    {
        self.registerTask = [[GSRegisterTask alloc] initWithPhone:phone password:password deleagte:self];
        [self.registerTask start];
    }
    
}

- (void)resetPasswordWithNewPassword:(NSString *)pwd
{
    assert(pwd);
    if (self.resetPwdTask)
    {
        [self.resetPwdTask cancel];
    }
    self.resetPwdTask = [[GSResetPassworkTask alloc] initWithNewPassword:pwd delegate:self];
}

- (void)updateUserProfile:(id)profileData
{
    
}

#pragma mark - GSRegisterTaskDelegate

- (void)task:(GSRequestBaseTask *)task didFinishWithData:(id)responseObject
{
    switch (task.requestType) {
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

- (void)task:(GSRequestBaseTask *)task didFailedWithData:(id)responseObject error:(NSError *)error
{
    switch (task.requestType) {
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

@end
