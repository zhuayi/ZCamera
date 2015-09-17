//
//  CameraViewController.h
//  IOSLib
//
//  Created by zhuayi on 7/30/15.
//  Copyright (c) 2015 zhuayi. All rights reserved.
//

//#import "BaseViewController.h"
#import "ZCameraDelegate.h"

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
 *  直接打开相机
 */
- (void)goToCameraView;

/**
 *  直接打开图库
 */
- (void)goToPhotoLibrary;
@end
