//
//  PhotoCollectionViewCell.h
//  IOSLib
//
//  Created by zhuayi on 7/30/15.
//  Copyright (c) 2015 zhuayi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZCameraDelegate.h"
#import "ZCameraImageModel.H"

@interface ZPhotoCollectionViewCell : UICollectionViewCell

/**
 *  图片地址
 */
@property (nonatomic, strong) ZCameraImageModel *imageModel;


@property (nonatomic, weak) id<PhotoViewCellDelegate> delegete;


@property (nonatomic, strong) UIImageView *imageView;
@end
