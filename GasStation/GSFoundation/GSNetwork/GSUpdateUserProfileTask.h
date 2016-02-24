//
//  GSUpdateUserProfileTask.h
//  GasStation
//
//  Created by vedon on 2/13/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import "GSBaseRequest.h"
@class GSUserProfileData;

@interface GSUpdateUserProfileTask : GSBaseRequest

- (instancetype)initWithProfileData:(GSUserProfileData *)profileData userId:(NSString *)userId;

@end
