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
 *  播放midi音符，默认在0.4秒后停止播放该音符
 *
 *  @param note 音符，具体见项目README.md文件说明
 */
+ (void)playMidiNote:(NSUInteger)note{
    DLog(@"播放 %d 音符", (int)note);
    MIKMIDINoteOnCommand *noteOn = [MIKMIDINoteOnCommand noteOnCommandWithNote:note velocity:127 channel:0 timestamp:[NSDate date]];
    [self.midiSynthesizer handleMIDIMessages:@[noteOn]];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        MIKMIDINoteOffCommand *noteOff = [MIKMIDINoteOffCommand noteOffCommandWithNote:note velocity:127 channel:0 timestamp:[NSDate date]];
        [self.midiSynthesizer handleMIDIMessages:@[noteOff]];
    });
}

/**
 *  获取 吉他 不同地方按键对应的音符值
 *
 *  @return 吉他 音符值的二维数组(6 x 25)
 */
+ (NSArray *)getGuitarNotes{
    return @[
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
}

@end
