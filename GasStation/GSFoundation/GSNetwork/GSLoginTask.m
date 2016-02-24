//
//  GSLoginTask.m
//  GasStation
//
//  Created by vedon on 2/24/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import "GSLoginTask.h"

@interface GSLoginTask ()
@property (strong,nonatomic) NSString *phone;
@property (strong,nonatomic) NSString *password;
@end

@implementation GSLoginTask

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
    return @"/oil/api/users/login";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPost;
}

- (id)requestArgument {
    return @{
             @"phone": self.phone,
             @"password":self.password
             };
}


#pragma mark - GSBaseRequestMockProtocol

- (id)mockData
{
    return @{@"nickname": @"vedon",
             @"id": @"kuserId123",
             @"avatar": @"",
             @"token": @"123",
             @"gender": @(0),
             @"phone": @(1123),
             @"statusCode": @(200)
             };
}

@end
