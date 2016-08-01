//
//  HDChoiceChordRhythm.m
//  HDBestGuitar
//
//  Created by Harry on 16/7/29.
//  Copyright © 2016年 HarryDeng. All rights reserved.
//

#import "HDChoiceChordRhythm.h"
#import "HDGuitarRhythmModel.h"
#import "HDGuitarChordModel.h"
#import "HDImageAssist.h"
#import <HDBaseProject/UIImage+Tint.h>
#import <MBProgressHUD/MBProgressHUD.h>

@interface HDChoiceChordRhythm () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray   *chords; //当前选择的和弦组
@property (nonatomic, strong) NSMutableArray   *rhythms; //当前选择的节奏组

@property (nonatomic, strong) NSArray           *totalChords; //当前选择的和弦组
@property (nonatomic, strong) NSArray           *totalRhythms; //当前选择的节奏组

@property (nonatomic, strong) UIImageView       *bgView;
@property (nonatomic, strong) UITableView       *chordsTableView;
@property (nonatomic, strong) UITableView       *rhythmsTableView;

@end

@implementation HDChoiceChordRhythm

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.title = @"设置";
    self.view.backgroundColor = [UIColor orangeColor];
    
    _chords = [NSMutableArray arrayWithArray:[HDGuitarChordModel customChords]];
    _rhythms = [NSMutableArray arrayWithArray:[HDGuitarRhythmModel customRhythms]];
    
    _totalChords = [HDGuitarChordModel totalChords];
    _totalRhythms = [HDGuitarRhythmModel totalRhythms];
    
    
    _bgView = [[UIImageView alloc] initWithFrame:self.view.frame];
    _bgView.image = [HDImageAssist getWholeImageWithName:@"bg_chordsmode_black_" ofType:@"jpg"];
    [self.view addSubview:_bgView];
    
    [self.view addSubview:self.chordsTableView];
    [self.view addSubview:self.rhythmsTableView];
    
    UIButton *chordRhythmBt = [UIButton buttonWithType:UIButtonTypeCustom];
    chordRhythmBt.frame = CGRectMake(kScreenWidth - 81, kScreenHeight - 81, 81, 81);
    [chordRhythmBt addTarget:self action:@selector(chordRhythmAction) forControlEvents:UIControlEventTouchUpInside];
    [chordRhythmBt setBackgroundImage:[UIImage imageNamed:@"buts"] forState:UIControlStateNormal];
    [chordRhythmBt setBackgroundImage:[UIImage imageNamed:@"buts_press"] forState:UIControlStateHighlighted];
    [chordRhythmBt setBackgroundImage:[UIImage imageNamed:@"buts_press"] forState:UIControlStateSelected];
    [chordRhythmBt setImage:[[UIImage imageNamed:@"ico_btn_back"] imageTintedWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    [self.view addSubview:chordRhythmBt];
}


- (UITableView *)chordsTableView{
    if (!_chordsTableView) {
        _chordsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth / 2, kScreenHeight) style:UITableViewStylePlain];
        _chordsTableView.delegate = self;
        _chordsTableView.dataSource = self;
        _chordsTableView.backgroundColor = [UIColor clearColor];
        _chordsTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _chordsTableView.showsVerticalScrollIndicator = NO;
        _chordsTableView.tableFooterView = [UIView new];
    }
    return _chordsTableView;
}

- (UITableView *)rhythmsTableView{
    if (!_rhythmsTableView) {
        _rhythmsTableView = [[UITableView alloc] initWithFrame:CGRectMake(kScreenWidth / 2, 0, kScreenWidth / 2, kScreenHeight) style:UITableViewStylePlain];
        _rhythmsTableView.delegate = self;
        _rhythmsTableView.dataSource = self;
        _rhythmsTableView.backgroundColor = [UIColor clearColor];
        _rhythmsTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _rhythmsTableView.showsVerticalScrollIndicator = NO;
        _rhythmsTableView.tableFooterView = [UIView new];
    }
    return _rhythmsTableView;
}

