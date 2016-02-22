//
//  GSCardsSelectViewItemInfo.m
//  GasStation
//
//  Created by vedon on 2/22/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import "GSCardsSelectViewItemInfo.h"

@implementation GSCardsSelectViewItemInfo

- (instancetype)initWithTitle:(NSString *)title selectedColor:(UIColor *)selectedColor normalColor:(UIColor *)normalColor
{
    self = [super init];
    if (self)
    {
        self.title = title;
        self.selectedColor = selectedColor;
        self.normalColor = normalColor;
    }
    return self;
}

@end
