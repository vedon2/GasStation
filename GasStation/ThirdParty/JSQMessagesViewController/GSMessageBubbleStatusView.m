//
//  GSMessageBubbleStatusView.m
//  JSQMessages
//
//  Created by vedon on 2/23/16.
//  Copyright © 2016 Hexed Bits. All rights reserved.
//

#define kUnreadIndicatorTopPadding 5
#define kUnreadIndicatorSize 6
#define kFailIndicatorLeftPadding 10
#define kFailIndicatorSize 15
#define kActivityIndicatorView 10


#import "GSMessageBubbleStatusView.h"
#import "PureLayout.h"

@interface GSMessageBubbleStatusView ()
@property (nonatomic,strong) UIImageView *unreadIndicatorImageView;
@property (nonatomic,strong) UIImageView *failIndicatorImageView;
@property (nonatomic,strong) UIActivityIndicatorView *activityIndicatorView;

@property (nonatomic,strong) UIView *indicatorContainerView;
@end

@implementation GSMessageBubbleStatusView

+ (CGSize)mimumStatusSize
{
   return CGSizeMake(30, 20);
}

- (void)configureWithMessageStatus:(GSMessageBubbleStatus)status isUnread:(BOOL)isUnread
{
    self.unreadIndicatorImageView.hidden = !isUnread;
    
    switch (status) {
        case GSMessageBubbleStatus_sending:
        {
            self.activityIndicatorView.hidden = NO;
            [self.activityIndicatorView startAnimating];
        }
            break;
        
        case GSMessageBubbleStatus_fail:
        {
            self.activityIndicatorView.hidden = YES;
            [self.activityIndicatorView stopAnimating];
            self.failIndicatorImageView.hidden = NO;
        }
            break;
        case GSMessageBubbleStatus_finish:
        {
            self.activityIndicatorView.hidden = YES;
            [self.activityIndicatorView stopAnimating];
            self.failIndicatorImageView.hidden = YES;
        }
            break;
        default:
            break;
    }
}

- (void)initializeInterface
{
    self.unreadIndicatorImageView = [[UIImageView alloc] initForAutoLayout];
    self.unreadIndicatorImageView.backgroundColor = [UIColor redColor];
    self.unreadIndicatorImageView.layer.cornerRadius = kUnreadIndicatorSize/2;
    self.unreadIndicatorImageView.layer.masksToBounds = YES;
    [self addSubview:self.unreadIndicatorImageView];
    
    [self.unreadIndicatorImageView autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self withOffset:kUnreadIndicatorTopPadding];
    [self.unreadIndicatorImageView autoAlignAxis:ALAxisVertical toSameAxisOfView:self];
    [self.unreadIndicatorImageView autoSetDimensionsToSize:CGSizeMake(kUnreadIndicatorSize, kUnreadIndicatorSize)];
    
    self.failIndicatorImageView = [[UIImageView alloc] initForAutoLayout];
    self.failIndicatorImageView.backgroundColor = [UIColor redColor];
    self.failIndicatorImageView.layer.cornerRadius = kFailIndicatorSize/2;
    self.failIndicatorImageView.layer.masksToBounds = YES;
    [self addSubview:self.failIndicatorImageView];
    
    [self.failIndicatorImageView autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self];
    [self.failIndicatorImageView autoAlignAxis:ALAxisVertical toSameAxisOfView:self];
    [self.failIndicatorImageView autoSetDimensionsToSize:CGSizeMake(kFailIndicatorSize, kFailIndicatorSize)];
    
    
    self.activityIndicatorView = [[UIActivityIndicatorView alloc] initForAutoLayout];
    [self addSubview:self.activityIndicatorView];
    
    [self.activityIndicatorView autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self];
    [self.activityIndicatorView autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self withOffset:kFailIndicatorLeftPadding];
    [self.activityIndicatorView autoSetDimensionsToSize:CGSizeMake(kActivityIndicatorView, kActivityIndicatorView)];
    
    [self configureWithMessageStatus:GSMessageBubbleStatus_finish isUnread:YES];
}

@end
