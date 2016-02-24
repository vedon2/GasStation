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
    
    assert(phone);
    self = [super init];
    if(self)
    {
        self.phone = phone;
    }
    return self;
}

- (void)start
{
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:self.phone zone:@"86" customIdentifier:nil result:^(NSError *error) {
        
        if (!error)
        {
            if (self.delegate && [self.delegate respondsToSelector:@selector(requestFinished:)])
            {
                [self.delegate requestFinished:self];
            }
        }
        else
        {
            if (self.delegate && [self.delegate respondsToSelector:@selector(requestFailed:)])
            {
                [self.delegate requestFailed:self];
            }
        }
        
    }];
}

- (void)startWithCompletionBlockWithSuccess:(YTKRequestCompletionBlock)success failure:(YTKRequestCompletionBlock)failure
{
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:self.phone zone:@"86" customIdentifier:nil result:^(NSError *error) {
        
        if (!error)
        {
            if (success)
            {
                success(self);
            }
        }
        else
        {
            if (failure)
            {
                failure(self);
            }
        }
        
    }];
}

#pragma mark - GSBaseRequestMockProtocol

- (id)mockData
{
    //Do nothing
    return nil;
}

@end
