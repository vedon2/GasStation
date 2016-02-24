//
//  GSResetPassworkTask.h
//  GasStation
//
//  Created by vedon on 2/13/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import "GSBaseRequest.h"

@interface GSResetPassworkTask : GSBaseRequest

- (instancetype)initWithNewPassword:(NSString *)resetPassword oldPassword:(NSString *)oldPassword veriCode:(NSString *)veriCode phone:(NSString *)phone;
@end
