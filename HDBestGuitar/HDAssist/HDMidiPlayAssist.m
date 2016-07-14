//
//  HDMidiPlayAssist.m
//  HDBestGuitar
//
//  Created by 邓立兵 on 16/7/11.
//  Copyright © 2016年 HarryDeng. All rights reserved.
//

#import "HDMidiPlayAssist.h"

#import <MIKMIDI/MIKMIDISynthesizer.h>
#import <MIKMIDI/MIKMIDINoteOnCommand.h>
#import <MIKMIDI/MIKMIDINoteOffCommand.h>

@implementation HDMidiPlayAssist

+ (MIKMIDISynthesizer *)midiSynthesizer{
    static MIKMIDISynthesizer *synthesizer;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        synthesizer = [[MIKMIDISynthesizer alloc] init];
        NSURL *soundfont = [[NSBundle mainBundle] URLForResource:@"GeneralUser GS MuseScore v1.442" withExtension:@"sf2"];
        NSError *error = nil;
        if (![synthesizer loadSoundfontFromFileAtURL:soundfont presetID:27 error:&error]) {
            NSLog(@"Error loading soundfont for synthesizer. Sound will be degraded. %@", error);
        }
    });
    return synthesizer;
}
/**
 *  获取 吉他 不同地方按键对应的音符值
 *
 *  @return 吉他 音符值的二维数组(6 x 25)
 */
+ (NSArray *)getGuitarNotes{
    static NSArray *notes;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        notes =@[
                 @[@64, @65, @66, @67, @68, @69, @70, @71, @72, @73, @74, @75, @76,
                   @77, @78,@79, @80, @81, @82, @83, @84, @85, @86, @87, @88],
                 
                 @[@59, @60, @61, @62, @63, @64, @65, @66, @67, @68, @69, @70, @71,
                   @72, @73, @74, @75, @76, @77, @78,@79, @80, @81, @82, @83],
                 
                 @[@55, @56, @57, @58, @59, @60, @61, @62, @63, @64, @65, @66, @67,
                   @68, @69, @70, @71, @72, @73, @74, @75, @76, @77, @78,@79],
                 
                 @[@50, @51, @52, @53, @54, @55, @56, @57, @58, @59, @60, @61, @62,
                   @63, @64, @65, @66, @67,@68, @69, @70, @71, @72, @73, @74],
                 
                 @[@45, @46, @47, @48, @49, @50, @51, @52, @53, @54, @55, @56, @57,
                   @58, @59, @60, @61, @62, @63, @64, @65, @66, @67,@68, @69],
                 
                 @[@40, @41, @42, @43, @44, @45, @46, @47, @48, @49, @50, @51, @52,
                   @53, @54, @55, @56, @57, @58, @59, @60, @61, @62, @63, @64]
                 ];
    });
    return notes;
}


/**
 *  直接播放midi音符，默认在0.5秒后停止播放该音符
 *
 *  @param note 音符，具体见项目README.md文件说明
 */
static CFAbsoluteTime fff;
+ (void)playMidiNote:(NSUInteger)note{
    if (fff == 0) {
        fff = CFAbsoluteTimeGetCurrent();
    }
    DLog(@"播放 %d 音符  时间间隔%0.2f秒", (int)note, CFAbsoluteTimeGetCurrent() - fff);
    fff = CFAbsoluteTimeGetCurrent();
    
    MIKMIDINoteOnCommand *noteOn = [MIKMIDINoteOnCommand noteOnCommandWithNote:note velocity:127 channel:0 timestamp:[NSDate date]];
    [self.midiSynthesizer handleMIDIMessages:@[noteOn]];
}

/**
 *  直接播放midi音符组，默认在0.5秒后停止播放该音符 （同时播放）
 *
 *  @param notes 音符组，具体见项目README.md文件说明
 */
+ (void)playMidiNotes:(NSArray <NSNumber *> *)notes{
    
    NSMutableArray *commands = [NSMutableArray array];
    NSMutableString *noteString = [NSMutableString string];
    [notes enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [noteString appendFormat:@"%d ", obj.intValue];
        MIKMIDINoteOnCommand *noteOn = [MIKMIDINoteOnCommand noteOnCommandWithNote:obj.unsignedIntegerValue velocity:127 channel:0 timestamp:[NSDate date]];
        [commands addObject:noteOn];
    }];
    
    DLog(@"同时播放 %@ 音符组", noteString);
    
    [self.midiSynthesizer handleMIDIMessages:commands];
}


/**
 *  使用吉他的弦位和品位来播放midi音符，默认在0.5秒后停止播放该音符
 *
 *  @param cord  弦位
 *  @param grade 品位
 */
+ (void)playGuitarAtCord:(NSInteger)cord grade:(NSInteger)grade{
    NSArray *notes = [self getGuitarNotes];
    NSUInteger note = [notes[cord][grade] unsignedIntegerValue];
    [self playMidiNote:note];
}


/**
 *  使用吉他的一组弦位和品位来播放midi音符，默认在0.5秒后停止播放该音符
 *
 *  @param cords  一组弦位
 *  @param grades 一组品位（个数要和弦位一样）
 */
+ (void)playGuitarAtCords:(NSArray *)cords grades:(NSArray *)grades{
    NSMutableArray *intervals = [NSMutableArray arrayWithCapacity:cords.count];
    for (int i=0; i<cords.count; i++) {
        [intervals addObject:@(0.3)];
    }
    [self playGuitarAtCords:cords grades:grades intervals:intervals];
}

/**
 *  使用吉他的一组弦位和品位 及一组时间间隔 来播放midi音符
 *
 *  @param cords     一组弦位
 *  @param grades    一组品位（个数要和弦位一样）
 *  @param intervals 一组时间间隔（个数要和弦位一样）
 */
+ (void)playGuitarAtCords:(NSArray *)cords grades:(NSArray *)grades intervals:(NSArray *)intervals{
    [self playGuitarAtCord:[cords[0] integerValue] grade:[grades[0] integerValue]];
    [self playGuitarAtCords:cords grades:grades intervals:intervals index:1];
}

// 使用递归方法来处理 时间间隔 播放
+ (void)playGuitarAtCords:(NSArray *)cords grades:(NSArray *)grades intervals:(NSArray *)intervals index:(NSInteger)index{
    if (cords.count <= index) {
        return ;
    }
    //因为在播放midi的时候，同步进行，需要大概0.02秒的耗时, 就是这么严谨
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(([intervals[index-1] floatValue] - 0.02) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self playGuitarAtCord:[cords[index] integerValue] grade:[grades[index] integerValue]];
        [self playGuitarAtCords:cords grades:grades intervals:intervals index:index+1];
    });
}

@end
