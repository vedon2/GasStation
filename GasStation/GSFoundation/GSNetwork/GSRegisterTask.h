//
//  GSRegisterTask.h
//  GasStation
//
//  Created by vedon on 2/13/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import "GSRequestBaseTask.h"

@interface GSRegisterTask : GSRequestBaseTask

- (instancetype)initWithPhone:(NSString *)phone password:(NSString *)password deleagte:(id<GSRequestBaseTaskDelegate>)delegate;

@end
