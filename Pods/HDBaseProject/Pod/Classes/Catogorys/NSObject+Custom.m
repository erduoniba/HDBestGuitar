//
//  NSObject+Custom.m
//  Pod
//
//  Created by Harry on 15/3/5.
//  Copyright (c) 2015年 Harry. All rights reserved.
//

#import "NSObject+Custom.h"

@implementation NSObject (Custom)

+ (void)doSomethingInBackGround:(void(^)(void))backgoundTask completion:(void(^)(void))foregroundTask
{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        if(backgoundTask)
        {
            backgoundTask();
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if(foregroundTask)
            {
                foregroundTask();
            }
        });
    });
}

- (NSString *)className {
    return NSStringFromClass(self.class);
}

- (void)performBlock:(void(^)())block afterDelay:(NSTimeInterval)delay {
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), block);
}


- (id)safePerform:(SEL)selector {
    return [self safePerform:selector withObject:nil];
}

- (id)safePerform:(SEL)selector withObject:(id)object {
    if ([self respondsToSelector:selector]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        return [self performSelector:selector withObject:object];
#pragma clang diagnostic pop
    } else {
        return nil;
    }
}


- (id)performSelector:(SEL)aSelector withObjects:(id)object, ...
{
    NSMethodSignature *signature = [self methodSignatureForSelector:aSelector];
    if(signature)
    {
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
        [invocation setTarget:self];
        [invocation setSelector:aSelector];
        
        va_list args;
        va_start(args, object);
        
        [invocation setArgument:&object atIndex:2];
        
        id arg = nil;
        int index = 3;
        while((arg = va_arg(args, id)))
        {
            [invocation setArgument:&arg atIndex:index];
            index++;
        }
        
        va_end(args);
        
        [invocation invoke];
        if(signature.methodReturnLength)
        {
            id anObject;
            [invocation getReturnValue:&anObject];
            return anObject;
        }
        else
        {
            return nil;
        }
    }
    else
    {
        return nil;
    }
}

@end
