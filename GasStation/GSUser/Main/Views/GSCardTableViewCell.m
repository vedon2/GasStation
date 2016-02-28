//
//  GSCardTableViewCell.m
//  GasStation
//
//  Created by vedon on 2/27/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import "GSCardTableViewCell.h"
#import "GSColor.h"
@interface GSCardTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *cartTitle;
@property (weak, nonatomic) IBOutlet UILabel *cardTitleDetailTitle;
@property (weak, nonatomic) IBOutlet UILabel *cardPrice;
@property (weak, nonatomic) IBOutlet UIImageView *cardStatusImage;
@property (weak, nonatomic) IBOutlet UIButton *useButton;
@property (weak, nonatomic) IBOutlet UIButton *firstCardDetailButton;
@property (weak, nonatomic) IBOutlet UIButton *secondCardDetailButton;

@end

@implementation GSCardTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.cartTitle.textColor = [UIColor whiteColor];
    self.cardTitleDetailTitle.textColor = [GSColor cardDetailTitleColor];
    self.cardPrice.textColor = [GSColor mainColor];
    
    self.useButton.layer.cornerRadius = 6.0;
    self.useButton.layer.masksToBounds = YES;
    
    self.firstCardDetailButton.layer.cornerRadius = 2;
    self.firstCardDetailButton.layer.masksToBounds = YES;
    self.firstCardDetailButton.userInteractionEnabled = NO;
    self.secondCardDetailButton.layer.cornerRadius = 2;
    self.secondCardDetailButton.layer.masksToBounds = YES;
    self.secondCardDetailButton.userInteractionEnabled = NO;
    
    //set backgrond
    self.firstCardDetailButton.backgroundColor = [UIColor whiteColor];
    self.secondCardDetailButton.backgroundColor = [UIColor whiteColor];
    
    //Set border
    self.firstCardDetailButton.layer.borderWidth = 1.0;
    self.firstCardDetailButton.layer.borderColor = [GSColor firstCardDetailButtonColor].CGColor;
    self.secondCardDetailButton.layer.borderWidth = 1.0;
    self.secondCardDetailButton.layer.borderColor = [GSColor secondCardDetailButtonColor].CGColor;
    
    
    NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithString:self.firstCardDetailButton.titleLabel.text];
    [attribute addAttribute:NSForegroundColorAttributeName
                      value:[GSColor firstCardDetailButtonColor]
                      range:NSMakeRange(0, attribute.length)];
    [self.firstCardDetailButton setAttributedTitle:attribute forState:UIControlStateNormal];
    
    attribute = [[NSMutableAttributedString alloc] initWithString:self.secondCardDetailButton.titleLabel.text];
    [attribute addAttribute:NSForegroundColorAttributeName
                      value:[GSColor secondCardDetailButtonColor]
                      range:NSMakeRange(0, attribute.length)];
    [self.secondCardDetailButton setAttributedTitle:attribute forState:UIControlStateNormal];
    
    
    
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


@end
