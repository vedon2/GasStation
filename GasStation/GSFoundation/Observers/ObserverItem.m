/*
 *****************************************************************************
 * Copyright (C) 2005-2014 UC Mobile Limited. All Rights Reserved
 * File			: ObserverItem.m
 *
 * Description	: ObserverItem
 *
 * Author		: yangyi@ucweb.com
 *
 * History		: Creation, 15/12/25, yangyi@ucweb.com, Create the file
 ******************************************************************************
 **/

#import "ObserverItem.h"

@implementation ObserverItem

+ (ObserverItem *)observerItemWith:(id)observer
{
    ObserverItem *item = [[ObserverItem alloc] init];
    item.observer = observer;
    return item;
}

- (NSString *)description
{
    NSString *itemInfo = [NSString stringWithFormat:@"ObserverClass:%@", self.observer];
    return itemInfo;
}

@end
