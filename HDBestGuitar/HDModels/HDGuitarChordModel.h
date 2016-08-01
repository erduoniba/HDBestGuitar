//
//  HDGuitarChordModel.h
//  HDBestGuitar
//
//  Created by Harry on 16/7/15.
//  Copyright © 2016年 HarryDeng. All rights reserved.
//

#import <Mantle/Mantle.h>

/**
 *  和弦实体类 如G、C、Am
 */
@interface HDGuitarChordModel : MTLModel <MTLJSONSerializing>

/**
 *  和弦的名称
 */
@property (nonatomic, strong) NSString  *chordName;

/**
 *  和弦对应的 品位
 */
@property (nonatomic, strong) NSArray   *chordGrades;



/**
 * 获取一组默认的和弦 G、C、Em、Am、F
 *
 *  @return 默认的和弦
 */
+ (NSArray <HDGuitarChordModel *>*)defaultChords;

/**
 * 获取系统默认所有的和弦
 *
 *  @return 系统默认所有的和弦
 */
+ (NSArray <HDGuitarChordModel *>*)totalChords;

/**
 * 获取一组用户自定义的和弦 (没有设置则返回默认)
 *
 *  @return 用户自定义的和弦
 */
+ (NSArray <HDGuitarChordModel *>*)customChords;

/**
 *  保存用户自定义的和弦
 *
 *  @param customChords 用户自定义的和弦
 */
+ (void)saveCustomChords:(NSArray <HDGuitarChordModel *>*)customChords;

@end
