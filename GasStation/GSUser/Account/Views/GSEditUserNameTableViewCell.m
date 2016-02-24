//
//  GSEditUserNameTableViewCell.m
//  GasStation
//
//  Created by vedon on 2/20/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import "GSEditUserNameTableViewCell.h"
#import "GSColor.h"

@implementation GSEditUserNameTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.contentTitle.textColor = [GSColor userCenterCollectionCellTextColor];
    self.contentTitle.font = [UIFont systemFontOfSize:14];
    
    self.content.textColor = [GSColor registerPhoneTextFieldColor];
    self.content.font = [UIFont systemFontOfSize:14];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
