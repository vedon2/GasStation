//
//  GSUserAvatarTableViewCell.m
//  GasStation
//
//  Created by vedon on 2/20/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import "GSUserAvatarTableViewCell.h"
#import "GSColor.h"

@implementation GSUserAvatarTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.contentTitle.textColor = [GSColor userCenterCollectionCellTextColor];
    self.contentTitle.font = [UIFont systemFontOfSize:14];
    self.contentTitle.text = @"头像";
    
    self.avatarImageView.layer.cornerRadius = self.avatarImageView.frame.size.width / 2;
    self.avatarImageView.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configureWithImage:(UIImage *)image
{
    
}

@end
