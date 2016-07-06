//
//  Rollout SDK version 1.0.0, Build 224
//
//  Copyright (c) 2014 Rollout.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RolloutOptions.h"

@interface Rollout : NSObject

+(void)setupWithKey:(NSString *)rolloutKey;
+(void)setupWithKey:(NSString *)rolloutKey developmentDevice: (BOOL)developmentDevice;
+(void)setupWithKey:(NSString *)rolloutKey options:(RolloutOptions *)options;
+(void)setupWithKey:(NSString *)rolloutKey developmentDevice:(BOOL)developmentDevice options:(RolloutOptions*)options;
+(BOOL)rolloutDisabled;
+(void)setRolloutDisabled:(BOOL)value;

+(void) setupWithDebug: (BOOL) debug options:(RolloutOptions*)options __attribute__ ((deprecated));
+(void) setupWithDebug: (BOOL) debug __attribute__ ((deprecated));

@end

