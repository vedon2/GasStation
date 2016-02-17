//
//  GSUserLoginResponseData.h
//  GasStation
//
//  Created by vedon on 2/17/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GSAccountDefine.h"
#import "MJExtension.h"

@interface GSUserLoginResponseData : NSObject

@property (nonatomic,strong) NSString *nickname;
@property (nonatomic,strong) NSString *usersId;
@property (nonatomic,strong) NSString *avatar;
@property (nonatomic,assign) UserGender gender;
@property (nonatomic,assign) UserType usersType;

@end
