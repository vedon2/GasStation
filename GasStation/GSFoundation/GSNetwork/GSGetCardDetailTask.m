//
//  GSGetCardDetailTask.m
//  GasStation
//
//  Created by vedon on 3/1/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import "GSGetCardDetailTask.h"

@interface GSGetCardDetailTask ()
@property (nonatomic,strong) NSString *cardId;
@end

@implementation GSGetCardDetailTask

- (instancetype)initWithCardId:(NSString *)cardId
{
    assert(cardId);
    
    self = [super init];
    if (self)
    {
        self.cardId = cardId;
    }
    return self;
}

- (NSString *)requestUrl {
    return @"/tickets/detai";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGet;
}

- (id)requestArgument {
    return @{
             @"id": self.cardId,
             };
}

@end

