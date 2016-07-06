//
// Created by Sergey Ilyevsky on 05/11/2015.
// Copyright (c) 2015 DeDoCo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RolloutTweakId;


@interface RolloutInvocationContext : NSObject

@property (readonly) id target;
@property (readonly) RolloutTweakId *tweakId;
@property (readonly) NSArray *arguments;

- (instancetype)initWithTarget:(id)target tweakId:(RolloutTweakId *)tweakId arguments:(NSArray *)arguments;

@end
