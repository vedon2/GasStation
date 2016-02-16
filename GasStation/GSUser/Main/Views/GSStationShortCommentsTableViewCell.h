//
//  GSStationShortCommentsTableViewCell.h
//  GasStation
//
//  Created by vedon on 2/13/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GSSearchResultCellProtocol.h"

@protocol GSStationShortCommentsTableViewCellDelegate <NSObject>

- (void)didTapMoreCommentCell;

@end

@interface GSStationShortCommentsTableViewCell : UITableViewCell<GSSearchResultCellProtocol>
@property (nonatomic,weak) id<GSStationShortCommentsTableViewCellDelegate>delegate;

@end
