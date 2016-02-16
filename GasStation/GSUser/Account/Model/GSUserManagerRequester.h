//
//  GSUserManagerRequester.h
//  GasStation
//
//  Created by vedon on 2/13/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GSUserInfoBaseProtocol.h"

typedef NS_ENUM(NSInteger,GSUserManagerRequestType)
{
    GSUserManagerRequestType_SmsCode,
    GSUserManagerRequestType_Register,
    GSUserManagerRequestType_ResetPassword,
    GSUserManagerRequestType_UpdateProfile,
    GSUserManagerRequestType_Uknown,
};


@class GSUserManagerRequester;
@protocol GSUserManagerRequesterDelegate <NSObject>

- (void)requester:(GSUserManagerRequester *)requester taskType:(GSRequestType)type didFinishWithData:(id)responseObject;

- (void)requester:(GSUserManagerRequester *)requester taskType:(GSRequestType)type didFailedWithData:(id)responseObject error:(NSError *)error;

@end

@interface GSUserManagerRequester : NSObject<GSUserInfoBaseProtocol>
@property (nonatomic,weak) id<GSUserManagerRequesterDelegate> delegate;

- (instancetype)initWithDelegate:(id<GSUserManagerRequesterDelegate>)delegate;

@end
