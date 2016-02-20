//
//  GSBottomBarButton.h
//  GasStation
//
//  Created by vedon on 2/20/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GSBottomBarButton;
@protocol GSBottomBarButtonDelegate <NSObject>

- (void)buttonDidClick:(GSBottomBarButton *)button;

@end

@interface GSBottomBarButton : UIView
@property (nonatomic,weak) id<GSBottomBarButtonDelegate> delegate;

- (instancetype)initWithImage:(UIImage *)image title:(NSString *)title delegate:(id<GSBottomBarButtonDelegate>)delegate;

@end
