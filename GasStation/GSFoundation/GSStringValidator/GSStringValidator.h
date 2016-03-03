//
//  GSStringValidator.h
//  GasStation
//
//  Created by vedon on 3/3/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GSStringValidator : NSObject

+ (BOOL)checkTelNumber:(NSString *) telNumber;

+ (BOOL)checkPassword:(NSString *) password;
@end
