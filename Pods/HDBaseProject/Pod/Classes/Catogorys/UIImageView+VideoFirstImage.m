//
//  UIImageView+VideoFirstImage.m
//  MakeFight
//
//  Created by Harry on 15/9/28.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import "UIImageView+VideoFirstImage.h"

#import <objc/runtime.h>

#import <AVFoundation/AVFoundation.h>
#import <SDWebImage/SDImageCache.h>


#pragma mark -

@interface UIImageView (_VideoFirstImage)
@property (readwrite, nonatomic, strong) NSOperation *videoOperation;
@property (readwrite, nonatomic, strong) AVURLAsset *urlAsset;
@end

@implementation UIImageView (_VideoFirstImage)

@dynamic videoOperation;
@dynamic urlAsset;

+ (NSOperationQueue *)video_sharedImageRequestOperationQueue {
    static NSOperationQueue *_video_sharedImageRequestOperationQueue = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _video_sharedImageRequestOperationQueue = [[NSOperationQueue alloc] init];
        _video_sharedImageRequestOperationQueue.maxConcurrentOperationCount = NSOperationQueueDefaultMaxConcurrentOperationCount;
    });
    
    return _video_sharedImageRequestOperationQueue;
}

- (NSOperation *)videoOperation {
    return (NSOperation *)objc_getAssociatedObject(self, @selector(videoOperation));
}

- (void) setVideoOperation:(NSOperation *)videoOperation{
    objc_setAssociatedObject(self, @selector(videoOperation), videoOperation, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (AVURLAsset *)urlAsset{
    return (AVURLAsset *)objc_getAssociatedObject(self, @selector(urlAsset));
}

- (void)setUrlAsset:(AVURLAsset *)urlAsset{
    objc_setAssociatedObject(self, @selector(urlAsset), urlAsset, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end



#pragma mark -

@implementation UIImageView (VideoFirstImage)

- (void)setVoideWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholderImage{
    
    if (self.videoOperation) {
        [self.videoOperation cancel];
    }
    
    UIImage *cacheImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:url.absoluteString];
    if (cacheImage) {
        self.image = cacheImage;
        return ;
    }
    
    self.videoOperation = [[NSOperation alloc] init];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        
        __weak __typeof(self)weakSelf = self;
        [self.videoOperation setCompletionBlock:^{
            
            __strong __typeof(weakSelf)strongSelf = weakSelf;
            
            strongSelf.urlAsset = [AVURLAsset URLAssetWithURL:url options:nil];//
            
            //获取视频时长，单位：秒
            NSLog(@"%llu",strongSelf.urlAsset.duration.value / strongSelf.urlAsset.duration.timescale);
            AVAssetImageGenerator *generator = [AVAssetImageGenerator assetImageGeneratorWithAsset:strongSelf.urlAsset];
            generator.appliesPreferredTrackTransform = YES;
            NSError *error = nil;
            CGImageRef img = [generator copyCGImageAtTime:CMTimeMake(0, 1) actualTime:NULL error:&error];
            UIImage *image = [UIImage imageWithCGImage: img];
            
            if (!image) {
                image = placeholderImage;
            }
            else{
                [[SDImageCache sharedImageCache] storeImage:image forKey:url.absoluteString toDisk:YES completion:^{

                }];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                strongSelf.image = image;
            });
            
        }];
        
    });
    
    [[[self class] video_sharedImageRequestOperationQueue] addOperation:self.videoOperation];
}

@end
