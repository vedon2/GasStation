/*
 *****************************************************************************
 * Copyright (C) 2005-2014 UC Mobile Limited. All Rights Reserved
 * File			: ObserverItem.h
 *
 * Description	: ObserverItem
 *
 * Author		: yangyi@ucweb.com
 *
 * History		: Creation, 15/12/25, yangyi@ucweb.com, Create the file
 ******************************************************************************
 **/

#import <Foundation/Foundation.h>

@interface ObserverItem : NSObject
@property (nonatomic, weak) id observer;

+ (ObserverItem *)observerItemWith:(id)observer;
@end
