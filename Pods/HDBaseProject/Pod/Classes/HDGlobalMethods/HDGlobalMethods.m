//
//  GlobalMethods.m
//  Hotchpotch
//
//  Created by Harry on 15/8/3.
//  Copyright (c) 2015年 Harry. All rights reserved.
//

#import "HDGlobalMethods.h"

#import "HDGlobalVariable.h"

#import "UIColor+RGBValues.h"
#import <CommonCrypto/CommonDigest.h>

#import <MediaPlayer/MediaPlayer.h>

@implementation HDGlobalMethods

+ (NSString *)getDateString:(NSDate *)date withFormat:(NSString*)format
{
    NSTimeZone *tzGMT = [NSTimeZone timeZoneWithName:@"GMT+8:00"];
    [NSTimeZone setDefaultTimeZone:tzGMT];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:tzGMT];
    [dateFormatter setDateFormat:format];
    
    NSString *destDateString = [dateFormatter stringFromDate:date];
    
    return destDateString;
}

//时间转换 传人时间戳和样式字符串 如@"YYYY-MM-dd HH:mm"
+ (NSString *)stringFromTimeIntervalSince1970:(CGFloat)time dateFormat:(NSString *)format
{
    if (time <= 0) {
        return @"";
    }
    //设置时间显示格式:
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    //时间戳转时间的方法
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:time/1000];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    
    return confromTimespStr;
}


+ (UIButton *)createButton:(CGRect)frame title:(NSString *)title font:(UIFont *)font textCol:(UIColor *)textColor{
    UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
    bt.frame = frame;
    [bt setTitle:title forState:UIControlStateNormal];
    [bt setTitleColor:textColor forState:UIControlStateNormal];
    [bt setTitleColor:[textColor harry_colorByDarkeningColorWithValue:0.12] forState:UIControlStateHighlighted];
    [bt.titleLabel setFont:font];
    return bt;
}

+(UIButton *)createBackButton:(UIImage *)image1 hilight:(UIImage *)image2 {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    UIImage *normalImg = image1;
    UIImage *hightLightImg = image2;
    [btn setImage:normalImg forState:UIControlStateNormal];
    [btn setImage:hightLightImg forState:UIControlStateHighlighted];
    [btn setFrame:CGRectMake(0.0f, 0.0f, 0 + 30, 30.0f)];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >=7.0) {
        btn.contentEdgeInsets = UIEdgeInsetsMake(0, -11, 0, +11.0f);
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 2, 0, -2);
    }
    return btn;
}

+ (UILabel *)createLabel:(CGRect)frame title:(NSString *)title font:(UIFont *)font textCol:(UIColor *)textColor{
    UILabel *lb = [[UILabel alloc] initWithFrame:frame];
    lb.text = title;
    lb.font = font;
    lb.textColor = textColor;
    lb.numberOfLines = 0;
    return lb;
}

+ (CGSize)getSizeWithString:(NSString *)string font:(UIFont *)font constrainedToSize:(CGSize)size{
    
    if (!string || string.length == 0) {
        
        return CGSizeZero;
    }else{
        
        NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:string
                                                                             attributes:@{NSFontAttributeName: font}];
        CGRect rect = [attributedText boundingRectWithSize:size
                                                   options:NSStringDrawingUsesLineFragmentOrigin
                                                   context:nil];
        return rect.size;
    }
}


+(CGSize)getTextRect:(NSString *)text fontsize:(int)fontsize maxWidth:(int)maxWidth
{
	//测量文本宽高
	NSDictionary *attributes = [NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:fontsize] forKey:NSFontAttributeName];
	NSStringDrawingOptions option = NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
	
	CGRect rect = [text boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT)
									 options:option
								  attributes:attributes
									 context:nil];
	return rect.size;
}

+(CGSize)getTextRect:(NSString *)text fontsize:(int)fontsize
{
	return [self getTextRect:text fontsize:fontsize maxWidth:MAXFLOAT];
}



