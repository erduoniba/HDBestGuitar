//
// Created by Sergey Ilyevsky on 1/11/15.
// Copyright (c) 2015 DeDoCo. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    RolloutMethodId_language_objC,
    RolloutMethodId_language_swift
} RolloutMethodId_language;

@protocol RolloutMethodId <NSObject, NSCopying>
- (RolloutMethodId_language)language;
- (NSDictionary *)methodIdDescriptionForErrorReporting;
@end

