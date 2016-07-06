//
//  RolloutInvocationsListFactory.h
//  Rollout
//
//  Created by Sergey Ilyevsky on 9/17/14.
//  Copyright (c) 2014 DeDoCo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RolloutActionProducer;
@class RolloutErrors;
@class RolloutTypeWrapperFactory;
@class RolloutTypeWrapperGeneratorFactory;
@class RolloutDeviceProperties;
@class RolloutInvocationsList;
@class RolloutConditionValuesFactory;

@protocol RolloutInvocationsListFactory
- (RolloutInvocationsList *)invocationsListFromTweakConfiguration:(NSArray*)tweakConfiguration;
@end

@interface RolloutInvocationsListFactory : NSObject <RolloutInvocationsListFactory>

- (instancetype)initWithProducer:(RolloutActionProducer *)producer rolloutErrors:(RolloutErrors *)rolloutErrors typeWrapperFactory:(RolloutTypeWrapperFactory *)typeWrapperFactory typeWrapperGeneratorFactory:(RolloutTypeWrapperGeneratorFactory *)typeWrapperGeneratorFactory conditionValuesFactory:(RolloutConditionValuesFactory *)conditionValuesFactory;

@end

