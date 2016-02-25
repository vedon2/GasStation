//
//  GSPersistanceConfig.m
//  GasStation
//
//  Created by vedon on 2/25/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import "GSPersistanceConfig.h"

@implementation GSPersistanceConfig

+ (NSString *)dataBaseName
{
    return @"GSDataBase";
}

+ (NSString *)userInfoTableName
{
    return @"GSUserInfoTable";
}

@end
