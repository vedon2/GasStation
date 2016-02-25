//
//  GSUserInfoRecord.h
//  GasStation
//
//  Created by vedon on 2/25/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import <CTPersistance/CTPersistance.h>
#import "GSAccountDefine.h"

@interface GSUserInfoRecord : CTPersistanceRecord
@property (nonatomic,strong) NSString *identifier;
@property (nonatomic,strong) NSString *nickname;
@property (nonatomic,strong) NSString *userId;
@property (nonatomic,strong) NSString *avatar;
@property (nonatomic,assign) UserGender gender;
@property (nonatomic,assign) UserType userType;

@end
