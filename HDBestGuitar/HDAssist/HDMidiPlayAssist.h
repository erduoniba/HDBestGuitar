//
//  HDMidiPlayAssist.h
//  HDBestGuitar
//
//  Created by 邓立兵 on 16/7/11.
//  Copyright © 2016年 HarryDeng. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 *  吉他的midi播放类
 */
@interface HDMidiPlayAssist : NSObject

/**
 *  需要使用单例类来管理 midi 播放，因为需要播放，也需要停止播放
 *
 *  @return 实例对象
 */
+ (instancetype)shareInstance;


/**
 *  直接播放midi音符，默认在0.5秒后停止播放该音符
 *
 *  @param note 音符，具体见项目README.md文件说明
 */
- (void)playMidiNote:(NSUInteger)note;


/**
 *  直接播放midi音符组，默认在0.5秒后停止播放该音符 （同时播放）
 *
 *  @param notes 音符组，具体见项目README.md文件说明
 */
- (void)playMidiNotes:(NSArray <NSNumber *> *)notes;


/**
 *  使用吉他的弦位和品位来播放midi音符，默认在0.5秒后停止播放该音符
 *
 *  @param cord  弦位
 *  @param grade 品位
 */
- (void)playGuitarAtCord:(NSInteger)cord grade:(NSInteger)grade;

/**
 *  使用吉他的一组弦位和品位(时间间隔默认是0.3秒)来播放midi音符，默认在0.5秒后停止播放该音符
 *
 *  @param cords  一组弦位
 *  @param grades 一组品位（个数要和弦位一样）
 */
- (void)playGuitarAtCords:(NSArray *)cords grades:(NSArray *)grades;

/**
 *  使用吉他的一组弦位和品位 及一组时间间隔 来播放midi音符
 *
 *  @param cords     一组弦位
 *  @param grades    一组品位（个数要和弦位一样）
 *  @param intervals 一组时间间隔（个数要和弦位一样）
 */
- (void)playGuitarAtCords:(NSArray *)cords grades:(NSArray *)grades intervals:(NSArray *)intervals;

@end
