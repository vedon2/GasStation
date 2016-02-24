//
//  EPImagePickerHelper.m
//  EasiPass
//
//  Created by Joe on 15/1/27.
//  Copyright (c) 2015年 seewo. All rights reserved.
//

#import "EPImagePickerHelper.h"
#import <MobileCoreServices/MobileCoreServices.h>

@interface EPImagePickerHelper () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (strong, nonatomic) UIImagePickerController *imagePickerController;
@property (strong, nonatomic) FinishPickingBlock finishBlock;
@property (strong, nonatomic) CancelBlock cancelBlock;
@end

@implementation EPImagePickerHelper

- (instancetype)init
{
    self = [super init];
    if (self) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.allowsEditing = YES;
        picker.mediaTypes = @[(NSString *)kUTTypeImage];
        picker.delegate = self;
        self.imagePickerController = picker;
        
    }
    return self;
}


+ (EPImagePickerHelper *)sharedInstance
{
    static EPImagePickerHelper *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[EPImagePickerHelper alloc] init];
    });
    return instance;
}

- (void)showImagePickerWithController:(UIViewController *)controller
                              andType:(ImagePickerType)type
                   finishPickingBlock:(FinishPickingBlock)finishBlock
                          cancelBlock:(CancelBlock)cancelBlock
{
    
    
    switch (type) {
        case StillImage:
            if (([UIImagePickerController isSourceTypeAvailable:
                  (UIImagePickerControllerSourceTypePhotoLibrary)] == NO)) {
                if (finishBlock) {
                    NSError *err = [NSError errorWithDomain:@"EPImagePickerHelper" code:0 userInfo:nil];
                    finishBlock(nil, err);
                }
                return;
            }
            self.imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            break;
        case Camera:
            if (([UIImagePickerController isSourceTypeAvailable:
                  (UIImagePickerControllerSourceTypeCamera)] == NO)) {
                if (finishBlock) {
                    NSError *err = [NSError errorWithDomain:@"EPImagePickerHelper" code:1 userInfo:nil];
                    finishBlock(nil, err);
                }
                return;
            }
            self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            break;
        default:
            break;
    }
    [controller presentViewController:self.imagePickerController animated:YES completion:nil];
    self.finishBlock = finishBlock;
    self.cancelBlock = cancelBlock;
}


#pragma mark - image picker controller delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
    UIImage *imageToSave = nil;
    if (CFStringCompare ((CFStringRef) mediaType, kUTTypeImage, 0)
        == kCFCompareEqualTo) {
        
        UIImage *editedImage = (UIImage *) [info objectForKey:
                                            UIImagePickerControllerEditedImage];
        UIImage *originalImage = (UIImage *) [info objectForKey:
                                              UIImagePickerControllerOriginalImage];
        
        if (editedImage) {
            imageToSave = editedImage;
        } else {
            imageToSave = originalImage;
        }
        
    }
    [picker.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    
    if (self.finishBlock) {
        self.finishBlock(imageToSave, nil);
    }
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    if (self.cancelBlock) {
        self.cancelBlock();
    }
}



@end
