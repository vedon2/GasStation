//
//  GSGetCardDetailTask.h
//  GasStation
//
//  Created by vedon on 3/1/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import "GSBaseRequest.h"

@interface GSGetCardDetailTask : GSBaseRequest

- (instancetype)initWithCardId:(NSString *)cardId;
@end
