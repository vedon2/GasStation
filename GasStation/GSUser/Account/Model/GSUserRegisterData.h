//
//  GSUserRegisterData.h
//  GasStation
//
//  Created by vedon on 2/17/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GSUserRegisterData : NSObject
@property (nonatomic,strong,readonly) NSString *phone;
@property (nonatomic,strong,readonly) NSString *password;
@property (nonatomic,strong,readonly) NSString *verifiCode;

- (instancetype)initWithPhone:(NSString *)phone password:(NSString *)password verfiCode:(NSString *)code;
@end
