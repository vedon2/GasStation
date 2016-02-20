//
//  GSActionSheet.h
//  GasStation
//
//  Created by vedon on 2/20/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^GSActionSheetClickActionBlock)(NSInteger index);

@interface GSActionSheet : UIView

+(void)showActionWithTitles:(NSArray *)titles didClickAtIndex:(GSActionSheetClickActionBlock)block;

@end
