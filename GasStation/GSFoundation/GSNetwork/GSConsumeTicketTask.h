//
//  GSConsumeTicketTask.h
//  GasStation
//
//  Created by vedon on 3/1/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import "GSBaseRequest.h"
#import "GSConsumeTicketData.h"

@interface GSConsumeTicketTask : GSBaseRequest

- (instancetype)initWithConsumeData:(GSConsumeTicketData *)consumeData;

@end
