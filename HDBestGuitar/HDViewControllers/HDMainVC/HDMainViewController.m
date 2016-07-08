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

@interface HDMainViewController () <HDGuitarRhythmViewDelegate>

PROPERTY_STRONG UIImageView *bgView;

PROPERTY_STRONG UIImageView *imageView;

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
    
    HDGuitarCordView *vvv = [[HDGuitarCordView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:vvv];
    
    HDGuitarRhythmView *rhythmView = [[HDGuitarRhythmView alloc] initWithFrame:CGRectMake(10, 0, 81, self.view.frameSizeHeight)];
    [self.view addSubview:rhythmView];
    
    
//    
//    UIImage *obj = [UIImage imageNamed:STRING_FROMAT(@"cord%d", 6)];
//    UIImage *image = [obj resizableImageWithCapInsets:UIEdgeInsetsZero resizingMode:UIImageResizingModeTile];
//    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frameSizeWidth, obj.size.height)];
//    _imageView.image = image;
//    [self.view addSubview:_imageView];
//    [_imageView centerAlignVerticalForSuperView];
//    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(btnImageView:)];
//    [self.view addGestureRecognizer:tap];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hhhhhh)];
    [self.view addGestureRecognizer:tap];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
