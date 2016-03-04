//
//  GSPriceOrderTableViewCell.h
//  GasStation
//
//  Created by vedon on 3/2/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GSPriceOrderTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *cellTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *cellPriceLabel;
@property (weak, nonatomic) IBOutlet UIView *bottomContainer;

- (void)configureWithData:(id)data;

@end
