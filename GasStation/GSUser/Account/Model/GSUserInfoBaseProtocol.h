//
//  GSUserInfoBaseProtocol.h
//  GasStation
//
//  Created by vedon on 2/13/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#ifndef GSUserInfoBaseProtocol_h
#define GSUserInfoBaseProtocol_h

typedef NS_ENUM(NSUInteger,GSRequestType)
{
    GSRequestType_GetSmsCode,
    GSRequestType_Register,
    GSRequestType_ResetPwd,
    GSRequestType_UpdateProfile,
    GSRequestType_Unknown,
};

@protocol GSUserInfoBaseProtocol <NSObject>

- (void)getSmsCodeWithPhont:(NSString *)phone;

- (void)registerWithPhone:(NSString *)phone password:(NSString *)password;

- (void)resetPasswordWithNewPassword:(NSString *)pwd;

- (void)updateUserProfile:(id)profileData;

@end

#endif /* GSUserInfoBaseProtocol_h */
