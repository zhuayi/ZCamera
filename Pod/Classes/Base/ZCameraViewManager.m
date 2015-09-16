//
//  CameraViewController.m
//  IOSLib
//
//  Created by zhuayi on 7/30/15.
//  Copyright (c) 2015 zhuayi. All rights reserved.
//

#import "ZCameraViewManager.h"
#import "ZCameraImagePickerViewController.h"
#import "ZPhotoCollectionViewController.h"
#import "ZCameraImageModel.h"
#import "ZMacro.h"
#import "UIView+Util.h"
#import "UIImage+MWPhotoBrowser.h"

@implementation ZCameraViewManager {
    
    UIView *_controllerView;
    NSArray *_buttonArray;
    NSMutableDictionary *_selectPhotoDict;
    
    UIViewController *_rootViewController;
}


static NSMutableArray *selectImageArray;

/**
 *  递归循环 key
 */
static int forKey = 0;

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        
        UITapGestureRecognizer*tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissViewControllerAnimated)];
        [self addGestureRecognizer:tapGesture];
        
        _buttonArray = @[
                         @{
                             @"title": @"拍照",
                             @"selector": @"goToCameraView"
                             },
                         @{
                             @"title": @"选择相册",
                             @"selector": @"goToPhotoLibrary"
                             },
                         @{
                             @"title": @"取消",
                             @"selector": @"dismissViewControllerAnimated"
                             },
                         ];
        
        
        if (_controllerView == nil) {
            
            _controllerView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, AutoSize(150))];
            _controllerView.backgroundColor = UIColorFromRGB(0xeeeeee);
            [self addSubview:_controllerView];
            
            UIImageView *buttonView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, AutoSize(150))];
            buttonView.image = [UIImage imageNamed:@"CameraBg"];
            buttonView.userInteractionEnabled = YES;
            [_controllerView addSubview:buttonView];
            
            int i = 0;
            for (NSDictionary *dict in _buttonArray) {
                
                UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, AutoSize(50) * i, SCREEN_WIDTH, AutoSize(50))];
                button.tag = i;
                [button setTitle:[dict objectForKey:@"title"] forState:UIControlStateNormal];
                [button setTitleColor:UIColorFromRGB(0x535353) forState:UIControlStateNormal];
                button.titleLabel.font = [UIFont systemFontOfSize:AutoSize(15)];
                [button addTarget:self action:@selector(controllerButtonClick:) forControlEvents:UIControlEventTouchUpInside];
                [buttonView addSubview:button];
                i++;
                if (i == _buttonArray.count) {
                    button.top += 5;
                }
            }
        }
        
        
        _rootViewController = [[[UIApplication sharedApplication] keyWindow] rootViewController];
        
        // 默认多选
        self.multiple = YES;
        
    }
    return self;
}



- (void)dismissViewControllerAnimated {
    
    [UIView animateWithDuration:0.2 animations:^{
        
        _controllerView.top = SCREEN_HEIGHT;
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        
        // 释放单例
        [_delegate didDismissViewController];
        
    }];
    
    
}

- (void)controllerButtonClick: (UIButton *)sender {
    
    NSDictionary *dict = _buttonArray[sender.tag];
    NSString *selectorStrings = [dict objectForKey:@"selector"];
    if (selectorStrings.length == 0) {
        return;
    }
    SEL selector = NSSelectorFromString(selectorStrings);
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    [self performSelector:selector withObject:nil];
#pragma clang diagnostic pop
    
}

/**
 *  显示
 */
- (void)show {
    
    [_rootViewController.view addSubview:self];
    
    [UIView animateWithDuration:0.2 animations:^{
        
        _controllerView.top = SCREEN_HEIGHT - _controllerView.height;
        
    } completion:^(BOOL finished) {
        
    }];
    
}

- (void)goToCameraView {
    
    [self goToCameraView:_allowsEditing sourceType:UIImagePickerControllerSourceTypeCamera];
}

