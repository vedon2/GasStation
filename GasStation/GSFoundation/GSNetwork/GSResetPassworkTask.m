//
//  GSResetPassworkTask.m
//  GasStation
//
//  Created by vedon on 2/13/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import "GSResetPassworkTask.h"

@interface GSResetPassworkTask ()
@property (nonatomic,strong) NSString *password;
@end

@implementation GSResetPassworkTask

- (instancetype)initWithNewPassword:(NSString *)password
{
    self = [super init];
    if (self)
    {
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
             @"password": self.password
             };
}


@end
