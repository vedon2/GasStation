/*
 *****************************************************************************
 * Copyright (C) 2005-2014 UC Mobile Limited. All Rights Reserved
 * File			: ObserverContainer.h
 *
 * Description	: ObserverContainer  封装观察者（或类似）的容器，在添加和删除等操作时实现数据保护
 * Author		: lijin@ucweb.com
 *
 * History		: Creation, 14-8-23, lijin@ucweb.com, Create the file
 ******************************************************************************
 **/

#import <Foundation/Foundation.h>

@interface ObserverContainer<ObjectType>  : NSObject

- (BOOL)addObserver:(ObjectType)observer;
- (BOOL)removeObserver:(ObjectType)observer;
- (int)observerCount;

- (void)enumerateObjectsUsingBlock:(void (^)(ObjectType obj, NSUInteger idx, BOOL *stop))block;

@end
