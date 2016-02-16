//
//  GSMapNavView.h
//  GasStation
//
//  Created by vedon on 2/12/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GSMapNavView;
@protocol GSMapNavViewDelegate <NSObject>

- (void)navViewDidTapZoomInBtn:(GSMapNavView *)view;

- (void)navViewDidTapZoomOutBtn:(GSMapNavView *)view;

- (void)navViewDidTapNavBtn:(GSMapNavView *)view;

@end

@interface GSMapNavView : UIView
@property (nonatomic,weak) id<GSMapNavViewDelegate>delegate;

- (instancetype)initWithDelegate:(id<GSMapNavViewDelegate>)delegate;

+ (CGFloat)buttinSize;

@end
