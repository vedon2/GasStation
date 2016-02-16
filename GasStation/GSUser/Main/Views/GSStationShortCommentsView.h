//
//  GSStationShortCommentsView.h
//  GasStation
//
//  Created by vedon on 2/13/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GSStationShortCommentsViewDelegate <NSObject>

- (void)didTapMoreCommentCell;

@end

@interface GSStationShortCommentsView : UIView
@property (nonatomic,weak) id<GSStationShortCommentsViewDelegate>delegate;

- (instancetype)initWithDelegate:(id<GSStationShortCommentsViewDelegate>)delegate;

- (void)configureWithData:(id)data;

- (CGFloat)heightForCommentsView;

@end
