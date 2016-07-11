//
//  HDMainViewController.m
//  HDBestGuitar
//
//  Created by Harry on 16/7/7.
//  Copyright © 2016年 HarryDeng. All rights reserved.
//

#import "HDMainViewController.h"

#pragma mark - assist
#import "HDImageAssist.h"
#import "UIDevice+HDCategory.h"
#import "HDAnimationAssist.h"
#import "HDGuitarCordView.h"

#import <MIKMIDI/MIKMIDISynthesizer.h>
#import <MIKMIDI/MIKMIDINoteOnCommand.h>
#import <MIKMIDI/MIKMIDINoteOffCommand.h>
#import "HDGuitarRhythmView.h"


@interface HDMainViewController () <HDGuitarCordViewDelegate>


PROPERTY_STRONG UIImageView *bgView;
PROPERTY_STRONG HDGuitarCordView *guitarCordView;

@property (nonatomic, strong) MIKMIDISynthesizer *synthesizer;

@end

@implementation HDMainViewController

- (void)hdGuitarRhythmView:(HDGuitarRhythmView *)rhythmView atIndex:(NSInteger)index{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _bgView = [[UIImageView alloc] initWithFrame:self.view.frame];
    _bgView.image = [HDImageAssist getWholeImageWithName:@"bg_chordsmode_" ofType:@"jpg"];
    [self.view addSubview:_bgView];
    

    _guitarCordView = [[HDGuitarCordView alloc] initWithFrame:self.view.bounds];
    _guitarCordView.delegate = self;
    [self.view addSubview:_guitarCordView];
    
    HDGuitarRhythmView *rhythmView = [[HDGuitarRhythmView alloc] initWithFrame:CGRectMake(10, 0, 81, self.view.frameSizeHeight)];
    [self.view addSubview:rhythmView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hhhhhh)];
    [self.view addGestureRecognizer:tap];
}


#pragma mark - HDGuitarCordViewDelegate 
- (void)hdGuitarCordView:(HDGuitarCordView *)guitarCordView atIndex:(NSInteger)index{

}

- (void)hhhhhh{
    int choiceNote = random() % 16 + 50;
    NSLog(@"choiceNote : %d", choiceNote);
    UInt8 note = choiceNote;
    MIKMIDINoteOnCommand *noteOn = [MIKMIDINoteOnCommand noteOnCommandWithNote:note velocity:127 channel:0 timestamp:[NSDate date]];
    [self.synthesizer handleMIDIMessages:@[noteOn]];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        MIKMIDINoteOffCommand *noteOff = [MIKMIDINoteOffCommand noteOffCommandWithNote:note velocity:127 channel:0 timestamp:[NSDate date]];
        [self.synthesizer handleMIDIMessages:@[noteOff]];
    });
}


- (MIKMIDISynthesizer *)synthesizer
{
    if (!_synthesizer) {
        _synthesizer = [[MIKMIDISynthesizer alloc] init];
        NSURL *soundfont = [[NSBundle mainBundle] URLForResource:@"GeneralUser GS MuseScore v1.442" withExtension:@"sf2"];
        NSError *error = nil;
        if (![_synthesizer loadSoundfontFromFileAtURL:soundfont presetID:27 error:&error]) {
            NSLog(@"Error loading soundfont for synthesizer. Sound will be degraded. %@", error);
        }
    }
    return _synthesizer;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
