//
//  HDGuitarRhythmModel.m
//  HDBestGuitar
//
//  Created by 邓立兵 on 16/7/15.
//  Copyright © 2016年 HarryDeng. All rights reserved.
//

#import "HDGuitarRhythmModel.h"

#import <HDBaseProject/HDCustomCache.h>

#define HDGUITAR_CUSTOMRHYTHMS   @"hdguitar_customrhythms"

@implementation HDGuitarRhythmModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    NSMutableDictionary *mapping = [[NSDictionary mtl_identityPropertyMapWithModel:self] mutableCopy];
    return mapping;
}

/**
 *  获取一组默认的节奏
 *
 *  @return 默认的节奏
 */
+ (NSArray <HDGuitarRhythmModel *>*)defaultRhythms{
    NSMutableArray *rhythms = [NSMutableArray arrayWithCapacity:5];
    
    CGFloat defaultStrumInterval = 0.02;
    CGFloat defaultRhythmsInterval = 0.3;
    
    HDGuitarRhythmModel *model = [[HDGuitarRhythmModel alloc] init];
    model.rhythmName = @"63231323";
    model.rhythmCords = @[@6, @3, @2, @3, @1, @3, @2, @3];
    model.rhythmIntervals = @[@(defaultRhythmsInterval), @(defaultRhythmsInterval), @(defaultRhythmsInterval), @(defaultRhythmsInterval), @(defaultRhythmsInterval), @(defaultRhythmsInterval), @(defaultRhythmsInterval), @(defaultRhythmsInterval + 0.2)];
    [rhythms addObject:model];
    
    model = [[HDGuitarRhythmModel alloc] init];
    model.rhythmName = @"53231323";
    model.rhythmCords = @[@5, @3, @2, @3, @1, @3, @2, @3];
    model.rhythmIntervals = @[@(defaultRhythmsInterval), @(defaultRhythmsInterval), @(defaultRhythmsInterval), @(defaultRhythmsInterval), @(defaultRhythmsInterval), @(defaultRhythmsInterval), @(defaultRhythmsInterval), @(defaultRhythmsInterval + 0.2)];
    [rhythms addObject:model];
    
    
    model = [[HDGuitarRhythmModel alloc] init];
    model.rhythmName = @"654321   654321   654321   654321 123456   654321";
    model.rhythmCords = @[@6, @5, @4, @3, @2, @1,
                          @6, @5, @4, @3, @2, @1,
                          @6, @5, @4, @3, @2, @1,
                          @6, @5, @4, @3, @2, @1,  @1, @2, @3, @4, @5, @6,
                          @6, @5, @4, @3, @2, @1];
    model.rhythmIntervals = @[@(defaultStrumInterval), @(defaultStrumInterval), @(defaultStrumInterval), @(defaultStrumInterval), @(defaultStrumInterval),
                              @0.6,
                              @(defaultStrumInterval), @(defaultStrumInterval), @(defaultStrumInterval), @(defaultStrumInterval), @(defaultStrumInterval),
                              @0.6,
                              @(defaultStrumInterval), @(defaultStrumInterval), @(defaultStrumInterval), @(defaultStrumInterval), @(defaultStrumInterval),
                              @0.6,
                              @(defaultStrumInterval), @(defaultStrumInterval), @(defaultStrumInterval), @(defaultStrumInterval), @(defaultStrumInterval),
                              @0.15,
                              @(defaultStrumInterval), @(defaultStrumInterval), @(defaultStrumInterval), @(defaultStrumInterval), @(defaultStrumInterval),
                              @0.4,
                              @(defaultStrumInterval), @(defaultStrumInterval), @(defaultStrumInterval), @(defaultStrumInterval), @(defaultStrumInterval),
                              @0.6];
    [rhythms addObject:model];
    
    model = [[HDGuitarRhythmModel alloc] init];
    model.rhythmName = @"654321  654321 123456 654321 123456 654321 123456";
    model.rhythmCords = @[@6, @5, @4, @3, @2, @1,
                          @6, @5, @4, @3, @2, @1,
                          @1, @2, @3, @4, @5, @6,
                          @6, @5, @4, @3, @2, @1,
                          @1, @2, @3, @4, @5, @6,
                          @6, @5, @4, @3, @2, @1,
                          @1, @2, @3, @4, @5, @6];
    model.rhythmIntervals = @[@(defaultStrumInterval), @(defaultStrumInterval), @(defaultStrumInterval), @(defaultStrumInterval), @(defaultStrumInterval),
                              @0.4,
                              @(defaultStrumInterval), @(defaultStrumInterval), @(defaultStrumInterval), @(defaultStrumInterval), @(defaultStrumInterval),
                              @0.15,
                              @(defaultStrumInterval), @(defaultStrumInterval), @(defaultStrumInterval), @(defaultStrumInterval), @(defaultStrumInterval),
                              @0.15,
                              @(defaultStrumInterval), @(defaultStrumInterval), @(defaultStrumInterval), @(defaultStrumInterval), @(defaultStrumInterval),
                              @0.15,
                              @(defaultStrumInterval), @(defaultStrumInterval), @(defaultStrumInterval), @(defaultStrumInterval), @(defaultStrumInterval),
                              @0.25,
                              @(defaultStrumInterval), @(defaultStrumInterval), @(defaultStrumInterval), @(defaultStrumInterval), @(defaultStrumInterval),
                              @0.15,
                              @(defaultStrumInterval), @(defaultStrumInterval), @(defaultStrumInterval), @(defaultStrumInterval), @(defaultStrumInterval),
                              @0.25];
    [rhythms addObject:model];
    
    return rhythms;
}

/**
 *  获取App默认所有的节奏
 *
 *  @return App默认所有的节奏
 */
+ (NSArray <HDGuitarRhythmModel *>*)totalRhythms{
    return [self defaultRhythms];
}

/**
 * 获取一组用户自定义的节奏 (没有设置则返回默认)
 *
 *  @return 用户自定义的节奏
 */
+ (NSArray <HDGuitarRhythmModel *>*)customRhythms{
    if ([[[NSUserDefaults standardUserDefaults] dictionaryRepresentation].allKeys containsObject:HDGUITAR_CUSTOMRHYTHMS]) {
        NSArray *rhythms = [HDCustomCache getArrayCache:HDGUITAR_CUSTOMRHYTHMS];
        if (!rhythms || rhythms.count == 0) {
            return [self defaultRhythms];
        }
        return rhythms;
    }
    
    return [self defaultRhythms];
}

/**
 *  保存用户自定义的节奏
 *
 *  @param customChords 用户自定义的节奏
 */
+ (void)saveCustomRhythms:(NSArray <HDGuitarRhythmModel *>*)customRhythms{
    [HDCustomCache saveCache:HDGUITAR_CUSTOMRHYTHMS byArray:customRhythms];
}

@end
