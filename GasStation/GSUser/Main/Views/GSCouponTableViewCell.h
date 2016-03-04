//
//  GSCouponTableViewCell.h
//  GasStation
//
//  Created by vedon on 3/4/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GSCouponTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *cellImageView;
@property (weak, nonatomic) IBOutlet UILabel *cellTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *cellSubtitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *gasStationLabel;

@property (weak, nonatomic) IBOutlet UILabel *consumLabel;
@end
