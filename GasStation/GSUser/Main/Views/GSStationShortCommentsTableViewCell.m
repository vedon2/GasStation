//
//  GSStationShortCommentsTableViewCell.m
//  GasStation
//
//  Created by vedon on 2/13/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import "GSStationShortCommentsTableViewCell.h"
#import "GSStationShortCommentsView.h"
#import "PureLayout.h"

@interface GSStationShortCommentsTableViewCell()<GSStationShortCommentsViewDelegate>
@property (strong, nonatomic)  GSStationShortCommentsView *commentsView;

@end

@implementation GSStationShortCommentsTableViewCell

- (void)awakeFromNib {
    [self.contentView addSubview:self.commentsView];
    [self.commentsView autoPinEdgesToSuperviewEdges];
    [self.commentsView autoSetDimension:ALDimensionHeight toSize:[self.commentsView heightForCommentsView]];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - GSSearchResultCellProtocol

+ (NSString *)cellIdentifier
{
    return @"GSStationShortCommentsTableViewCell";
}

- (void)configureWithData:(id)data
{
    //TODO： 更新好评，差评等的数据
    [self.commentsView configureWithData:data];
}

#pragma mark - GSStationShortCommentsViewDelegate

- (void)didTapMoreCommentCell
{
    if ([self.delegate respondsToSelector:@selector(didTapMoreCommentCell)])
    {
        [self.delegate didTapMoreCommentCell];
    }
}

#pragma mark - Getter & Setter

- (GSStationShortCommentsView *)commentsView
{
    if (!_commentsView)
    {
        _commentsView = [[GSStationShortCommentsView alloc] initWithDelegate:self];
        _commentsView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _commentsView;
}

@end
