//
//  GSGetSmsCodeTask.h
//  GasStation
//
//  Created by vedon on 2/13/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import "GSBaseRequest.h"

@interface GSGetSmsCodeTask : GSBaseRequest
@property (nonatomic,strong,readonly) NSString *phone;

- (instancetype)initWithPhone:(NSString *)phone;


@end
