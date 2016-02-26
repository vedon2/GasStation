//
//  GSKeyBoardManger.h
//  GasStation
//
//  Created by vedon on 2/21/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GSKeyBoardMangerObserver <NSObject>

- (void)keyBoardDidShow:(CGRect)keyboardViewFrame;

- (void)keyBoardDidHidden:(CGRect)keyboardViewFrame;

@end

@interface GSKeyBoardManger : NSObject

+ (instancetype)shareManager;

- (void)addObserver:(id<GSKeyBoardMangerObserver>)observer toView:(UIView *)view;

- (void)removeObserver:(id<GSKeyBoardMangerObserver>)observer;


@end
