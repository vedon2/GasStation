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
@end

@implementation GSRegisterTask

- (instancetype)initWithPhone:(NSString *)phone password:(NSString *)password
{
    assert(phone);
    assert(password);
    self = [super init];
    if (self)
    {
        self.phone = phone;
        self.password = password;
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
             @"password": self.password
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
