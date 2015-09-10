//
//  PhotoViewController.h
//  IOSLib
//
//  Created by zhuayi on 7/30/15.
//  Copyright (c) 2015 zhuayi. All rights reserved.
//

#import "MWPhotoBrowser.h"

@interface ZCameraPhotoBrowserViewController : MWPhotoBrowser<MWPhotoBrowserDelegate>



@property (nonatomic, strong) NSArray *photoArray;


@property (nonatomic, assign) NSUInteger index;

@end