static NSBundle *gsBundle = nil;
+ (NSBundle *)resourceBundle:(NSString *)bundleName{
    if (!gsBundle)
    {
        NSString *path = [[NSBundle mainBundle] pathForResource:bundleName
                                                         ofType:@"bundle"];
        gsBundle = [NSBundle bundleWithPath: path];
    }
    
    return gsBundle;
}
+ (UIImage *)imageNamed:(NSString *)name{
    UIImage * img;
    if ([[[UIDevice currentDevice] systemVersion] compare:@"8.0"] != NSOrderedAscending)
    {
        img = [UIImage imageNamed:name inBundle:[self resourceBundle:@"Resources"] compatibleWithTraitCollection:nil];
    }
    else
    {
        CGFloat scale_screen = [UIScreen mainScreen].scale;
        if (scale_screen >= 2)
        {
            if ([name rangeOfString:@"."].length >0)
            {
                
            }
            else
            {
                name = [name stringByAppendingString:@".png"];
            }
        }
        img = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@", [[self resourceBundle:@"Resources"] bundlePath],name]];
    }
    
    if (!img) {
        img = [UIImage imageNamed:name];
    }
    
    return img;
}


/**
 *  md5加密
 *
 *  @param key 需要进行加密的key
 *
 *  @return md5加密后的数据
 */
+ (NSString *)md5Encrypt:(NSString *)key {
    const char *str = [key UTF8String];
    if (str == NULL) {
        str = "";
    }
    unsigned char r[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), r);
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH];
    
    for(int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02x",r[i]];
    }
    
    return ret;
}


/**
 *  通过经纬度获取该经纬度的地理信息
 *
 *  @param location        目标经纬度
 *  @param handlePlaceName 回调 经纬度对应的 地理信息
 */
+ (void )getPlaceNameWithLocation:(CLLocation *)location finish:(void (^)(NSString *))handlePlaceName{
    
    NSMutableArray *userDefaultLanguages = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
    // 强制 成 简体中文
    [[NSUserDefaults standardUserDefaults] setObject:[NSArray arrayWithObjects:@"zh-hans",nil] forKey:@"AppleLanguages"];
    
    if(location.coordinate.latitude > 0 && location.coordinate.longitude > 0){
        CLGeocoder *geo = [[CLGeocoder alloc] init];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [geo reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error){
                
                if ( error == nil && placemarks && [placemarks count] > 0){
                    
                    CLPlacemark *placeMark = [placemarks objectAtIndex:0];
                    NSDictionary *placeDic = placeMark.addressDictionary;
                    
                    NSMutableString *mString = [NSMutableString new];
                    if ([placeDic[@"City"] length] > 0) {
                        [mString appendString:placeDic[@"City"]];
                    }
                    if ([placeDic[@"SubLocality"] length] > 0) {
                        [mString appendString:placeDic[@"SubLocality"]];
                    }
                    if ([placeDic[@"Street"] length] > 0) {
                        [mString appendString:placeDic[@"Street"]];
                    }
            
                    if (mString.length == 0){
                        mString = [NSMutableString stringWithString:@"定位失败"];
                    }
                    
                    if (mString){
                        DLog(@"当前地理位置: %@", mString);
                    }
                    
                    handlePlaceName(mString);
                }
                
                [[NSUserDefaults standardUserDefaults] setObject:userDefaultLanguages forKey:@"AppleLanguages"];
            }];
            
        });
    }else{
        handlePlaceName(@"获取地理位置失败");
    }
}

/**
 *  通过经纬度获取该经纬度的地理信息
 *
 *  @param location        目标经纬度
 *  @param handlePlaceName 回调 经纬度对应的 城市名称
 */
