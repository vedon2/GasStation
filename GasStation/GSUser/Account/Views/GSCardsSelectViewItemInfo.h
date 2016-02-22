//
//  GSCardsSelectViewItemInfo.h
//  GasStation
//
//  Created by vedon on 2/22/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GSCardsSelectViewItemInfo : NSObject
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) UIColor *selectedColor;
@property (nonatomic,strong) UIColor *normalColor;

- (instancetype)initWithTitle:(NSString *)title selectedColor:(UIColor *)selectedColor normalColor:(UIColor *)normalColor;

@end
