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
 *  获取 吉他 不同地方按键对应的音符值
 *
 *  @return 吉他 音符值的二维数组(6 x 25)
 */
+ (NSArray *)getGuitarNotes;

/**
 *  直接播放midi音符，默认在0.5秒后停止播放该音符
 *
 *  @param note 音符，具体见项目README.md文件说明
 */
+ (void)playMidiNote:(NSUInteger)note;


/**
 *  使用吉他的弦位和品位来播放midi音符，默认在0.5秒后停止播放该音符
 *
 *  @param cord  弦位
 *  @param grade 品位
 */
+ (void)playGuitarAtCord:(NSInteger)cord grade:(NSInteger)grade;

/**
 *  使用吉他的一组弦位和品位(时间间隔默认是0.3秒)来播放midi音符，默认在0.5秒后停止播放该音符
 *
 *  @param cords  一组弦位
 *  @param grades 一组品位（个数要和弦位一样）
 */
+ (void)playGuitarAtCords:(NSArray *)cords grades:(NSArray *)grades;

/**
 *  使用吉他的一组弦位和品位 及一组时间间隔 来播放midi音符
 *
 *  @param cords     一组弦位
 *  @param grades    一组品位（个数要和弦位一样）
 *  @param intervals 一组时间间隔（个数要和弦位一样）
 */
+ (void)playGuitarAtCords:(NSArray *)cords grades:(NSArray *)grades intervals:(NSArray *)intervals;

@end
