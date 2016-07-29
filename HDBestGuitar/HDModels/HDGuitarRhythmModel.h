//
//  HDGuitarRhythmModel.h
//  HDBestGuitar
//
//  Created by 邓立兵 on 16/7/15.
//  Copyright © 2016年 HarryDeng. All rights reserved.
//

#import <Mantle/Mantle.h>

/**
 *  节奏实体类 如 53231323
 */
@interface HDGuitarRhythmModel : MTLModel

/**
 *  节奏的名称
 */
@property (nonatomic, strong) NSString *rhythmName;

/**
 *  节奏对应的 弦位
 */
@property (nonatomic, strong) NSArray *rhythmCords;

/**
 *  节奏中弦位之间的 时间间隔
 */
@property (nonatomic, strong) NSArray *rhythmIntervals;


/**
 *  获取一组默认的节奏
 *
 *  @return 默认的节奏
 */
+ (NSArray <HDGuitarRhythmModel *>*)defaultRhythms;


/**
 *  获取App默认所有的节奏
 *
 *  @return App默认所有的节奏
 */
+ (NSArray <HDGuitarRhythmModel *>*)totalRhythms;


/**
 * 获取一组用户自定义的节奏
 *
 *  @return 用户自定义的节奏
 */
+ (NSArray <HDGuitarRhythmModel *>*)customRhythms;

/**
 *  保存用户自定义的节奏
 *
 *  @param customChords 用户自定义的节奏
 */
+ (void)saveCustomRhythms:(NSArray <HDGuitarRhythmModel *>*)customRhythms;

@end
