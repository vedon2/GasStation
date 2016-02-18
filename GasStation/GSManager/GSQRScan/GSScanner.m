//
//  GSScanner.m
//  GasStation
//
//  Created by vedon on 2/18/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import "GSScanner.h"
#import <AVFoundation/AVFoundation.h>

static const char *kScanQRCodeQueueName = "ScanQRCodeQueue";

@interface GSScanner ()
@property (strong, nonatomic)  UIView *sanFrameView;
@property (nonatomic,strong) AVCaptureSession *captureSession;
@property (nonatomic,strong) AVCaptureVideoPreviewLayer *videoPreviewLayer;
@end

@implementation GSScanner

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
    }
    return self;
}

@end
