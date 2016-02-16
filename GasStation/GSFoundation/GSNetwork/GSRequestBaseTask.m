//
//  GSRequestBaseTask.m
//  GasStation
//
//  Created by vedon on 2/13/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import "GSRequestBaseTask.h"
#import "AFNetworking.h"
#import "AFNetworkReachabilityManager.h"

@interface GSRequestBaseTask ()
@property (nonatomic,strong) NSURLSessionDataTask * dataTask;
@end

@implementation GSRequestBaseTask

- (instancetype)initWithUrl:(NSString *)url requestMethodType:(GSRequestMethodType)type parameters:(id)params delegate:(id<GSRequestBaseTaskDelegate>)delegate
{
    assert(url);
    self = [super init];
    if (self)
    {
        if (url)
        {
            self.delegate = delegate;
            __weak GSRequestBaseTask *weakSelf = self;
            switch (type) {
                case GSRequestMethodType_Get:
                {
                    self.dataTask = [[AFHTTPSessionManager manager] GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                        [weakSelf requestDidFinishWithData:responseObject];
                    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                        [weakSelf requestDidFailWithData:nil error:error];
                    }];
                    break;
                }
                    
                case GSRequestMethodType_Post:
                {
                    self.dataTask =  [[AFHTTPSessionManager manager] POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                        [weakSelf requestDidFinishWithData:responseObject];
                    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                        [weakSelf requestDidFailWithData:nil error:error];
                    }];
                    break;
                }
                default:
                    break;
            }
        }
    }
    return self;
}

- (instancetype)initWithRequest:(NSURLRequest *)request delegate:(id<GSRequestBaseTaskDelegate>)delegate
{
    assert(request);
    
    self = [self init];
    if (self)
    {
        self.delegate = delegate;
        __weak GSRequestBaseTask *weakSelf = self;
        self.dataTask = [[AFHTTPSessionManager manager] dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
            if (error)
            {
                [weakSelf requestDidFailWithData:responseObject error:error];
            }
            else
            {
                [weakSelf requestDidFinishWithData:responseObject];
            }
        }];
    }
    return self;
}

- (void)start
{
    if ([self isNetworkOk])
    {
        [self.dataTask resume];
    }
    else
    {
        NSError *error = [NSError errorWithDomain:@"Network unreachable" code:1 userInfo:nil];
        [self requestDidFailWithData:nil error:error];
    }
}

- (void)pause
{
    [self.dataTask suspend];
}

- (void)cancel
{
    [self.dataTask cancel];
}

#pragma mark - Private

- (BOOL)isNetworkOk
{
    return [[AFNetworkReachabilityManager sharedManager] isReachable];
}

#pragma mark - GSRequestTaskProtocol

- (NSInteger)retryCount
{
    return  1;
}

- (CGFloat)requestTimeout
{
    return 10;
}

- (NSString *)requestTaskIdentifier
{
    return @"GSRequestBaseTask";
}

- (void)requestDidFinishWithData:(id)data
{
    if ([self.delegate respondsToSelector:@selector(task:didFinishWithData:)])
    {
        [self.delegate task:self didFinishWithData:data];
    }
}

- (void)requestDidFailWithData:(id)data error:(NSError *)error
{
    
    if ([self.delegate respondsToSelector:@selector(task:didFailedWithData:error:)])
    {
        [self.delegate task:self didFailedWithData:data error:error];
    }
}



@end
