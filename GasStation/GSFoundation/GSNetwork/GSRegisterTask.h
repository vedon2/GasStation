//
//  GSRegisterTask.h
//  GasStation
//
//  Created by vedon on 2/13/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import "GSBaseRequest.h"

@interface GSRegisterTask : GSBaseRequest
@property (nonatomic,strong,readonly) NSString *phone;
@property (nonatomic,strong,readonly) NSString *password;

- (instancetype)initWithPhone:(NSString *)phone password:(NSString *)password veriCode:(NSString *)veriCode;

@end