- (void)goToCameraView:(BOOL)allowsEditing sourceType:(UIImagePickerControllerSourceType)sourceType {
    
    if (![UIImagePickerController isSourceTypeAvailable:sourceType]) {
        NSLog(@"相机不可用!");
        
        if (sourceType == UIImagePickerControllerSourceTypePhotoLibrary) {
            [_delegate didPhotoLibraryUnavailable];
        } else {
            [_delegate didCameraUnavailable];
        }
        
        return;
    }
    ZCameraImagePickerViewController * cameraImagePicker = [[ZCameraImagePickerViewController alloc] init];
    cameraImagePicker.cameraDelegate = _delegate;
    cameraImagePicker.allowsEditing = allowsEditing;
    cameraImagePicker.sourceType = sourceType;
    
    [UIView animateWithDuration:0.2 animations:^{
        
        _controllerView.top = SCREEN_HEIGHT;
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        [_rootViewController presentViewController:cameraImagePicker animated:YES completion:nil];
        
    }];
}

- (void)goToPhotoLibrary {
    
    if (self.multiple) {
        
        ZPhotoCollectionViewController *photoCollection = [[ZPhotoCollectionViewController alloc] init];
        photoCollection.delegate = _delegate;
        photoCollection.threshold = self.threshold;
        photoCollection.maximum = self.maximum;
        if (![photoCollection checkPhotosAlbumAvailable]) {
            NSLog(@"相册不可用!");
            [_delegate didCameraUnavailable];
            return;
        }
        
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:photoCollection];
        
        [UIView animateWithDuration:0.2 animations:^{
            
            _controllerView.top = SCREEN_HEIGHT;
            
        } completion:^(BOOL finished) {
            
            [self removeFromSuperview];
            
            [_rootViewController presentViewController:nav animated:YES completion:nil];
        }];
    } else {
        
        [self goToCameraView:_allowsEditing sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    }
}

/**
 *  根据 assets-url 获取图片缩略图
 *
 *  @param imageOriginalArray
 *  @param imageArray
 */
+ (void)getImageThumbnailWithArray:(NSArray *)imageOriginalArray imageArray:(ImageBlock)imageArray {
    
    [ZCameraViewManager getImageArrayWithArray:imageOriginalArray type:@"thumbnail" imageArray:imageArray];
}

/**
 *  根据 assets-url 获取图片全屏图
 *
 *  @param imageOriginalArray
 *  @param imageArray
 */
+ (void)getImageAspectRatioThumbnaillWithArray:(NSArray *)imageOriginalArray imageArray:(ImageBlock)imageArray {
    
    [ZCameraViewManager getImageArrayWithArray:imageOriginalArray type:@"aspectRatioThumbnail" imageArray:imageArray];
}

/**
 *  根据 assets-url 获取图片原图
 *
 *  @param imageOriginalArray
 *  @param imageArray
 */
+ (void)getImageFullScreenWithArray:(NSArray *)imageOriginalArray imageArray:(ImageBlock)imageArray {
    
    [ZCameraViewManager getImageArrayWithArray:imageOriginalArray type:@"fullImage" imageArray:imageArray];
}

/**
 *  图片转换
 *
 *  @param imageOriginalArray
 *  @param type
 *  @param imageArray
 */
+ (void)getImageArrayWithArray:(NSArray *)imageOriginalArray type:(NSString *)type imageArray:(ImageBlock)imageArray {
    
    if (selectImageArray == nil) {
        
        selectImageArray = [NSMutableArray new];
    }
    
    ALAssetsLibrary *assetLibrary = [[ALAssetsLibrary alloc] init];
    
    //    __block int key2 = key;
    [assetLibrary assetForURL:imageOriginalArray[forKey] resultBlock:^(ALAsset *asset)  {
        
        //fullScreenImage
        //        [asset respondsToSelector:@selector(type)];
        
        if ([type isEqualToString:@"fullImage"]) {
            
            [selectImageArray addObject:[UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage]];
            
        } else {
            
            SEL selector = NSSelectorFromString(type);
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            CGImageRef imageRef = (__bridge CGImageRef)([asset performSelector:selector]);
#pragma clang diagnostic pop
            [selectImageArray addObject:[UIImage imageWithCGImage:imageRef]];
        }
        
        
        forKey++;
        
        if (forKey < imageOriginalArray.count) {
            
            [self getImageArrayWithArray:imageOriginalArray type:type imageArray:imageArray];
            
        } else {
            
            imageArray(selectImageArray);
            [selectImageArray removeAllObjects];
            forKey = 0;
        }
        
        
    }failureBlock:^(NSError *error) {
        
        imageArray(selectImageArray);
        [selectImageArray removeAllObjects];
        forKey = 0;
        
    }];
}

- (void)dealloc {
    
    NSLog(@"%s", __func__);
}


@end
