//
//  HDChoiceChordRhythm.h
//  HDBestGuitar
//
//  Created by Harry on 16/7/29.
//  Copyright © 2016年 HarryDeng. All rights reserved.
//

#import <HDBaseProject/HDBaseProject.h>

@interface HDChoiceChordRhythm : HDBaseViewController

@property (nonatomic, copy) void (^ choiceChords)(NSArray *chords);
@property (nonatomic, copy) void (^ choiceRhythms)(NSArray *rhythms);

@end
