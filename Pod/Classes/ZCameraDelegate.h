//
//  Camera.h
//  IOSLib
//
//  Created by zhuayi on 8/3/15.
//  Copyright (c) 2015 zhuayi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class ZPhotoCollectionViewCell;
@class ZCameraImageModel;

@protocol ZCameraViewDelegate <NSObject>

/**
 *  从图库中选择N 张图片后调用
 *
 *  @param imageArry
 */
- (void)didSendPhotoWithImageArray:(NSArray *)imageArry;

/**
 *  选取一张拍摄后的照片后调用
 *
 *  @param image
 */
- (void)didSendPhotoWidthImage:(UIImage *)image;


/**
 *  视频地址
 *
 *  @param url
 */
- (void)didSendVideoUrl:(NSURL *)url;

/**
 *  取消选择图片时调用
 */
- (void)didDismissViewController;


/**
 *  相机不可用时调用
 */
- (void)didCameraUnavailable;

/**
 *  图库不可用时调用
 */
- (void)didPhotoLibraryUnavailable;

@end

/**
 *  camera基类代理
 */
@protocol PhotoViewCellDelegate <NSObject>

/**
 *  选中图标选中 button
 *
 *  @param imageModel
 */
- (void)didSelectCellWithAtSelectButton:(ZCameraImageModel *)imageModel button:(UIButton *)button;

/**
 *  选中图片 cell
 *
 *  @param indexPath
 */
- (void)didSelectCellWithAtIndexPath:(NSIndexPath *)indexPath;


@end

