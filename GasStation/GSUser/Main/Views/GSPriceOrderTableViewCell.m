//
//  GSPriceOrderTableViewCell.m
//  GasStation
//
//  Created by vedon on 3/2/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import "GSPriceOrderTableViewCell.h"

@implementation GSPriceOrderTableViewCell

- (void)awakeFromNib {
    
    self.cellTitleLabel.backgroundColor = [UIColor clearColor];
    self.cellPriceLabel.backgroundColor = [UIColor clearColor];
    self.bottomContainer.backgroundColor = [UIColor clearColor];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - Private

- (NSAttributedString *)attributeStringForPriceLabelWithText:(NSString *)text
{
    if (text.length)
    {

        NSString *unitDesc = @"  元/升";
        NSString *contentStr = [NSString stringWithFormat:@"%@%@",text,unitDesc];
        NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithString:contentStr];
        NSRange priceRange = NSMakeRange(0, text.length);
        NSRange unitRange = NSMakeRange(text.length, unitDesc.length);
        
        [attribute addAttribute:NSFontAttributeName
                          value:[UIFont systemFontOfSize:15]
                          range:priceRange];
        [attribute addAttribute:NSForegroundColorAttributeName
                          value:[UIColor redColor]
                          range:priceRange];
        
        
        [attribute addAttribute:NSFontAttributeName
                          value:[UIFont systemFontOfSize:12]
                          range:unitRange];
        return attribute;
    }
    
    return nil;
}

#pragma mark - Public

- (void)configureWithData:(id)data
{
    self.cellTitleLabel.text = @"壳牌加油站";
    self.cellPriceLabel.attributedText = [self attributeStringForPriceLabelWithText:@"6.39"];
}

@end
