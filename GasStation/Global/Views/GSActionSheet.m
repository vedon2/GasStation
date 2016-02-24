//
//  GSActionSheet.m
//  GasStation
//
//  Created by vedon on 2/20/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import "GSActionSheet.h"
#import "JGActionSheet.h"

@implementation GSActionSheet

+(void)showActionWithTitles:(NSArray *)titles didClickAtIndex:(GSActionSheetClickActionBlock)block
{
    JGActionSheetSection *actionSection = [JGActionSheetSection sectionWithTitle:nil message:nil buttonTitles:titles buttonStyle:JGActionSheetButtonStyleGreen];
    NSArray *sections = @[actionSection];
    JGActionSheet *sheet = [JGActionSheet actionSheetWithSections:sections];
    [sheet setOutsidePressBlock:^(JGActionSheet * sheet) {
        [sheet dismissAnimated:YES];
    }];
    [sheet setButtonPressedBlock:^(JGActionSheet *sheet, NSIndexPath *indexPath) {
        [sheet dismissAnimated:YES];
        if (indexPath.section == 1) {
            return ;
        }
        block(indexPath.row);
    }];

    [sheet showInView:[UIApplication sharedApplication].keyWindow animated:YES];
}
@end
