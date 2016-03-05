//
//  GSConsumeTicketTask.m
//  GasStation
//
//  Created by vedon on 3/1/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import "GSConsumeTicketTask.h"
@interface GSConsumeTicketTask()
@property (nonatomic,strong) GSConsumeTicketData *consumeTicketData;

@end

@implementation GSConsumeTicketTask

- (instancetype)initWithConsumeData:(GSConsumeTicketData *)consumeData
{
    assert(consumeData);
    self = [super init];
    if (self)
    {
        self.consumeTicketData = consumeData;
    }
    return self;
}

- (NSString *)requestUrl {
    return @"/tickets/spend";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodPost;
}

- (id)requestArgument {
    return @{
             @"ticketNo": self.consumeTicketData.ticketNo,
             @"phone": self.consumeTicketData.phone,
             @"stationId": self.consumeTicketData.stationId,
             @"timestamp": self.consumeTicketData.timestamp,
             @"validation": self.consumeTicketData.validation,
             };
}

#pragma mark - GSBaseRequestMockProtocol

- (id)mockData
{
    return @{@"statusCode":@(1000)};
}

@end
