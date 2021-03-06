//
//  GSNetworkStatusCode.h
//  GasStation
//
//  Created by vedon on 2/17/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#ifndef GSNetworkStatusCode_h
#define GSNetworkStatusCode_h

/*
 11000: 用户不存在
 12000 密码错误
 13000 验证码错误
 12100: 参数错误
 11400: 用户未登录
 
 20000:加油站不存在，此时data为null
 
 */

#define kRequestSuccess 200
#define kResigterVerifiCodeInvalid 11000
#define kResigterUseralreadyExist 12000
#define kResigterUnknownError 13000


#endif /* GSNetworkStatusCode_h */
