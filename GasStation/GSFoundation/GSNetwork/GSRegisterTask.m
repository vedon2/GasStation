//
//  GSRegisterTask.m
//  GasStation
//
//  Created by vedon on 2/13/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import "GSRegisterTask.h"

@implementation GSRegisterTask

- (instancetype)initWithPhone:(NSString *)phone password:(NSString *)password deleagte:(id<GSRequestBaseTaskDelegate>)delegate
{
    assert(phone);
    assert(password);
    
    NSURLRequest *request = nil;
    self = [super initWithRequest:request delegate:delegate];
    self.requestType = GSRequestType_Register;
    if (self)
    {
        
    }
    return self;
}

@end
