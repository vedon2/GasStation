//
//  GSUserRegisetResponseData.h
//  GasStation
//
//  Created by vedon on 2/17/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"
#import "GSAccountDefine.h"


@interface GSUserRegisetResponseData : NSObject
@property (nonatomic,strong,readonly) NSString *nickName;
@property (nonatomic,strong,readonly) NSString *usersId;
@property (nonatomic,strong,readonly) NSString *avatar;
@property (nonatomic,assign,readonly) UserGender gender;
@property (nonatomic,assign,readonly) UserType usersType;
@property (nonatomic,assign,readonly) NSInteger statusCode;
@end
