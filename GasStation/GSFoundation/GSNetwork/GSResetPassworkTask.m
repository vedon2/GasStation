//
//  GSResetPassworkTask.m
//  GasStation
//
//  Created by vedon on 2/13/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import "GSResetPassworkTask.h"

@implementation GSResetPassworkTask

- (instancetype)initWithNewPassword:(NSString *)password delegate:(id<GSRequestBaseTaskDelegate>)delegate
{
    NSURLRequest *request = nil;
    
    self = [super initWithRequest:request delegate:delegate];
    self.requestType = GSRequestType_ResetPwd;
    if (self)
    {
        
    }
    return self;
}


@end
