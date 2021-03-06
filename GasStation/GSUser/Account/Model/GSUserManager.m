//
//  GSUserManager.m
//  GasStation
//
//  Created by vedon on 2/13/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#define kQuesryUserByIdCMD @"select * from '%@' where userId = '%@'"

#import "GSUserManager.h"
#import "GSUserManagerRequester.h"
#import "ObserverContainer.h"
#import "GSUserInfoTable.h"
#import "GSUserInfoRecord.h"
#import "GSUserRegisetResponseData.h"
#import "GSAccountMacro.h"
#import "GSUserInfoProtocol.h"

#import "GSPersistanceConfig.h"

@interface GSUserManager ()<GSUserManagerRequesterDelegate>
@property (nonatomic,strong) GSUserManagerRequester *requester;
@property (nonatomic,strong) ObserverContainer *observers;
@property (nonatomic,strong) GSUserInfoTable *userInfoTable;

@property (nonatomic,strong) id<GSUserInfoProtocol>currentUserInfo;
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

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.userInfoTable = [[GSUserInfoTable alloc] init];
    }
    return self;

}

#pragma mark - Public

- (BOOL)isLogin
{
    NSError *error = nil;
    if (self.currentUserInfo)
    {
        return YES;
    }
    else
    {
        GSUserInfoRecord *record = (GSUserInfoRecord *)[self.userInfoTable findLatestRecordWithError:&error];
        self.currentUserInfo = record;
        return (record != nil);
    }
   
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

- (void)logout
{
    NSError *queryError = nil;
    GSUserInfoRecord *existUserRecord = (GSUserInfoRecord *)[self.userInfoTable findFirstRowWithSQL:[NSString stringWithFormat:kQuesryUserByIdCMD,[GSPersistanceConfig userInfoTableName],[self.currentUserInfo userId]] params:nil error:&queryError];
    assert(queryError == nil);
    [self.userInfoTable deleteRecord:existUserRecord error:&queryError];
    assert(queryError == nil);
    self.currentUserInfo = nil;
    
    
    [self.observers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj respondsToSelector:@selector(userLogout)])
        {
            [obj userLogout];
        }
    }];
    
}

#pragma mark - Private

- (void)saveUserInfo:(NSDictionary *)userInfo
{
    assert(userInfo);
    if (userInfo)
    {
        NSError *error = nil;
        
        GSUserInfoRecord *record = [[GSUserInfoRecord alloc] init];
        record.userId = [userInfo objectForKey:@"id"];
        record.nickname = [userInfo objectForKey:@"nickname"];
        record.avatar = [userInfo objectForKey:@"avatar"];
        record.gender = [[userInfo objectForKey:@"gender"] integerValue];
        record.userType = [[userInfo objectForKey:@"userType"] integerValue];
        
        [self.userInfoTable insertRecord:record error:&error];
        self.currentUserInfo = record;
        assert(error == nil);
        
#ifdef kAccountDebugMode
        [self.userInfoTable deleteRecord:record error:&error];
        assert(error == nil);
#endif
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


- (void)registerWithPhone:(NSString *)phone password:(NSString *)password veriCode:(NSString *)veriCode
{
    assert(password);
    assert(veriCode);
    assert(phone);
    
    if (password && phone && veriCode)
    {
        [self.requester registerWithPhone:phone password:password veriCode:veriCode];
    }
}

- (void)loginWithPhone:(NSString *)phone password:(NSString *)password
{
    assert(phone);
    assert(password);
    if (phone && password)
    {
        [self.requester loginWithPhone:phone password:password];
    }
}

- (void)resetPasswordWithNewPassword:(NSString *)pwd oldPassword:(NSString *)oldPassword veriCode:(NSString *)veriCode phone:(NSString *)phone
{
    assert(pwd);
    if (pwd)
    {
        [self.requester resetPasswordWithNewPassword:pwd oldPassword:oldPassword veriCode:veriCode phone:phone];
    }
}

- (void)updateUserProfile:(id)profileData userId:(NSString *)userId
{
    assert(profileData);
    assert(userId);
    
    if (userId && profileData)
    {
        [self.requester updateUserProfile:profileData userId:userId];
    }
}

#pragma mark - GSUserManagerRequesterDelegate


- (void)requester:(GSUserManagerRequester *)requester taskType:(GSRequestType)type didFinishWithData:(id)responseObject
{
    switch (type) {
        
        case GSRequestType_Register:
            [self.observers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                
                if ([obj respondsToSelector:@selector(userRegisterSuccess)])
                {
                    [obj userRegisterSuccess];
                }
                
                if ([obj respondsToSelector:@selector(userLoginOk)])
                {
                    [obj userLoginOk];
                }
            }];
            [self saveUserInfo:responseObject];
            break;
        case GSRequestType_Login:
        {
            [self.observers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                
                if ([obj respondsToSelector:@selector(userLoginOk)])
                {
                    [obj userLoginOk];
                }
            }];
        }
            break;
        case GSRequestType_GetSmsCode:
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
            [self.observers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                
                if ([obj respondsToSelector:@selector(userRegisterSuccess)])
                {
                    [obj userRegisterSuccess];
                }
                
            }];
            
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
