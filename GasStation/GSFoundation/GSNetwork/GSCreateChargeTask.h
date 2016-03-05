//
//  GSCreateChargeTask.h
//  GasStation
//
//  Created by vedon on 3/6/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import "GSBaseRequest.h"

@interface GSCreateChargeTask : GSBaseRequest

- (instancetype)initWithTargetId:(NSString *)targetId;

@end
