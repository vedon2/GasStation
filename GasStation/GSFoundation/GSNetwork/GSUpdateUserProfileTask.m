//
//  GSUpdateUserProfileTask.m
//  GasStation
//
//  Created by vedon on 2/13/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import "GSUpdateUserProfileTask.h"
#import "GSUserProfileData.h"

@interface GSUpdateUserProfileTask ()
@property (nonatomic,strong) GSUserProfileData *profileData;
@property (nonatomic,strong) NSString *userId;
@end
@implementation GSUpdateUserProfileTask

- (instancetype)initWithProfileData:(GSUserProfileData *)profileData userId:(NSString *)userId
{
    self = [super init];
    if (self)
    {
        self.profileData = profileData;
        self.userId = userId;
    }
    return self;
}


- (NSString *)requestUrl {
    return @"/oil/api/users/profile";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPost;
}

- (id)requestArgument {
    return @{
             @"nickname": self.profileData.nickname,
             @"avatar": self.profileData.avatar,
             @"gender":self.profileData.gender
             };
}

#pragma mark - GSBaseRequestMockProtocol

- (id)mockData
{
    return @{@"statusCode":@(200)};
}
@end
