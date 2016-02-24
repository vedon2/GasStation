//
//  GSLoginTask.h
//  GasStation
//
//  Created by vedon on 2/24/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import "GSBaseRequest.h"

@interface GSLoginTask : GSBaseRequest

- (instancetype)initWithPhone:(NSString *)phone password:(NSString *)password;

@end
