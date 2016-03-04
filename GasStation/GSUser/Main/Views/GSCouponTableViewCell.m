//
//  GSCouponTableViewCell.m
//  GasStation
//
//  Created by vedon on 3/4/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import "GSCouponTableViewCell.h"
#import "GSColor.h"

@implementation GSCouponTableViewCell

- (void)awakeFromNib {
    
    self.cellImageView.layer.cornerRadius = 2.0;
    self.cellImageView.layer.masksToBounds = YES;
    
    self.cellTitleLabel.textColor = [GSColor cardDetailTitleColor];
    self.cellSubtitleLabel.textColor = [GSColor cardDetailSubTitleColor];
    self.gasStationLabel.textColor = [GSColor cardDetailSubTitleColor];
    self.consumLabel.textColor = [GSColor cardDetailSubTitleColor];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
    // Configure the view for the selected state
}

@end
