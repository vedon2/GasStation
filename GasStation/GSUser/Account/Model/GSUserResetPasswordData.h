//
//  GSUserResetPasswordData.h
//  GasStation
//
//  Created by vedon on 2/17/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import "GSUserRegisterData.h"

@interface GSUserResetPasswordData : GSUserRegisterData

@property (strong,nonatomic,readonly) NSString *resetPassword;

- (instancetype)initWithPhone:(NSString *)phone password:(NSString *)password resetPassword:(NSString *)resetPwd verfiCode:(NSString *)code;

@end
