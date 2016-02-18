//
//  GSQRGenerator.h
//  GasStation
//
//  Created by vedon on 2/19/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GSQRGenerator : NSObject

+ (UIImage *)generateQRCode:(NSString *)code width:(CGFloat)width height:(CGFloat)height;

@end
