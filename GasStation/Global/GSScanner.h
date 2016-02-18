//
//  GSScanner.h
//  GasStation
//
//  Created by vedon on 2/18/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GSScannetDelegate <NSObject>

- (void)didGetResult:(NSString *)result;

@end

@interface GSScanner : NSObject
@property (nonatomic,weak) id<GSScannetDelegate>delegate;
@property (nonatomic,strong,readonly) UIView *scannerView;

- (instancetype)initWithFrame:(CGRect)frame delegate:(id<GSScannetDelegate>)delegate;

- (void)start;

- (void)stop;

@end
