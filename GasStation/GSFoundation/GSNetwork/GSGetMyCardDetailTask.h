//
//  GSGetMyCardDetailTask.h
//  GasStation
//
//  Created by vedon on 3/1/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import "GSBaseRequest.h"

@interface GSGetMyCardDetailTask : GSBaseRequest
- (instancetype)initWithCardId:(NSString *)cardId;
@end
