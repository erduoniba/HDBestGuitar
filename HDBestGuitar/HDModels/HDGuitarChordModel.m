//
//  HDGuitarChordModel.m
//  HDBestGuitar
//
//  Created by Harry on 16/7/15.
//  Copyright © 2016年 HarryDeng. All rights reserved.
//

#import "HDGuitarChordModel.h"

#import <HDBaseProject/HDCustomCache.h>

#define HDGUITAR_CUSTOMCHORDS   @"hdguitar_customchords"

@implementation HDGuitarChordModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    NSMutableDictionary *mapping = [[NSDictionary mtl_identityPropertyMapWithModel:self] mutableCopy];
    return mapping;
}


/**
 * 获取一组默认的和弦 G、C、Em、Am、F
 *
 *  @return 默认的和弦
 */
+ (NSArray <HDGuitarChordModel *>*)defaultChords{
    NSMutableArray *chords = [NSMutableArray arrayWithCapacity:5];
    HDGuitarChordModel *model = [[HDGuitarChordModel alloc] init];
    model.chordName = @"G";
    model.chordGrades = @[@3, @0, @0, @0, @2, @3];
    [chords addObject:model];
    
    model = [[HDGuitarChordModel alloc] init];
    model.chordName = @"C";
    model.chordGrades = @[@0, @1, @0, @2, @3, @3];
    [chords addObject:model];
    
    model = [[HDGuitarChordModel alloc] init];
    model.chordName = @"Em";
    model.chordGrades = @[@0, @0, @0, @2, @2, @0];
    [chords addObject:model];
    
    model = [[HDGuitarChordModel alloc] init];
    model.chordName = @"Am";
    model.chordGrades = @[@0, @1, @2, @2, @0, @0];
    [chords addObject:model];
    
    model = [[HDGuitarChordModel alloc] init];
    model.chordName = @"F";
    model.chordGrades = @[@1, @1, @2, @3, @3, @1];
    [chords addObject:model];
    
    return chords;
}

/**
 * 获取一组用户自定义的和弦
 *
 *  @return 用户自定义的和弦
 */
+ (NSArray <HDGuitarChordModel *>*)customChords{
    return [HDCustomCache getArrayCache:HDGUITAR_CUSTOMCHORDS];
}

/**
 *  保存用户自定义的和弦
 *
 *  @param customChords 用户自定义的和弦
 */
+ (void)saveCustomChords:(NSArray <HDGuitarChordModel *>*)customChords{
    [HDCustomCache saveCache:HDGUITAR_CUSTOMCHORDS byArray:customChords];
}

@end
