//
//  GSCardTableViewCell.m
//  GasStation
//
//  Created by vedon on 2/21/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import "GSMyCardTableViewCell.h"
#import "GSColor.h"
@interface GSMyCardTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *cartTitle;
@property (weak, nonatomic) IBOutlet UILabel *cardTitleDetailTitle;
@property (weak, nonatomic) IBOutlet UILabel *cardTitleDetailSubTitle;
@property (weak, nonatomic) IBOutlet UILabel *cardTitleDetailNumber;
@property (weak, nonatomic) IBOutlet UILabel *cardPrice;
@property (weak, nonatomic) IBOutlet UIImageView *cardStatusImage;
@property (weak, nonatomic) IBOutlet UIButton *useButton;

@end

@implementation GSMyCardTableViewCell

- (void)awakeFromNib
{
    self.cartTitle.textColor = [UIColor whiteColor];
    self.cardTitleDetailTitle.textColor = [GSColor cardDetailTitleColor];
    self.cardTitleDetailSubTitle.textColor = [GSColor cardDetailSubTitleColor];
    self.cardTitleDetailNumber.textColor = [GSColor cardDetailSubTitleColor];
    self.cardPrice.textColor = [GSColor mainColor];
    
    self.useButton.layer.cornerRadius = 6.0;
    self.useButton.layer.masksToBounds = YES;
    
    
    self.useButton.layer.borderColor = [GSColor cardDetailSubTitleColor].CGColor;
    self.useButton.layer.borderWidth = 1.0;
    [self.useButton setTitleColor:[GSColor cardDetailSubTitleColor] forState:UIControlStateNormal];
    self.cardPrice.attributedText = [self attributeTextForPrice:@"122" oldPrice:@"222"];
    self.cartTitle.attributedText = [self attributeTextForCardTitle:@"122"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - Private

- (NSAttributedString *)attributeTextForCardTitle:(NSString *)cardTitle
{
    assert(cardTitle);
    NSString *unitDesc = @"¥";
    NSString *desc = @"加油卷";
    NSString *contentStr = [NSString stringWithFormat:@"%@%@%@",unitDesc,cardTitle,desc];
    NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithString:contentStr];
    NSRange priceRange = NSMakeRange(unitDesc.length, cardTitle.length);
    
    [attribute addAttribute:NSFontAttributeName
                      value:[UIFont systemFontOfSize:12]
                      range:NSMakeRange(0, unitDesc.length)];
    [attribute addAttribute:NSFontAttributeName
                      value:[UIFont systemFontOfSize:30]
                      range:priceRange];
    [attribute addAttribute:NSFontAttributeName
                      value:[UIFont systemFontOfSize:12]
                      range:NSMakeRange(priceRange.length + priceRange.location, desc.length)];
    
    return attribute;
}

- (NSAttributedString *)attributeTextForPrice:(NSString *)price oldPrice:(NSString *)oldPrice
{
    assert(price);
    assert(oldPrice);
    
    NSString *paddingStr = @"  ";
    NSString *contentStr = [NSString stringWithFormat:@"%@%@%@",price,paddingStr,oldPrice];
    
    NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithString:contentStr];
    NSRange oldPriceRange = NSMakeRange(price.length + paddingStr.length, oldPrice.length);

    [attribute addAttribute:NSForegroundColorAttributeName
                        value:[GSColor mainColor]
                        range:NSMakeRange(0, price.length)];
    [attribute addAttribute:NSForegroundColorAttributeName
                      value:[GSColor cardDetailSubTitleColor]
                      range:oldPriceRange];
    [attribute addAttribute:NSFontAttributeName
                      value:[UIFont systemFontOfSize:20]
                      range:NSMakeRange(0, price.length)];
    [attribute addAttribute:NSFontAttributeName
                      value:[UIFont systemFontOfSize:12]
                      range:oldPriceRange];
    
    
    [attribute addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:oldPriceRange];
    [attribute addAttribute:NSStrikethroughColorAttributeName value:[GSColor cardDetailSubTitleColor] range:oldPriceRange];

    return attribute;
}



#pragma mark - Action


- (IBAction)userAction:(id)sender
{
    
}

@end
