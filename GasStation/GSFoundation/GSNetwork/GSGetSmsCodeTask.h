//
//  GSGetSmsCodeTask.h
//  GasStation
//
//  Created by vedon on 2/13/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import "GSRequestBaseTask.h"

@interface GSGetSmsCodeTask : GSRequestBaseTask

- (instancetype)initWithPhone:(NSString *)phone delegate:(id<GSRequestBaseTaskDelegate>)delegate;

@end
