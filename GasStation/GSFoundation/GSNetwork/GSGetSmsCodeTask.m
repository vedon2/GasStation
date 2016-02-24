//
//  GSGetSmsCodeTask.m
//  GasStation
//
//  Created by vedon on 2/13/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import "GSGetSmsCodeTask.h"
#import <SMS_SDK/SMSSDK.h>

@interface GSGetSmsCodeTask ()
@property (nonatomic,strong) NSString *phone;
@end

@implementation GSGetSmsCodeTask

- (instancetype)initWithPhone:(NSString *)phone
{
    
//    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:@"15018492358" zone:@"86" customIdentifier:nil result:^(NSError *error) {
//        ;
//    }];
    assert(phone);
    self = [super init];
    if(self)
    {
        self.phone = phone;
    }
    return self;
}

//
//- (NSString *)requestUrl {
//    // “http://www.yuantiku.com” 在 YTKNetworkConfig 中设置，这里只填除去域名剩余的网址信息
//    return @"/iphone/register";
//}
//
//- (YTKRequestMethod)requestMethod {
//    return YTKRequestMethodPost;
//}
//
//- (id)requestArgument {
//    return @{
//             @"phone": self.ph,
//             @"password": _password
//             };
//}

#pragma mark - GSBaseRequestMockProtocol

- (id)mockData
{
    return nil;
}

@end
