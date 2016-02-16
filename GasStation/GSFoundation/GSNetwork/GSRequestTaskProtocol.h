//
//  GSRequestTaskProtocol.h
//  GasStation
//
//  Created by vedon on 2/13/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#ifndef GSRequestTaskProtocol_h
#define GSRequestTaskProtocol_h
#import <UIKit/UIKit.h>
#import "GSUserInfoBaseProtocol.h"

@protocol GSRequestTaskProtocol <NSObject>

@optional
- (NSInteger)retryCount;

- (CGFloat)requestTimeout;

- (NSString *)requestTaskIdentifier;

- (void)requestDidFinishWithData:(id)data;

- (void)requestDidFailWithData:(id)data error:(NSError *)error;

@end


#endif /* GSRequestTaskProtocol_h */
