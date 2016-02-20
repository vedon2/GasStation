//
//  GSMapBottomBar.h
//  GasStation
//
//  Created by vedon on 2/11/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GSBottomButtonInfo.h"

@protocol GSMapBottomBarDelegate <NSObject>

- (void)didSelectButtonIndex:(NSUInteger)index;

@end

@interface GSMapBottomBar : UIView
@property (nonatomic,weak) id<GSMapBottomBarDelegate>delegate;

- (instancetype)initWithButtons:(NSArray <GSBottomButtonInfo *> *)buttons delegate:(id<GSMapBottomBarDelegate>)delegate;

- (void)initialize;

@end
