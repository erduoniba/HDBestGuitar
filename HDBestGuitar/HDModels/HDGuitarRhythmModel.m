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
    
    HDGuitarRhythmModel *model = [[HDGuitarRhythmModel alloc] init];
    model.rhythmName = @"63231323 53231323";
    model.rhythmCords = @[@6, @3, @2, @3, @1, @3, @2, @3, @5, @3, @2, @3, @1, @3, @2, @3];
    model.rhythmIntervals = @[@0.3, @0.3, @0.3, @0.3, @0.3, @0.3, @0.3, @0.3, @0.3, @0.3, @0.3, @0.3, @0.3, @0.3, @0.3, @0.3];
    [rhythms addObject:model];
    
    model = [[HDGuitarRhythmModel alloc] init];
    model.rhythmName = @"63212321 53212321";
    model.rhythmCords = @[@6, @3, @2, @1, @2, @3, @2, @1, @5, @3, @2, @1, @2, @3, @2, @1];
    model.rhythmIntervals = @[@0.3, @0.3, @0.3, @0.3, @0.3, @0.3, @0.3, @0.3, @0.3, @0.3, @0.3, @0.3, @0.3, @0.3, @0.3, @0.3];
    [rhythms addObject:model];
    
    model = [[HDGuitarRhythmModel alloc] init];
    model.rhythmName = @"654321 123456";
    model.rhythmCords = @[@6, @5, @4, @3, @2, @1, @1, @2, @3, @4, @5, @6];
    model.rhythmIntervals = @[@0.01, @0.01, @0.01, @0.01, @0.01, @0.3, @0.01, @0.01, @0.01, @0.01, @0.01, @0.3];
    [rhythms addObject:model];
    
    return rhythms;
}

/**
 * 获取一组用户自定义的节奏
 *
 *  @return 用户自定义的节奏
 */
+ (NSArray <HDGuitarRhythmModel *>*)customRhythms{
    return [HDCustomCache getArrayCache:HDGUITAR_CUSTOMRHYTHMS];
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
