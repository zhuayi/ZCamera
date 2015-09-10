//
//  UIImageUtil.m
//  BaiduLibrary
//
//  Created by Liang on 14/12/2.
//  Copyright (c) 2014年 zhuayi inc. All rights reserved.
//

#import "ZCamera+UIImage+Util.h"

/**
 *  图片最大KB数
 */
//static CGFloat const MaxImageLength = 150.0f;
//static CGFloat const MaxImageSize = 1024;

@implementation UIImage (ZCameraUIImageUtil)


- (UIImage *)thumbnailWithImage:(CGFloat)maxImageSize {
    
    CGFloat width = 0;
    CGFloat height = 0;
    if (self.size.width > maxImageSize || self.size.height > maxImageSize) {
        if (self.size.width > self.size.height) {
            width = maxImageSize;
            height = self.size.height / (self.size.width / width);
        }else{
            height = maxImageSize;
            width = self.size.width / (self.size.height / height);
        }
    }
    UIImage *thumbnail = self;
    if (width > 0 && height > 0) {
        thumbnail = [self thumbnailWithImageWithoutScale:CGSizeMake(width, height)];
    }
    return thumbnail;
}


/**
 *  生成固定大小的图
 *
 *  @param image
 *  @param asize
 *
 *  @return
 */
- (UIImage *)thumbnailWithImageWithoutScale:(CGSize)asize {

    CGSize oldsize = self.size;
    CGRect rect;
    if (asize.width/asize.height > oldsize.width/oldsize.height) {
        rect.size.width = asize.height*oldsize.width/oldsize.height;
        rect.size.height = asize.height;
        rect.origin.x = (asize.width - rect.size.width)/2;
        rect.origin.y = 0;
    }
    else{
        rect.size.width = asize.width;
        rect.size.height = asize.width*oldsize.height/oldsize.width;
        rect.origin.x = 0;
        rect.origin.y = (asize.height - rect.size.height)/2;
    }
    UIGraphicsBeginImageContext(asize);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
    UIRectFill(CGRectMake(0, 0, asize.width, asize.height));
    [self drawInRect:rect];
    UIImage *newimage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newimage;
}

/**
 *  UIImage 转换成 NSData
 *
 *  @param image UIImage
 *
 *  @return NSData
 */
- (NSData *)imageToData:(CGFloat)maxImageLength {
    NSData *data = UIImageJPEGRepresentation(self, 1);
    NSInteger length = data.length / 1024;
    if (length < maxImageLength) { //如果图片大小低于150k，直接返回，不需要压缩
        return data;
    }else{
        if (length > maxImageLength && length < 500) {
            data = UIImageJPEGRepresentation(self, 0.6);
        }else if (length > 500 && length < 1000) {
            data = UIImageJPEGRepresentation(self, 0.5);
        }else if (length > 1000 && length < 1500){
            data = UIImageJPEGRepresentation(self, 0.3);
        }else if (length > 1500 && length < 2000){
            data = UIImageJPEGRepresentation(self, 0.1);
        }
    }
    return data;
}

@end
