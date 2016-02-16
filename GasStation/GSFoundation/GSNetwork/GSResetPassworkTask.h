//
//  GSResetPassworkTask.h
//  GasStation
//
//  Created by vedon on 2/13/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import "GSRequestBaseTask.h"

@interface GSResetPassworkTask : GSRequestBaseTask

- (instancetype)initWithNewPassword:(NSString *)password delegate:(id<GSRequestBaseTaskDelegate>)delegate;

@end
