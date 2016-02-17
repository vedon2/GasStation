//
//  GSUserRegisterData.m
//  GasStation
//
//  Created by vedon on 2/17/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import "GSUserRegisterData.h"

@interface GSUserRegisterData ()
@property (nonatomic,strong) NSString *phone;
@property (nonatomic,strong) NSString *password;
@property (nonatomic,strong) NSString *verifiCode;
@end

@implementation GSUserRegisterData

- (instancetype)initWithPhone:(NSString *)phone password:(NSString *)password verfiCode:(NSString *)code
{
    self = [super init];
    if (self)
    {
        self.phone = phone;
        self.password = password;
        self.verifiCode = code;
    }
    return self;
}

@end
