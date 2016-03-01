//
//  GSStartUpTask.h
//  GasStation
//
//  Created by vedon on 3/1/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import "GSBaseRequest.h"

@interface GSStartUpTask : GSBaseRequest

- (instancetype)initWithPlatform:(NSString *)platform version:(NSString *)version edition:(NSString *)edtion;

@end
