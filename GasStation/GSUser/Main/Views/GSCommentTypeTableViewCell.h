//
//  GSCommentTypeTableViewCell.h
//  GasStation
//
//  Created by vedon on 2/13/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GSSearchResultCellProtocol.h"

typedef NS_ENUM(NSUInteger,GSCommentType)
{
    GSCommentType_All,
    GSCommentType_High,
    GSCommentType_Middle,
    GSCommentType_Bad,
    GSCommentType_Unknown,
};

@protocol GSCommentTypeTableViewCellDeleagte <NSObject>

- (void)didTapCommentType:(GSCommentType)type;

@end

@interface GSCommentTypeTableViewCell : UITableViewCell<GSSearchResultCellProtocol>
@property (nonatomic,weak) id<GSCommentTypeTableViewCellDeleagte>delegate;

@end