+ (void )getCityNameWithLocation:(CLLocation *)location finish:(void (^)(NSString *))handlePlaceName{
    NSMutableArray *userDefaultLanguages = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
    // 强制 成 简体中文
    [[NSUserDefaults standardUserDefaults] setObject:[NSArray arrayWithObjects:@"zh-hans",nil] forKey:@"AppleLanguages"];
    
    if(location.coordinate.latitude > 0 && location.coordinate.longitude > 0){
        CLGeocoder *geo = [[CLGeocoder alloc] init];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [geo reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error){
                
                if ( error == nil && placemarks && [placemarks count] > 0){
                    
                    CLPlacemark *placeMark = [placemarks objectAtIndex:0];
                    NSDictionary *placeDic = placeMark.addressDictionary;
                    NSString *bmCityName = placeDic[@"City"];
                    if (!bmCityName){
                        bmCityName = placeMark.administrativeArea;
                    }
                    
                    if (bmCityName){
                        DLog(@"当前地理位置: %@", bmCityName);
                    }
                    
                    handlePlaceName(bmCityName);
                }
                
                [[NSUserDefaults standardUserDefaults] setObject:userDefaultLanguages forKey:@"AppleLanguages"];
            }];
            
        });
    }else{
        handlePlaceName(@"获取地理位置失败");
    }
}


+ (NSDateFormatter*) dateformatterForFormatter:(NSString*) formatter{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = formatter;
    return dateFormatter;
}

+ (BOOL) isImageTypeWithUrl:(NSString *)url{
    
    BOOL image = NO;
    
    if ([url containsString:@".png"] ||
        [url containsString:@".PNG"] ||
        [url containsString:@".jpg"] ||
        [url containsString:@".JPG"] ||
        [url containsString:@".jpeg"] ||
        [url containsString:@".JPEG"] ||
        [url containsString:@".bmp"] ||
        [url containsString:@".BMP"]) {
        image = YES;
    }
    
    return image;
}

+ (void)fFirstVideoFrame:(NSString *)path{
    
    // 1. 添加播放状态的监听
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    // 2. 截屏完成通知
    [nc addObserver:self selector:@selector(captureFinished:) name:MPMoviePlayerThumbnailImageRequestDidFinishNotification object:nil];
    
    MPMoviePlayerController *mp = [[MPMoviePlayerController alloc]
                                   initWithContentURL:[NSURL fileURLWithPath:path]];
    [mp requestThumbnailImagesAtTimes:@[@(0.5)] timeOption:MPMovieTimeOptionNearestKeyFrame];
    [mp stop];
}

- (void)captureFinished:(NSNotification *)notification
{
    // 3. 通知得到图片,需要代理或者其他方式获取
    UIImage *image = notification.userInfo[MPMoviePlayerThumbnailImageKey];
    NSLog(@"%@", image);
}

+(UIImage *)getImage:(NSString *)videoURL{
    
    //视频地址
    NSURL *url = [[NSURL alloc] initWithString:videoURL];//initFileURLWithPath:videoURL] autorelease];
    
    AVURLAsset *urlAsset = [AVURLAsset URLAssetWithURL:url options:nil];//
    
    //获取视频时长，单位：秒
    NSLog(@"%llu",urlAsset.duration.value/urlAsset.duration.timescale);
    
    AVAssetImageGenerator *generator = [AVAssetImageGenerator assetImageGeneratorWithAsset:urlAsset];
    generator.appliesPreferredTrackTransform = YES;
    NSError *error = nil;
    CGImageRef img = [generator copyCGImageAtTime:CMTimeMake(0, 1) actualTime:NULL error:&error];
    UIImage *image = [UIImage imageWithCGImage: img];
    
    if (!image) {
        image = GET_IMAGE_NAME(@"movie");
    }
    
    return image;
}

+ (void) lowQuailtyWithInputURL:(NSURL*)inputURL
                      outputURL:(NSURL*)outputURL
                   blockHandler:(void (^)(AVAssetExportSession*))handler
{
    AVURLAsset *asset = [AVURLAsset URLAssetWithURL:inputURL options:nil];
    AVAssetExportSession *session = [[AVAssetExportSession alloc] initWithAsset:asset presetName:AVAssetExportPresetMediumQuality];
    session.shouldOptimizeForNetworkUse = YES;
    session.outputURL = outputURL;
    session.outputFileType = AVFileTypeQuickTimeMovie;
    [session exportAsynchronouslyWithCompletionHandler:^(void)
     {
         handler(session);
     }];
}

@end
