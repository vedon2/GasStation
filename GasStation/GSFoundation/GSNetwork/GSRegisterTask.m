//
//  GSRegisterTask.m
//  GasStation
//
//  Created by vedon on 2/13/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import "GSRegisterTask.h"

@interface GSRegisterTask ()
@property (nonatomic,strong) NSString *phone;
@property (nonatomic,strong) NSString *password;
@property (nonatomic,strong) NSString *veriCode;
@end

@implementation GSRegisterTask

- (instancetype)initWithPhone:(NSString *)phone password:(NSString *)password veriCode:(NSString *)veriCode
{
    assert(phone);
    assert(password);
    self = [super init];
    if (self)
    {
        self.phone = phone;
        self.password = password;
        self.veriCode = veriCode;
    }
    return self;
}


- (NSString *)requestUrl {
    return @"/oil/api/users/register";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPost;
}

- (id)requestArgument {
    return @{
             @"phone": self.phone,
             @"password": self.password,
             @"verifiCode": self.veriCode,
             };
}

#pragma mark - GSBaseRequestMockProtocol

- (id)mockData
{
    return @{@"nickname": @"vedon",
             @"id": @"kuserId123",
             @"avatar": @"",
             @"gender": @(0),
             @"userType": @(0),
             @"statusCode": @(10000)
             };
}
@end
