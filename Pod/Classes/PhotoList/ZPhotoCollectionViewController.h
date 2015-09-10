//
//  PhotoCollectionViewController.h
//  IOSLib
//
//  Created by zhuayi on 7/30/15.
//  Copyright (c) 2015 zhuayi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBaseViewController.h"
#import "ZPhotoCollectionView.h"
#import "ZPhotoCollectionViewCell.h"

@interface ZPhotoCollectionViewController : ZBaseViewController<UICollectionViewDelegate,PhotoViewCellDelegate>

@property(nonatomic, weak) id<ZCameraViewDelegate> delegate;

/**
 *  检查图库是否可用
 */
- (BOOL)checkPhotoLibraryAvailable;

/**
 *  检查相册是否可用
 */
- (BOOL)checkPhotosAlbumAvailable;

/**
 *  选中的图片
 */
@property (nonatomic, strong) NSMutableDictionary *selectPhotoDict;

/**
 *  多选图片时初始值
 */
@property (nonatomic, assign) NSInteger threshold;

/**
 *  多选图片最大值
 */
@property (nonatomic, assign) NSInteger maximum;


@end
