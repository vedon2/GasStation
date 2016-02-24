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
#endif

#define kResponseSuccessStatusCode 200
#define kRequestDelayTime 3
#import "GSBaseRequest.h"

@implementation GSBaseRequest

#pragma mark - Public

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

- (void)start
{
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
        assert(0); //Subclaass must override this function
        return nil;
    }
    else
    {
       return [super responseJSONObject];
    }
}

- (NSInteger)responseStatusCode
{
    if ([self enableMock])
    {
        assert(0); //Subclaass must override this function
        return 200;
    }
    else
    {
        return [super responseStatusCode];
    }
}


@end
