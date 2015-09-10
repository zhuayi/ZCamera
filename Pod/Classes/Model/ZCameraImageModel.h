//
//  CameraImageModel.h
//  IOSLib
//
//  Created by zhuayi on 8/11/15.
//  Copyright (c) 2015 zhuayi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface ZCameraImageModel : NSObject

/**
 *  图片地址
 */
@property (nonatomic, strong) NSURL *imageUrl;

/**
 *  是否选中状态
 */
@property (nonatomic, assign) BOOL selected;


//@property (nonatomic, strong) ALAsset *asset;


@end
