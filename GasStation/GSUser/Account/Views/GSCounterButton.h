//
//  GSCounterButton.h
//  GasStation
//
//  Created by vedon on 2/20/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GSCounterButton;
@protocol GSCountetButtonDelegate <NSObject>

@optional
- (void)didTapCounterButton:(GSCounterButton *)button;

- (void)counterDidFinishCounting:(GSCounterButton *)button;

@end

@interface GSCounterButton : UIView
@property (nonatomic,weak) id<GSCountetButtonDelegate>delegate;

- (instancetype)initWithImage:(UIImage *)image counterText:(NSString *)text delegate:(id<GSCountetButtonDelegate>)delegate;

- (void)initialize;

- (void)stopCounter;
@end
