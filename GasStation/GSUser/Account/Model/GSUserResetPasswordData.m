//
//  GSUserResetPasswordData.m
//  GasStation
//
//  Created by vedon on 2/17/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import "GSUserResetPasswordData.h"

@interface GSUserResetPasswordData ()
@property (nonatomic,strong) NSString *resetPassword;
@end

@implementation GSUserResetPasswordData

- (instancetype)initWithPhone:(NSString *)phone password:(NSString *)password resetPassword:(NSString *)resetPwd verfiCode:(NSString *)code
{
    self = [super initWithPhone:phone password:password verfiCode:code];
    if (self)
    {
        self.resetPassword = resetPwd;
    }
    return self;
}

@end
