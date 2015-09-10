//
//  CameraImagePickerViewController.h
//  IOSLib
//
//  Created by zhuayi on 7/30/15.
//  Copyright (c) 2015 zhuayi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZCameraDelegate.h"

@interface ZCameraImagePickerViewController : UIImagePickerController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property(nonatomic, weak) id<ZCameraViewDelegate> cameraDelegate;

/**
 *  检查相机是否可用
 */
- (BOOL)checkCameraAvailable;

@end
