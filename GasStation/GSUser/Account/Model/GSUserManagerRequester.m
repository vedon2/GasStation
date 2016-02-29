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
#import "GSLoginTask.h"
#import "GSUpdateUserProfileTask.h"
#import "GSUserProfileData.h"

@interface GSUserManagerRequester ()
@property (nonatomic,strong) GSGetSmsCodeTask *smsCodeTask;
@property (nonatomic,strong) GSRegisterTask *registerTask;
@property (nonatomic,strong) GSResetPassworkTask *resetPwdTask;
@property (nonatomic,strong) GSLoginTask *loginTask;
@property (nonatomic,strong) GSUpdateUserProfileTask *updateProfileTask;
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
        [self.smsCodeTask stop];
    }
    
    self.smsCodeTask = [[GSGetSmsCodeTask alloc] initWithPhone:phone];
    [self.smsCodeTask startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
        
        [self responseWithData:request.responseJSONObject taskType:GSRequestType_GetSmsCode isSuccess:YES];
        
    } failure:^(__kindof YTKBaseRequest *request) {
        
        [self responseWithData:request.responseJSONObject taskType:GSRequestType_GetSmsCode isSuccess:NO];
    }];
}

- (void)registerWithPhone:(NSString *)phone password:(NSString *)password veriCode:(NSString *)veriCode
{
    assert(phone);
    assert(password);
    if (self.registerTask)
    {
        [self.registerTask stop];
    }
    
    if (phone.length && password.length)
    {
        self.registerTask = [[GSRegisterTask alloc] initWithPhone:phone password:password veriCode:veriCode];
        [self.registerTask startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
            
            [self responseWithData:request.responseJSONObject taskType:GSRequestType_Register isSuccess:YES];
            
        } failure:^(__kindof YTKBaseRequest *request) {
            
            [self responseWithData:request.responseJSONObject taskType:GSRequestType_Register isSuccess:NO];
            
        }];
    }
    
}

- (void)loginWithPhone:(NSString *)phone password:(NSString *)password
{
    assert(phone);
    assert(password);
    
    if (self.loginTask)
    {
        [self.loginTask stop];
    }
    
    if (phone && password)
    {
        self.loginTask = [[GSLoginTask alloc] initWithPhone:phone password:password];
        [self.loginTask startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
            
            [self responseWithData:request.responseJSONObject taskType:GSRequestType_Login isSuccess:YES];
            
        } failure:^(__kindof YTKBaseRequest *request) {
            
            
            [self responseWithData:request.responseJSONObject taskType:GSRequestType_Login isSuccess:NO];
        }];
        
    }
}

- (void)resetPasswordWithNewPassword:(NSString *)pwd oldPassword:(NSString *)oldPassword veriCode:(NSString *)veriCode phone:(NSString *)phone
{
    assert(pwd);
    if (self.resetPwdTask)
    {
        [self.resetPwdTask stop];
    }
    self.resetPwdTask = [[GSResetPassworkTask alloc] initWithNewPassword:pwd oldPassword:oldPassword veriCode:veriCode phone:phone];
    
    [self.resetPwdTask startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
        
        [self responseWithData:request.responseJSONObject taskType:GSRequestType_ResetPwd isSuccess:YES];
        
    } failure:^(__kindof YTKBaseRequest *request) {
        
       [self responseWithData:request.responseJSONObject taskType:GSRequestType_ResetPwd isSuccess:NO];
        
    }];
}

- (void)updateUserProfile:(id)profileData userId:(NSString *)userId
{
    assert([profileData isKindOfClass:[GSUserProfileData class]]);
    if (self.updateProfileTask)
    {
        [self.updateProfileTask stop];
    }
    self.updateProfileTask = [[GSUpdateUserProfileTask alloc] initWithProfileData:profileData userId:userId];
    [self.updateProfileTask startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
        
        [self responseWithData:request.responseJSONObject taskType:GSRequestType_UpdateProfile isSuccess:YES];
        
    } failure:^(__kindof YTKBaseRequest *request) {
        
        [self responseWithData:request.responseJSONObject taskType:GSRequestType_UpdateProfile isSuccess:NO];
        
    }];
    
}

#pragma mark - Private

- (void)responseWithData:(id)responseJSONObject taskType:(GSRequestType)type isSuccess:(BOOL)isSuccess
{
    if (isSuccess)
    {
        if ([self.delegate respondsToSelector:@selector(requester:taskType:didFinishWithData:)])
        {
            [self.delegate requester:self taskType:type didFinishWithData:responseJSONObject];
        }
    }
    else
    {
        if ([self.delegate respondsToSelector:@selector(requester:taskType:didFinishWithData:)])
        {
            [self.delegate requester:self taskType:type didFailedWithData:responseJSONObject error:nil];
        }
    }
}


@end
