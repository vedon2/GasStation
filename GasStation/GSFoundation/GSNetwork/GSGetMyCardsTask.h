//
//  GSGetMyCardsTask.h
//  GasStation
//
//  Created by vedon on 3/1/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import "GSBaseRequest.h"

@interface GSGetMyCardsTask : GSBaseRequest

- (instancetype)initWithUserId:(NSString *)userId pageIndex:(NSString *)pageIndex pageSize:(NSString *)pageSize;

@end
