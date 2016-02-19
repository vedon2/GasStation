//
//  GSResetPassworkTask.h
//  GasStation
//
//  Created by vedon on 2/13/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import "GSBaseRequest.h"

@interface GSResetPassworkTask : GSBaseRequest
@property (nonatomic,strong,readonly) NSString *password;

- (instancetype)initWithNewPassword:(NSString *)password;
@end
