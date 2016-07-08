#### 1、项目说明：

[**MIDI**](https://www.midi.org/)（`Musical Instrument Digital Interface`）乐器数字接口，为电子乐器等演奏设备定义各种音符或弹奏码，允许电子乐器、电脑、手机或者其他演出设备彼此连接，即时交互演奏数据。它不发不声音，只发送音调和音乐强度的数据。本项目就是通过对 `iPhone` 的界面操作来实现 `吉他` 的演奏，并且制作保存自定义的演奏项目。

[**开源MIDI项目**](http://openmidiproject.osdn.jp/index_chs.html) ：欢迎来到这里。在这儿我制作自由且[开源](http://opensource.org/osd-annotated)的MIDI软件和库文件。该软件和库文件基于 [GNU LGPL](https://www.gnu.org/licenses/old-licenses/lgpl-2.1.en.html) 协议发布。你可以在基于 [GNU LGPL](https://www.gnu.org/licenses/old-licenses/lgpl-2.1.en.html) 条款下进行下载，复制，二次分发，修改查看源码，修改程序。程序语言是C语言(世界树是C++)。这里也有[论坛](http://openmidiproject.osdn.jp/forums_chs.html)。可以提交程序错误报告，问题，使用感受等。

[**MuseScore**](https://musescore.org/zh-hant) ：用来打开制作好的 `MIDI` 文件，是一个所见即所得的编辑器，完全支持乐谱播放和导入或导出MusicXML和标准的MIDI文件。打击乐符号支持，是直接从程序印出。支持用midi电子琴键盘输入音高。文件可以PDF、MusicXML、Postscript、PNG、SVG。可以midi、wave、flac、ogg等音乐格式输出。具Musescore Connect 窗格[2] ，可浏览打开已出版的乐谱，或上传自己的乐谱。

[**SoundFont**](https://musescore.org/zh-hans/%E7%94%A8%E6%88%B7%E6%89%8B%E5%86%8C/soundfont-%E9%9F%B3%E8%89%B2%E5%BA%93) （[**SoundFont-英文**](https://musescore.org/en/handbook/soundfont) ）音色库，MuseScore 使用一种特殊的文件格式SoundFont(音色库)来告诉MuseScore如何播放乐器的声音，一个音色库能够保存任意个数的乐器，如果你使用了不兼容通用 MIDI 标准的音色库，可能会造成保存的 Midi 文件共享给其他人后听不到某些乐器声音的情况。

`FluidR3_GM.sf2` (未压缩大小 141 MB)
下载 [Fluid-soundfont.tar.gz](http://www.musescore.org/download/fluid-soundfont.tar.gz) 

`GeneralUser GS.sf2 ` (未压缩大小 29.8 MB)

下载 [GeneralUser GS](http://schristiancollins.com/soundfonts/GeneralUser_GS_1.442-MuseScore.zip) 

`TimGM6mb.sf2` (未压缩大小 5.7 MB)
下载 [modified TimGM6mb.sf2](http://mscore.svn.sourceforge.net/viewvc/mscore/trunk/mscore/share/sound/TimGM6mb.sf2) (承蒙 [Tim Brechbill](http://ocmnet.com/saxguru/Timidity.htm#sf2) 而提供)



吉他各弦各品的音高对应的 `MIDI` 代码：

![](http://7xqhx8.com1.z0.glb.clouddn.com/guitar_midi_key.png) 





#### 2、项目第三方库：

i.	[Fabric](https://fabric.io) 实现项目 `crash` 收集;

ii.	[Rollout](https://rollout.io/) 通过 `js` 代码注入线上的项目来达到不重新发布项目而修改bug；

可以参考博客来使用 ：[Rollout学习1 简单使用篇](http://blog.csdn.net/u012390519/article/details/51444847)   [Rollout学习2 JS和OC代码对照篇](http://blog.csdn.net/u012390519/article/details/51444190) 

iii.   [MIKMIDI](https://github.com/mixedinkey-opensource/MIKMIDI) 这个是 `Github` 上一个开源代码，是这个项目的核心代码，实现了通过代码来播放 `MIDI` 音频、保存并下次继续播放自定义制作的一个 `MIDI` 工程。当然还支持和硬件的交互。这个代码我使用了 `framework` 来导入，[Xcode 创建静态库和动态库](http://blog.csdn.net/u012390519/article/details/41442793) 或许能在导入中帮忙。





