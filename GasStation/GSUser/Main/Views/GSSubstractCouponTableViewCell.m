//
//  GSSubstractCouponTableViewCell.m
//  GasStation
//
//  Created by vedon on 2/13/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import "GSSubstractCouponTableViewCell.h"

@implementation GSSubstractCouponTableViewCell

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
    return @"GSSubstractCouponTableViewCell";
}

- (void)configureWithData:(id)data
{
    
}

@end
