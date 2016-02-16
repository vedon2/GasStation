//
//  GSCommentTableViewCell.m
//  GasStation
//
//  Created by vedon on 2/13/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import "GSCommentTableViewCell.h"

@implementation GSCommentTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - GSSearchResultCellProtocol

+ (NSString *)cellIdentifier
{
    return @"GSCommentTableViewCell";
}

- (void)configureWithData:(id)data
{
    
}

@end
