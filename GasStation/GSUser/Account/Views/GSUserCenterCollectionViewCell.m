//
//  GSUserCenterCollectionViewCell.m
//  GasStation
//
//  Created by vedon on 2/16/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import "GSUserCenterCollectionViewCell.h"
#import "GSColor.h"

@implementation GSUserCenterCollectionViewCell

- (void)awakeFromNib {
    
    self.cellImage.backgroundColor = [UIColor clearColor];
    self.backgroundColor = [UIColor whiteColor];
    self.cellTitle.textColor = [GSColor userCenterCollectionCellTextColor];
    // Initialization code
}

@end
