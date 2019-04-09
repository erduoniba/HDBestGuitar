#### 1、项目说明：

[**MIDI**](https://www.midi.org/)（`Musical Instrument Digital Interface`）乐器数字接口，为电子乐器等演奏设备定义各种音符或弹奏码，允许电子乐器、电脑、手机或者其他演出设备彼此连接，即时交互演奏数据。它不发不声音，只发送音调和音乐强度的数据。本项目就是通过对 `iPhone` 的界面操作来实现 `吉他` 的演奏，并且制作保存自定义的演奏项目。

[**开源MIDI项目**](http://openmidiproject.osdn.jp/index_chs.html) ：欢迎来到这里。在这儿我制作自由且[开源](http://opensource.org/osd-annotated)的MIDI软件和库文件。该软件和库文件基于 [GNU LGPL](https://www.gnu.org/licenses/old-licenses/lgpl-2.1.en.html) 协议发布。你可以在基于 [GNU LGPL](https://www.gnu.org/licenses/old-licenses/lgpl-2.1.en.html) 条款下进行下载，复制，二次分发，修改查看源码，修改程序。程序语言是C语言(世界树是C++)。这里也有[论坛](http://openmidiproject.osdn.jp/forums_chs.html)。可以提交程序错误报告，问题，使用感受等。

[**MuseScore**](https://musescore.org/zh-hant) ：用来打开制作好的 `MIDI` 文件，是一个所见即所得的编辑器，完全支持乐谱播放和导入或导出MusicXML和标准的MIDI文件。打击乐符号支持，是直接从程序印出。支持用midi电子琴键盘输入音高。文件可以PDF、MusicXML、Postscript、PNG、SVG。可以midi、wave、flac、ogg等音乐格式输出。具Musescore Connect 窗格[2] ，可浏览打开已出版的乐谱，或上传自己的乐谱。

[**SoundFont**](https://musescore.org/zh-hans/%E7%94%A8%E6%88%B7%E6%89%8B%E5%86%8C/soundfont-%E9%9F%B3%E8%89%B2%E5%BA%93) （[**SoundFont-英文**](https://musescore.org/en/handbook/soundfont) ）音色库，MuseScore 使用一种特殊的文件格式SoundFont(音色库)来告诉MuseScore如何播放乐器的声音，一个音色库能够保存任意个数的乐器，如果你使用了不兼容通用 MIDI 标准的音色库，可能会造成保存的 Midi 文件共享给其他人后听不到某些乐器声音的情况。

`FluidR3_GM.sf2` (未压缩大小 141 MB)
 [下载Fluid-soundfont.tar.gz](http://www.musescore.org/download/fluid-soundfont.tar.gz) 

[Github下载FluidR3Mono_GM](https://github.com/ChurchOrganist/FluidR3Mono_GM)

`GeneralUser GS.sf2 ` (未压缩大小 29.8 MB)

下载 [GeneralUser GS](http://schristiancollins.com/soundfonts/GeneralUser_GS_1.442-MuseScore.zip) 

`TimGM6mb.sf2` (未压缩大小 5.7 MB)
下载 [modified TimGM6mb.sf2](http://mscore.svn.sourceforge.net/viewvc/mscore/trunk/mscore/share/sound/TimGM6mb.sf2) (承蒙 [Tim Brechbill](http://ocmnet.com/saxguru/Timidity.htm#sf2) 而提供)



`MIDI` 128种乐器对应的代码：

```
PIANO 钢琴

　　1 Acoustic Grand Piano 大钢琴 

　　2 Bright Acoustic Piano 亮音大钢琴 

　　3 Electric Grand Piano 电钢琴 

　　4 Honky-Tonk Piano 酒吧钢琴 

　　5 Rhodes Piano 练习音钢琴 

　　6 Chorused Piano 合唱加钢琴 

　　7 Harpsichord 拨弦古钢琴 

　　8 Clavinet 击弦古钢琴 

CHROMATIC PERCUSSION 半音打击乐器

　　9 Celesta 钢片琴 

　　10 Glockenspiel 钟琴 

　　11 Music Box 八音盒 

　　12 Vibraphone 电颤琴 

　　13 Marimba 马林巴 

　　14 Xylophone 木琴 

　　15 Tubular Bells 管钟 

　　16 Dulcimer 扬琴 

ORGAN 风琴

　　17 Hammond Organ 击杆风琴 

　　18 Percussive Organ 打击型风琴 

　　19 Rock Organ 摇滚风琴 

　　20 Church Organ 管风琴 

　　21 Reed Organ 簧风琴 

　　22 Accordion 手风琴 

　　23 Harmonica 口琴 

　　24 Tango Accordian 探戈手风琴 

GUITAR 吉他

　　25 Acoustic Guitar (nylon) 尼龙弦吉他 

　　26 Acoustic Guitar(steel) 钢弦吉他 

　　27 Electric Guitar (jazz) 爵士乐电吉他 

　　28 Electric Guitar (clean) 清音电吉他 

　　29 Electric Guitar (muted) 弱音电吉他 

　　30 Overdriven Guitar 驱动音效吉他 

　　31 Distortion Guitar 失真音效吉他 

　　32 Guitar Harmonics 吉他泛音 

BASS 贝司

　　33 Acoustic Bass 原声贝司 

　　34 Electric Bass(finger) 指拨电贝司 

　　35 Electric Bass(pick) 拨片拨电贝司 

　　36 Fretless Bass 无品贝司 

　　37 Slap Bass 1 击弦贝司1 

　　38 Slap Bass 2 击弦贝司2 

　　39 Synth Bass 1 合成贝司1 

　　40 Synth Bass 2 合成贝司2 

SOLO STRINGS 弦乐独奏

　　41 Violin 小提琴 

　　42 Viola 中提琴 

　　43 Cello 大提琴 

　　44 Contrabass 低音提琴 

　　45 Tremolo Strings 弦乐震音 

　　46 Pizzicato Strings 弦乐拨奏 

　　47 Orchestral Harp 竖琴 

　　48 Timpani 定音鼓 

ENSEMBLE 合唱或合奏

　　49 String Ensemble 1 弦乐合奏1 

　　50 String Ensemble 2 弦乐合奏2 

　　51 SynthStrings 1 合成弦乐1 

　　52 SynthStrings 2 合成弦乐2 

　　53 Choir Aahs 合唱“啊”音 

　　54 Voice Oohs 人声“嘟”音 

　　55 Synth Voice 合成人声 

　　56 Orchestra Hit 乐队打击乐 

BRASS 铜管乐器

　　57 Trumpet 小号 

　　58 Trombone 长号 

　　59 Tuba 大号 

　　60 Muted Trumpet 弱音小号 

　　61 French Horn 圆号 

　　62 Brass Section 铜管组 

　　63 Synth Brass 1 合成铜管1 

　　64 Synth Brass 2 合成铜管2 

REED 哨片乐器

　　65 Soprano Sax 高音萨克斯 

　　66 Alto Sax 中音萨克斯 

　　67 Tenor Sax 次中音萨克斯 

　　68 Baritone Sax 上低音萨克斯 

　　69 Oboe 双簧管 

　　70 English Horn 英国管 

　　71 Bassoon 大管 

　　72 Clarinet 单簧管 

PIPE 吹管乐器

　　73 Piccolo 短笛 

　　74 Flute 长笛 

　　75 Recorder 竖笛 

　　76 Pan Flute 排笛 

　　77 Bottle Blow 吹瓶口 

　　78 Skakuhachi 尺八 

　　79 Whistle 哨 

　　80 Ocarina 洋埙 

SYNTH LEAD 合成主音

　　81 Lead 1 (square) 合成主音1（方波） 

　　82 Lead 2 (sawtooth) 合成主音2（锯齿波） 

　　83 Lead 3 (calliope lead) 合成主音3（汽笛风琴） 

　　84 Lead 4 (chiff lead) 合成主音4 （吹管） 

　　85 Lead 5 (charang) 合成主音5（吉他） 

　　86 Lead 6 (voice) 合成主音6（人声） 

　　87 Lead 7 (fifths) 合成主音7（五度） 

　　88 Lead 8 (bass+lead) 合成主音8（低音加主音） 

SYNTH PAD 合成柔音

　　89 Pad 1 (new age) 合成柔音1（新时代） 

　　90 Pad 2 (warm) 合成柔音（暖音） 

　　91 Pad 3 (polysynth) 合成柔音3（复合成） 

　　92 Pad 4 (choir) 合成柔音4（合唱） 

　　93 Pad 5 (bowed) 合成柔音5（弓弦） 

　　94 Pad 6 (metallic) 合成柔音6（金属） 

　　95 Pad 7 (halo) 合成柔音7（光环） 

　　96 Pad 8 (sweep) 合成柔音8（扫弦） 

SYNTH EFFECTS 合成特效

　　97 FX 1 (rain) 合成特效1（雨） 

　　98 FX 2 (soundtrack) 合成特效2（音轨） 

　　99 FX 3 (crystal) 合成特效3（水晶） 

　　100 FX 4 (atmosphere) 合成特效4（大气） 

　　101 FX 5 (brightness) 合成特效5（亮音） 

　　102 FX 6 (goblins) 合成特效6（小妖） 

　　103 FX 7 (echoes) 合成特效7（回声） 

　　104 FX 8 (sci-fi) 合成特效8（科幻） 

ETHNIC 民族乐器

　　105 Sitar 锡塔尔 

　　106 Banjo 班卓 

　　107 Shamisen 三味线 

　　108 Koto 筝 

　　109 Kalimba 卡林巴 

　　110 Bagpipe 风笛 

　　111 Fiddle 古提琴 

　　112 Shanai 唢呐 

PERCUSSIVE 打击乐

　　113 Tinkle Bell 铃铛 

　　114 Agogo 拉丁打铃 

　　115 Steel Drums 钢鼓 

　　116 Woodblock 木块 

　　117 Taiko Drum 太鼓 

　　118 Melodic Tom 嗵鼓 

　　119 Synth Drum 合成鼓 

　　120 Reverse Cymbal 镲波形反转 

SOUND EFFECTS 声音特效

　　121 Guitar Fret Noise 磨弦声 

　　122 Breath Noise 呼吸声 

　　123 Seashore 海浪声 

　　124 Bird Tweet 鸟鸣声 

　　125 Telephone Ring 电话铃声 

　　126 Helicopter 直升机声 

　　127 Applause 鼓掌声 

　　128 Gunshot 枪声 

实际代号应为列表中的代号减1。 
```



吉他各弦各品的音高对应的 `MIDI` 代码：

![](http://7xqhx8.com1.z0.glb.clouddn.com/guitar_midi_key.png) 





#### 2、项目第三方库：

i.	[Fabric](https://fabric.io) 实现项目 `crash` 收集;

ii.	[Rollout](https://rollout.io/) 通过 `js` 代码注入线上的项目来达到不重新发布项目而修改bug；

可以参考博客来使用 ：[Rollout学习1 简单使用篇](http://blog.csdn.net/u012390519/article/details/51444847)   [Rollout学习2 JS和OC代码对照篇](http://blog.csdn.net/u012390519/article/details/51444190) 

iii.   [MIKMIDI](https://github.com/mixedinkey-opensource/MIKMIDI) 这个是 `Github` 上一个开源代码，是这个项目的核心代码，实现了通过代码来播放 `MIDI` 音频、保存并下次继续播放自定义制作的一个 `MIDI` 工程。当然还支持和硬件的交互。这个代码我使用了 `framework` 来导入，[Xcode 创建静态库和动态库](http://blog.csdn.net/u012390519/article/details/41442793) 或许能在导入中帮忙。





