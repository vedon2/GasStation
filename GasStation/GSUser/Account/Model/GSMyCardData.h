//
//  GSMyCardData.h
//  GasStation
//
//  Created by vedon on 3/3/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GSMyCardDataProtocol.h"

@interface GSMyCardData : NSObject<GSMyCardDataProtocol>
@property (assign,nonatomic) BOOL isUse;
@end
