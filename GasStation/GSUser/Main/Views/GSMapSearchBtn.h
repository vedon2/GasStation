//
//  GSMapSearchBtn.h
//  GasStation
//
//  Created by vedon on 2/12/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GSMapSearchBtnDelegate <NSObject>

- (void)didTapSearchBtn;

@end
@interface GSMapSearchBtn : UIView
@property (nonatomic,weak) id<GSMapSearchBtnDelegate>delegate;

- (instancetype)initWithDelegate:(id<GSMapSearchBtnDelegate>)delegate;

@end
