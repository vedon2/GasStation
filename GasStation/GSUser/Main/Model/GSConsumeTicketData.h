//
//  GSConsumeTicketData.h
//  GasStation
//
//  Created by vedon on 3/1/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GSConsumeTicketData : NSObject
//ticketNo	string	是	油卡No
//phone	string	是	油卡拥有者的电话号码
//stationId	string	是	消费的油站的id
//timestamp	int	是	时间戳，long型
//validation	string	是	校验密文

@property (nonatomic,strong) NSString *ticketNo;
@property (nonatomic,strong) NSString *phone;
@property (nonatomic,strong) NSString *stationId;
@property (nonatomic,strong) NSNumber *timestamp;
@property (nonatomic,strong) NSString *validation;



@end
