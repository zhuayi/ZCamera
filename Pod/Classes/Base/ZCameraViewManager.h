//
//  CameraViewController.h
//  IOSLib
//
//  Created by zhuayi on 7/30/15.
//  Copyright (c) 2015 zhuayi. All rights reserved.
//

//#import "BaseViewController.h"
#import "ZCameraDelegate.h"
#import <AVFoundation/AVFoundation.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import <MediaPlayer/MediaPlayer.h>
#import <CoreMedia/CoreMedia.h>

typedef void(^ImageBlock)(NSArray *imageArray);



@interface ZCameraViewManager : UIView


@property (nonatomic, weak) id<ZCameraViewDelegate> delegate;

/**
 *  是否多选, 默认 yes
 */
@property (nonatomic, assign) BOOL multiple;


/**
 *  是否允许编辑, 单选情况下才生效
 */
@property (nonatomic, assign) BOOL allowsEditing;


/**
 *  多选图片时初始值
 */
@property (nonatomic, assign) NSInteger threshold;

/**
 *  多选图片最大值
 */
@property (nonatomic, assign) NSInteger maximum;

/**
 *  视频录制时间
 */
@property (nonatomic, assign) NSTimeInterval videoMaximumDuration;

/**
 *  视频质量
 */
@property(nonatomic) NSString *qualityType;

/**
 *  显示
 */
- (void)show;


/**
 *  根据 assets-url 获取图片缩略图
 *
 *  @param imageOriginalArray
 *  @param imageArray
 */
+ (void)getImageThumbnailWithArray:(NSArray *)imageOriginalArray imageArray:(ImageBlock)imageArray;


/**
 *  根据 assets-url 获取图片全屏图
 *
 *  @param imageOriginalArray
 *  @param imageArray
 */
+ (void)getImageAspectRatioThumbnaillWithArray:(NSArray *)imageOriginalArray imageArray:(ImageBlock)imageArray;


/**
 *  根据 assets-url 获取图片原图
 *
 *  @param imageOriginalArray
 *  @param imageArray
 */
+ (void)getImageFullScreenWithArray:(NSArray *)imageOriginalArray imageArray:(ImageBlock)imageArray;

/**
 *  视频转码
 *
 *  @param inputURL   源视频地址
 *  @param outputURL  输出地址
 *  @param presetName 压缩质量, AVAssetExportPresetMediumQuality
 *  @param handler
 */
+ (void)getVideoTranscodMp4WithUrl:(NSURL*)inputURL outputURL:(NSURL*)outputURL presetName:(NSString *)presetName blockHandler:(void (^)(AVAssetExportSession *session))handler;


/**
 *  直接打开相机
 */
- (void)goToCameraView;

/**
 *  直接打开图库
 */
- (void)goToPhotoLibrary;

/**
 *  打开录像控制器
 */
- (void)goToVideoView;

@end
