//
//  GSGetMyCardDetailTask.m
//  GasStation
//
//  Created by vedon on 3/1/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import "GSGetMyCardDetailTask.h"

@interface GSGetMyCardDetailTask ()
@property (nonatomic,strong) NSString *cardId;
@end

@implementation GSGetMyCardDetailTask

- (instancetype)initWithCardId:(NSString *)cardId
{
    
    assert(cardId);
    self= [super init];
    if (self)
    {
        self.cardId = cardId;
    }
    return self;
}

- (NSString *)requestUrl {
    return @"/tickets/detail/mime";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGet;
}

- (id)requestArgument {
    return @{
             @"myTicketId": self.cardId,
             };
}

#pragma mark - GSBaseRequestMockProtocol

- (id)mockData
{
    return @{@"statusCode":@(1000)};
}


@end
