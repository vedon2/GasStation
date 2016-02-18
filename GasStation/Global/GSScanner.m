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

@interface GSScanner ()<AVCaptureMetadataOutputObjectsDelegate>
@property (nonatomic,strong) UIView *scannerView;
@property (nonatomic,strong) AVCaptureSession *captureSession;
@property (nonatomic,strong) AVCaptureVideoPreviewLayer *videoPreviewLayer;
@end

@implementation GSScanner

- (instancetype)initWithFrame:(CGRect)frame delegate:(id<GSScannetDelegate>)delegate
{
    self = [super init];
    if (self)
    {
        self.delegate = delegate;
        self.scannerView = [[UIView alloc] initWithFrame:frame];
        [self initialize];
    }
    return self;
}

- (void)initialize
{
    NSError * error;
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    // 初始化输入流
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
    if (!input) {
        NSLog(@"%@", [error localizedDescription]);
//        assert(0);
    }
    // 创建会话
    self.captureSession = [[AVCaptureSession alloc] init];
    // 添加输入流
    [self.captureSession addInput:input];
    // 初始化输出流
    AVCaptureMetadataOutput *captureMetadataOutput = [[AVCaptureMetadataOutput alloc] init];
    // 添加输出流
    [self.captureSession addOutput:captureMetadataOutput];
    
    // 创建dispatch queue.
    dispatch_queue_t dispatchQueue;
    dispatchQueue = dispatch_queue_create(kScanQRCodeQueueName, NULL);
    [captureMetadataOutput setMetadataObjectsDelegate:self queue:dispatchQueue];
    // 设置元数据类型 AVMetadataObjectTypeQRCode
    [captureMetadataOutput setMetadataObjectTypes:[NSArray arrayWithObject:AVMetadataObjectTypeQRCode]];
    
    // 创建输出对象
    self.videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_captureSession];
    [self.videoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    [self.videoPreviewLayer setFrame:self.scannerView.layer.bounds];
    [self.scannerView.layer addSublayer:_videoPreviewLayer];
    // 开始会话

}

#pragma mark - Public

- (void)start
{
    [self.captureSession startRunning];
}

- (void)stop
{
    [self.captureSession stopRunning];
}

#pragma mark - AVCaptureMetadataOutputObjectsDelegate

-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects
      fromConnection:(AVCaptureConnection *)connection
{
    if (metadataObjects != nil && [metadataObjects count] > 0) {
        AVMetadataMachineReadableCodeObject *metadataObj = [metadataObjects objectAtIndex:0];
        NSString *result;
        if ([[metadataObj type] isEqualToString:AVMetadataObjectTypeQRCode]) {
            result = metadataObj.stringValue;
        }
        else
        {
            NSLog(@"不是二维码");
        }
        
        if ([self.delegate respondsToSelector:@selector(didGetResult:)])
        {
            [self.delegate didGetResult:result];
        }
    }
}


#pragma mark - Getter & Setter


@end
