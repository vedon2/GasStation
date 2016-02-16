//
//  GSCommentTypeTableViewCell.m
//  GasStation
//
//  Created by vedon on 2/13/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import "GSCommentTypeTableViewCell.h"
@interface GSCommentTypeTableViewCell ()

@end

@implementation GSCommentTypeTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - Action

- (IBAction)allCommentAction:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(didTapCommentType:)])
    {
        [self.delegate didTapCommentType:GSCommentType_All];
    }
}

- (IBAction)favourableCommentAction:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(didTapCommentType:)])
    {
        [self.delegate didTapCommentType:GSCommentType_High];
    }
}

- (IBAction)middleCommentAction:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(didTapCommentType:)])
    {
        [self.delegate didTapCommentType:GSCommentType_Middle];
    }
}

- (IBAction)badCommentAction:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(didTapCommentType:)])
    {
        [self.delegate didTapCommentType:GSCommentType_Bad];
    }
}

#pragma mark - GSSearchResultCellProtocol

+ (NSString *)cellIdentifier
{
    return @"GSCommentTypeTableViewCell";
}

- (void)configureWithData:(id)data
{
    
}

@end
