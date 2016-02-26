//
//  GSKeyBoardManger.m
//  GasStation
//
//  Created by vedon on 2/21/16.
//  Copyright © 2016 vedon. All rights reserved.
//

#import "GSKeyBoardManger.h"
#import "YYKeyboardManager.h"
#import "ObserverContainer.h"

@interface GSKeyBoardManger ()<YYKeyboardObserver>
@property (nonatomic,strong) ObserverContainer *observer;
@property (nonatomic,strong) UIView *attachView;
@property (nonatomic,strong) UITapGestureRecognizer *tapGesture;
@end

@implementation GSKeyBoardManger

+ (instancetype)shareManager
{
    static GSKeyBoardManger *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[GSKeyBoardManger alloc] init];
    });
    
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [[YYKeyboardManager defaultManager] addObserver:self];
        self.observer = [[ObserverContainer alloc] init];
    }
    return self;
}

- (void)addObserver:(id<GSKeyBoardMangerObserver>)observer toView:(UIView *)view
{
    if (observer)
    {
        [self.observer addObserver:observer];
        if (view)
        {
            self.attachView = view;
            self.tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
            [view addGestureRecognizer:self.tapGesture];
        }
    }
}

- (void)removeObserver:(id<GSKeyBoardMangerObserver>)observer
{
    if (observer)
    {
        [self.observer removeObserver:observer];
        [self.attachView removeGestureRecognizer:self.tapGesture];
    }
}


- (void)tap
{
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}

#pragma mark - YYKeyboardObserver

- (void)keyboardChangedWithTransition:(YYKeyboardTransition)transition
{
    
    if (self.observer.observerCount)
    {
        if ([[YYKeyboardManager defaultManager] isKeyboardVisible])
        {
            [self.observer enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                if ([obj respondsToSelector:@selector(keyBoardDidShow:)])
                {
                    [obj keyBoardDidShow:transition.toFrame];
                }
            }];
        }
        else
        {
            [self.observer enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                if ([obj respondsToSelector:@selector(keyBoardDidHidden:)])
                {
                    [obj keyBoardDidHidden:transition.toFrame];
                }
            }];
        }
    }
}

@end
