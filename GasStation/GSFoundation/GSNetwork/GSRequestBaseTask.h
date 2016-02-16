//
//  GSRequestBaseTask.h
//  GasStation
//
//  Created by vedon on 2/13/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GSRequestTaskProtocol.h"

typedef NS_ENUM(NSUInteger,GSRequestMethodType)
{
    GSRequestMethodType_Get,
    GSRequestMethodType_Post,
    GSRequestMethodType_Unknown,
};


@class GSRequestBaseTask;
@protocol GSRequestBaseTaskDelegate <NSObject>

- (void)task:(GSRequestBaseTask *)task didFinishWithData:(id)responseObject;

- (void)task:(GSRequestBaseTask *)task didFailedWithData:(id)responseObject error:(NSError *)error;

@end

@interface GSRequestBaseTask : NSObject<GSRequestTaskProtocol>
@property (nonatomic,weak) id<GSRequestBaseTaskDelegate>delegate;
@property (nonatomic,assign) GSRequestType requestType;


- (instancetype)initWithUrl:(NSString *)url requestMethodType:(GSRequestMethodType)type parameters:(id)params delegate:(id<GSRequestBaseTaskDelegate>)delegate;

- (instancetype)initWithRequest:(NSURLRequest *)request delegate:(id<GSRequestBaseTaskDelegate>)delegate;

- (void)start;

- (void)pause;

- (void)cancel;

@end
