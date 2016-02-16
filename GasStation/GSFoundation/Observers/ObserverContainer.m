/*
 *****************************************************************************
 * Copyright (C) 2005-2014 UC Mobile Limited. All Rights Reserved
 * File			: ObserverContainer.m
 *
 * Description	: ObserverContainer  封装观察者（或类似）的容器，在添加和删除等操作时实现数据保护
 * Author		: lijin@ucweb.com
 *
 * History		: Creation, 14-8-23, lijin@ucweb.com, Create the file
 ******************************************************************************
 **/

#import "ObserverContainer.h"
#import "ObserverItem.h"

@interface ObserverContainer()
{
    int m_iterative;                    //标记迭代状态，设为int目的是解决循环迭代的问题
}

@property (nonatomic, readonly) NSMutableArray *observers;
@property (nonatomic, retain) NSMutableArray *increaseList;//需要添加到normallist中去的对象
@end

@implementation ObserverContainer
@synthesize observers = _normalList;
- (id)init
{
    self = [super init];
    if (self)
    {
        m_iterative = 0;
        _normalList = [[NSMutableArray alloc] init];
        _increaseList = [[NSMutableArray alloc] init];
    }
    return self;
}


- (BOOL)addObserver:(id)observer
{
    if ([self isObserverExist:observer])
    {
        return NO;
    }
    
    if (m_iterative > 0)
    {
        [self addObserver:observer toArray:self.increaseList];
    }
    else
    {
        [self addObserver:observer toArray:self.observers];
    }
    
    return YES;
}

- (BOOL)removeObserver:(id)observer
{
    BOOL result = NO;
    if (m_iterative > 0)
    {
        result = [self makeObserverInvalid:observer];
        if (!result)
        {
            result = [self removeObserver:observer fromArray:self.increaseList];
        }
    }
    else
    {
        result = [self removeObserver:observer fromArray:self.observers];
    }
    return result;
}

- (BOOL)makeObserverInvalid:(id)observer
{
    BOOL succeed = NO;
    for (ObserverItem *item in self.observers)
    {
        if (observer == item.observer)
        {
            item.observer = nil;
            succeed = YES;
            break;
        }
    }
    return succeed;
}

- (BOOL)isObserverExist:(id)observer
{
    int count = 0;
    if ([self isObserver:observer inArray:self.increaseList])
    {
        count ++;
    }
    else if ([self isObserver:observer inArray:self.observers])
    {
        count ++;
    }
    
    return count > 0 ? YES : NO;
}

#pragma mark assist functions
- (void)addObserver:(id)observer toArray:(NSMutableArray *)array
{
    ObserverItem *item = [ObserverItem observerItemWith:observer];
    [array addObject:item];
}

- (BOOL)removeObserver:(id)observer fromArray:(NSMutableArray *)array
{
    NSMutableArray *needDelArray = [[NSMutableArray alloc] init];
    BOOL result = NO;
    
    for (ObserverItem *item in array)
    {
        if (observer == item.observer)
        {
            [needDelArray addObject:item];
            result = YES;
        }
        
        if (nil == item.observer)
        {
            [needDelArray addObject:item];
        }
    }

    [array removeObjectsInArray:needDelArray];
    needDelArray = nil;
    
    return result;
}

//恢复观察者列表
- (void)recoverNormalList
{
    //将空observer删除
    for (NSInteger i = self.observers.count - 1; i >=0; i--)
    {
        ObserverItem *item = [self.observers objectAtIndex:i];
        if (!item.observer)
        {
            [self.observers removeObjectAtIndex:i];
        }
    }
    
    //将increaseList中的对象加入observers
    [self.observers addObjectsFromArray:self.increaseList];
    [self.increaseList removeAllObjects];
}

- (BOOL)isObserver:(id)observer inArray:(NSArray *)array
{
    BOOL exist = NO;
    for (ObserverItem *item in array)
    {
        if (item.observer == observer)
        {
            exist = YES;
            break;
        }
    }
    return exist;
}

- (id)observerAtIndex:(int)index
{
    ObserverItem *item = nil;
    if (index < self.observers.count)
    {
        item = (ObserverItem *)[self.observers objectAtIndex:index];
    }
    return item.observer;
}

- (int)observerCount
{
    return (int)[self.observers count];
}


- (void)enumerateObjectsUsingBlock:(void (^)(id , NSUInteger , BOOL *))block
{
    ++m_iterative;
    
    [self.observers enumerateObjectsUsingBlock:^(ObserverItem* obj, NSUInteger idx, BOOL *stop) {
        
        block(obj.observer,idx,stop);
        
    }];
    
    if (0 == --m_iterative)
    {
        [self recoverNormalList];
    }
}


@end
