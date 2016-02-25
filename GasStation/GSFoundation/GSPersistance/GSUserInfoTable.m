//
//  GSUserInfoTable.m
//  GasStation
//
//  Created by vedon on 2/25/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import "GSUserInfoTable.h"
#import "GSPersistanceConfig.h"
#import "GSUserInfoRecord.h"

@implementation GSUserInfoTable

#pragma mark - CTPersistanceTableProtocol
- (NSString *)databaseName
{
    return [GSPersistanceConfig dataBaseName];
}

- (NSString *)tableName
{
    return [GSPersistanceConfig userInfoTableName];
}

- (NSDictionary *)columnInfo
{
    return @{
             @"identifier":@"INTEGER PRIMARY KEY AUTOINCREMENT",
             @"userId":@"TEXT",
             @"nickname":@"TEXT",
             @"avatar":@"TEXT",
             @"gender":@"INTEGER",
             @"usersType":@"INTEGER",
             };
}

- (Class)recordClass
{
    return [GSUserInfoRecord class];
}

- (NSString *)primaryKeyName
{
    return @"identifier";
}

@end
