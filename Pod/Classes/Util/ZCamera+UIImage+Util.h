//
//  UIImageUtil.h
//  BaiduLibrary
//
//  Created by Liang on 14/12/2.
//  Copyright (c) 2014年 zhuayi inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIImage(ZCameraUIImageUtil)


/**
 *  根据宽度生成缩略图
 *
 *  @param image
 *  @param maxImageSize
 *
 *  @return
 */
- (UIImage *)thumbnailWithImage:(CGFloat)maxImageSize;


/**
 *  生成固定大小的图
 *
 *  @param image
 *  @param asize
 *
 *  @return
 */
- (UIImage *)thumbnailWithImageWithoutScale:(CGSize)asize;

/**
 *  UIImage 转换成 NSData
 *
 *  @param image UIImage
 *
 *  @return NSData
 */
-(NSData *)imageToData:(CGFloat)maxImageLength;

@end
