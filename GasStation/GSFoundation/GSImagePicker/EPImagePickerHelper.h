//
//  EPImagePickerHelper.h
//  EasiPass
//
//  Created by Joe on 15/1/27.
//  Copyright (c) 2015年 seewo. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, ImagePickerType) {
    StillImage,
    Camera
};

typedef void(^FinishPickingBlock)(UIImage *image, NSError *error);

typedef void(^CancelBlock)(void);

@interface EPImagePickerHelper : NSObject
+ (EPImagePickerHelper *)sharedInstance;

- (void)showImagePickerWithController:(UIViewController *)controller
                              andType:(ImagePickerType)type
                   finishPickingBlock:(FinishPickingBlock)finishBlock
                          cancelBlock:(CancelBlock)cancelBlock;

@end
