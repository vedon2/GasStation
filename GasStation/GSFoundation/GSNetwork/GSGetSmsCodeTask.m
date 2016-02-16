//
//  GSGetSmsCodeTask.m
//  GasStation
//
//  Created by vedon on 2/13/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import "GSGetSmsCodeTask.h"

@implementation GSGetSmsCodeTask


- (instancetype)initWithPhone:(NSString *)phone delegate:(id<GSRequestBaseTaskDelegate>)delegate;
{
    assert(phone);
    
    NSURLRequest *request = nil;
    self = [super initWithRequest:request delegate:delegate];
    self.requestType = GSRequestType_GetSmsCode;
    if(self)
    {

    }
    return self;
}

#pragma mark - GSRequestTaskProtocol

- (NSInteger)retryCount
{
    return  1;
}

- (CGFloat)requestTimeout
{
    return 10;
}

- (NSString *)requestTaskIdentifier
{
    return @"GSGetSmsCodeTask";
}



@end
