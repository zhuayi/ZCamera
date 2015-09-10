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

- (void)didSendPhotoWithImageArray:(NSArray *)imageArry;

- (void)didSendPhotoWidthImage:(UIImage *)image;


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

