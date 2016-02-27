//
//  GSUserInfoProtocol.h
//  GasStation
//
//  Created by vedon on 2/27/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#ifndef GSUserInfoProtocol_h
#define GSUserInfoProtocol_h

#import "GSAccountDefine.h"

@protocol GSUserInfoProtocol <NSObject>

- (NSString *)nickname;

- (NSString *)userId;

- (NSString *)avatar;

- (UserGender)gender;

- (UserType)userType;


@end


#endif /* GSUserInfoProtocol_h */
