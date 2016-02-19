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
    // “http://www.yuantiku.com” 在 YTKNetworkConfig 中设置，这里只填除去域名剩余的网址信息
    return @"/iphone/register";
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


@end
