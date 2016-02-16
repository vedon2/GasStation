//
//  GSBottomButtonInfo.m
//  GasStation
//
//  Created by vedon on 2/11/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import "GSBottomButtonInfo.h"

@interface GSBottomButtonInfo ()

@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) UIImage *image;
@end

@implementation GSBottomButtonInfo

- (instancetype)initWithTitle:(NSString *)title image:(UIImage *)image
{
    self = [super init];
    if (self)
    {
        self.title = title;
        self.image = image;
    }
    return self;
}

@end
