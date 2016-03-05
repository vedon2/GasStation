//
//  GSResetPassworkTask.m
//  GasStation
//
//  Created by vedon on 2/13/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import "GSResetPassworkTask.h"

@interface GSResetPassworkTask ()
@property (nonatomic,strong) NSString *resetPassword;
@property (nonatomic,strong) NSString *oldPassword;
@property (nonatomic,strong) NSString *veriCode;
@property (nonatomic,strong) NSString *phone;

@end

@implementation GSResetPassworkTask

- (instancetype)initWithNewPassword:(NSString *)resetPassword oldPassword:(NSString *)oldPassword veriCode:(NSString *)veriCode phone:(NSString *)phone
{
    self = [super init];
    if (self)
    {
        self.resetPassword = resetPassword;
        self.oldPassword = oldPassword;
        self.veriCode = veriCode;
        self.phone = phone;
    }
    return self;
}

- (NSString *)requestUrl {
    return @"/users/password";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPost;
}

- (id)requestArgument {
    return @{
             @"phone": self.phone,
             @"oldPassword":self.oldPassword,
             @"newPassword":self.resetPassword,
             @"verifiCode":self.veriCode
             };
}

#pragma mark - GSBaseRequestMockProtocol

- (id)mockData
{
    return @{@"statusCode":@(200)};
}
@end
