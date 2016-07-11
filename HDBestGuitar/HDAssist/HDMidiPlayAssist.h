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
 *  播放midi音符，默认在0.4秒后停止播放该音符
 *
 *  @param note 音符，具体见项目README.md文件说明
 */
+ (void)playMidiNote:(NSUInteger)note;

/**
 *  获取 吉他 不同地方按键对应的音符值
 *
 *  @return 吉他 音符值的二维数组(6 x 25) 
 */
+ (NSArray *)getGuitarNotes;


@end
