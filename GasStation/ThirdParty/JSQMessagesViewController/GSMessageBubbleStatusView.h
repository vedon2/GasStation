//
//  GSMessageBubbleStatusView.h
//  JSQMessages
//
//  Created by vedon on 2/23/16.
//  Copyright © 2016 Hexed Bits. All rights reserved.
//



#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger,GSMessageBubbleStatus)
{
    GSMessageBubbleStatus_sending = 1,
    GSMessageBubbleStatus_finish,
    GSMessageBubbleStatus_fail,
};

@interface GSMessageBubbleStatusView : UIView

+ (CGSize)mimumStatusSize;

- (void)initializeInterface;

- (void)configureWithMessageStatus:(GSMessageBubbleStatus)status isUnread:(BOOL)isUnread;

@end
