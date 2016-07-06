//
//  NSObject+Custom.h
//  Pod
//
//  Created by Harry on 15/2/1.
//  Copyright (c) 2015年 Harry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Custom)

+ (void)doSomethingInBackGround:(void(^)(void))backgoundTask completion:(void(^)(void))foregroundTask;

- (NSString *)className;

/**
 *  异步的在指定时间之后,执行一个方法
 *
 *  @param block 要执行的方法
 *  @param delay 延迟的时间
 */
- (void)performBlock:(void(^)())block afterDelay:(NSTimeInterval)delay;

/**
 *  Perform selector with unlimited objects
 *
 *  @param aSelector The selector
 *  @param object    The objects
 *
 *  @return An object that is the result of the message
 */
- (id)performSelector:(SEL)aSelector
          withObjects:(id)object, ... NS_REQUIRES_NIL_TERMINATION;


/**
 *  安全的执行某个SEL,内部会判断对象是否响应这个SEL
 *
 *  @param selector 要执行的SEL
 *
 *  @return
 */
- (id)safePerform:(SEL)selector;

/**
 *  安全的执行某个SEL,内部会判断对象是否响应这个SEL
 *
 *  @param selector 要执行的SEL
 *  @param object   SEL的参数
 *
 *  @return
 */
- (id)safePerform:(SEL)selector withObject:(id)object;

@end