- (void)chordRhythmAction{
    
    if (_choiceChords) {
        _choiceChords(_chords);
    }
    
    if (_choiceRhythms) {
        _choiceRhythms(_rhythms);
    }
    
    [HDGuitarChordModel saveCustomChords:_chords];
    [HDGuitarRhythmModel saveCustomRhythms:_rhythms];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - tableView methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == _chordsTableView) {
        return _totalChords.count;
    }
    return _totalRhythms.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _chordsTableView) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"chordsTableViewCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"chordsTableViewCell"];
            cell.backgroundColor = [UIColor clearColor];
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
        }
        
        HDGuitarChordModel *chordModel = _totalChords[indexPath.row];
        cell.textLabel.text = chordModel.chordName;
        cell.textLabel.textColor = [UIColor whiteColor];
        [self changeTableViewCell:cell withModel:chordModel];
        
        return cell;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"rhythmsTableViewCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"rhythmsTableViewCell"];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    HDGuitarRhythmModel *rhythmModel = _totalRhythms[indexPath.row];
    cell.textLabel.text = rhythmModel.rhythmName;
    cell.textLabel.textColor = [UIColor whiteColor];
    [self changeTableViewCell:cell withModel:rhythmModel];
    
    return cell;
}

- (void)changeTableViewCell:(UITableViewCell *)cell withModel:(id)model{
    if ([model isKindOfClass:[HDGuitarChordModel class]]) {
        HDGuitarChordModel *chord = (HDGuitarChordModel *)model;
        for (HDGuitarChordModel *m in _chords) {
            if ([chord.chordName isEqualToString:m.chordName]) {
                cell.textLabel.textColor = [UIColor orangeColor];
                break ;
            }
        }
    }
    else if ([model isKindOfClass:[HDGuitarRhythmModel class]]) {
        HDGuitarRhythmModel *rhythm = (HDGuitarRhythmModel *)model;
        for (HDGuitarRhythmModel *m in _rhythms) {
            if ([rhythm.rhythmName isEqualToString:m.rhythmName]) {
                cell.textLabel.textColor = [UIColor orangeColor];
                break ;
            }
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (tableView == _chordsTableView) {
        HDGuitarChordModel *chordModel = _totalChords[indexPath.row];
        BOOL hasChoice = NO;
        for (HDGuitarChordModel *m in _chords) {
            if ([chordModel.chordName isEqualToString:m.chordName]) {
                [_chords removeObject:m];
                cell.textLabel.textColor = [UIColor whiteColor];
                hasChoice = YES;
                break;
            }
        }
        if (!hasChoice) {
            
            // 最多支持5个和弦组
            if (_chords.count >= 5) {
                
                MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
                [self.view addSubview:hud];
                hud.mode = MBProgressHUDModeText;
                hud.labelText = @"最多支持5组和弦";
                [hud show:YES];
                hud.removeFromSuperViewOnHide = YES;
                [hud hide:YES afterDelay:1.5];
                
                return ;
            }
            
            cell.textLabel.textColor = [UIColor orangeColor];
            [_chords addObject:chordModel];
        }
    }
    else if (tableView == _rhythmsTableView) {
        HDGuitarRhythmModel *rhythmModel = _totalRhythms[indexPath.row];
        BOOL hasChoice = NO;
        for (HDGuitarRhythmModel *m in _rhythms) {
            if ([rhythmModel.rhythmName isEqualToString:m.rhythmName]) {
                [_rhythms removeObject:m];
                cell.textLabel.textColor = [UIColor whiteColor];
                hasChoice = YES;
                break;
            }
        }
        if (!hasChoice) {
            
            // 最多支持4个节奏组
            if (_rhythms.count >= 4) {
                
                MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
                [self.view addSubview:hud];
                hud.mode = MBProgressHUDModeText;
                hud.labelText = @"最多支持4组节奏";
                [hud show:YES];
                hud.removeFromSuperViewOnHide = YES;
                [hud hide:YES afterDelay:1.5];
                
                return ;
            }
            
            cell.textLabel.textColor = [UIColor orangeColor];
            [_rhythms addObject:rhythmModel];
        }
    }
    
}



@end
