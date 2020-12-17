//
//  FirstFrameOfTheVideo.m
//  labor
//
//  Created by 狍子 on 2020/9/5.
//  Copyright © 2020 ZKWQY. All rights reserved.
//  获取视频第一帧

#import "FirstFrameOfTheVideo.h"
#import <AVFoundation/AVFoundation.h>

@implementation FirstFrameOfTheVideo
#pragma mark ---- 获取视频第一帧
+ (UIImage *)firstFrameWithVideoURL:(NSURL *)url size:(CGSize)size
{
    // 获取视频第一帧

    AVURLAsset *urlAsset = [AVURLAsset URLAssetWithURL:url options:nil];
    AVAssetImageGenerator *generator = [AVAssetImageGenerator assetImageGeneratorWithAsset:urlAsset];
    generator.apertureMode = AVAssetImageGeneratorApertureModeEncodedPixels;

    generator.appliesPreferredTrackTransform = YES;
//    CGFloat scale = [[UIScreen mainScreen] scale];
//    generator.maximumSize = CGSizeMake(size.width *scale, size.height * scale);
    NSError *error = nil;
    CMTime actualTime;
    CGImageRef img = [generator copyCGImageAtTime:CMTimeMake(1, 2) actualTime:&actualTime error:&error];
//    CGImageRelease(img);

    {
        return [UIImage imageWithCGImage:img];
    }
    return nil;
}


@end
