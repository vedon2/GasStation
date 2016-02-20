//
//  GSBaseViewController.h
//  GasStation
//
//  Created by vedon on 2/18/16.
//  Copyright © 2016 vedon. All rights reserved.
//

//#define kUserDragableAnimation 1

#import <UIKit/UIKit.h>
#import "GSPrensentViewControllerTransition.h"
#import "GSPresentViewControllerTopBarProtocol.h"
#import "BlocksKit+UIKit.h"

@interface GSBaseViewController : UIViewController
@property (nonatomic,strong) id<UIViewControllerTransitioningDelegate> defaultPrensentAnimation;
@end
