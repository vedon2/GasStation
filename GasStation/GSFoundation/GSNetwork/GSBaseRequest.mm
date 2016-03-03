/*
 *****************************************************************************
 * Copyright (C) 2005-2014 UC Mobile Limited. All Rights Reserved
 * File			: GSBaseRequest.mm
 *
 * Description	: GSBaseRequest
 *
 * Author		: vedon@ucweb.com
 *
 * History		: Creation, 2/19/16, vedon@ucweb.com, Create the file
 ******************************************************************************
 **/

#ifdef DEBUG
#define kEnableMock 1
#define kEnableLog 1
#endif

#define kResponseSuccessStatusCode 200
#define kRequestDelayTime 3
#import "GSBaseRequest.h"

@implementation GSBaseRequest



#pragma mark - GSBaseRequestMockProtocol

- (BOOL)enableMock
{
#ifdef kEnableMock
    return YES;
#else
    return NO;
#endif
}

- (id)mockData
{
    //Subclass must override this funtion
    assert(0);
}

- (NSInteger)responseStatusCode
{
    if ([self enableMock])
    {
        return kRequestSuccess;
    }
    else
    {
        return [super responseStatusCode];
    }
}

#pragma mark - Override
- (void)start
{
#ifdef kEnableLog
    NSLog(@"Request URL: \n %@\nRequest header: \n  %@\nRequest Params: \n  %@",self.requestUrl,self.requestHeaderFieldValueDictionary,self.requestArgument);
#endif
    if ([self enableMock])
    {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kRequestDelayTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (self.delegate)
            {
                if ([self responseStatusCode] == kResponseSuccessStatusCode)
                {
                    if ([self.delegate respondsToSelector:@selector(requestFinished:)])
                    {
                        [self.delegate requestFinished:self];
                    }
                }
                else
                {
                    if ([self.delegate respondsToSelector:@selector(requestFailed:)])
                    {
                        [self.delegate requestFailed:self];
                    }
                }
            }
        });
    }
    else
    {

        [super start];
    }
}

- (void)startWithCompletionBlockWithSuccess:(YTKRequestCompletionBlock)success failure:(YTKRequestCompletionBlock)failure
{
#ifdef kEnableLog
    NSLog(@"Request URL: \n  %@ Request header: \n  %@ \n Request Params: \n  %@",self.requestUrl,self.requestHeaderFieldValueDictionary,self.requestArgument);
#endif
    if ([self enableMock])
    {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            if ([self responseStatusCode] == kResponseSuccessStatusCode)
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
            
        });
    }
    else
    {

        [super startWithCompletionBlockWithSuccess:success failure:failure];
        
    }
}

- (id)responseJSONObject
{
    if ([self enableMock])
    {
        return [self mockData];
    }
    else
    {
#ifdef kEnableLog
        NSLog(@"%@",[super responseJSONObject]);
#endif
       return [super responseJSONObject];
    }
}

- (NSDictionary *)requestHeaderFieldValueDictionary
{
    return @{@"version":@"1.0"};
}

@end
