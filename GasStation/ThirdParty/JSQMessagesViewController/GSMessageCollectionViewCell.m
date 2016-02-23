//
//  GSMessageCollectionViewCell.m
//  JSQMessages
//
//  Created by vedon on 2/19/16.
//  Copyright © 2016 Hexed Bits. All rights reserved.
//

#import "GSMessageCollectionViewCell.h"
#import "PureLayout.h"
#import "GSMessageBubbleStatusView.h"

@implementation GSMessageCollectionViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
}

- (GSMessageBubbleStatusView *)messageStatusView
{
    GSMessageBubbleStatusView *messageStatusView = [[GSMessageBubbleStatusView alloc] initForAutoLayout];
    messageStatusView.translatesAutoresizingMaskIntoConstraints = NO;
    messageStatusView.backgroundColor = [UIColor clearColor];
    return messageStatusView;
}

- (void)addStatusViewForOutgoingCell
{
    GSMessageBubbleStatusView *statusView = [self messageStatusView];
    [self.contentView addSubview:statusView];
    [statusView autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.messageBubbleContainerView];
    [statusView autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:self.messageBubbleContainerView];
    [statusView autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.messageBubbleContainerView];
    [statusView autoSetDimension:ALDimensionWidth toSize:[GSMessageBubbleStatusView mimumStatusSize].width];
    [statusView initializeInterface];
}

- (void)addStatusViewForInComingCell
{
    GSMessageBubbleStatusView *statusView = [self messageStatusView];
    [self.contentView addSubview:statusView];
    [statusView autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.textView];
    [statusView autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.textView];
    [statusView autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.textView];
    [statusView autoSetDimension:ALDimensionWidth toSize:[GSMessageBubbleStatusView mimumStatusSize].width];
    [statusView initializeInterface];
}

@end
