//
//  GSCardsSelectView.h
//  GasStation
//
//  Created by vedon on 2/22/16.
//  Copyright © 2016 vedon. All rights reserved.
//



#import <UIKit/UIKit.h>

@class GSCardsSelectView;
@protocol GSCardsSelectViewProtocol <NSObject>

- (void)cardView:(GSCardsSelectView *)cardsView didSelectIndex:(NSUInteger)index;

@end

@interface GSCardsSelectView : UIView
@property (nonatomic,weak) id<GSCardsSelectViewProtocol>delegate;

- (instancetype)initWithDelegate:(id<GSCardsSelectViewProtocol>)delegate numberOfButtons:(NSArray *)itemsInfo selectedIndex:(NSUInteger)index;

- (void)initialize;

@end
