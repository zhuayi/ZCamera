//
//  PhotoCollectionViewCell.m
//  IOSLib
//
//  Created by zhuayi on 7/30/15.
//  Copyright (c) 2015 zhuayi. All rights reserved.
//



#import "ZPhotoCollectionViewCell.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "UIImage+MWPhotoBrowser.h"
#import "ZMacro.h"
@implementation ZPhotoCollectionViewCell {

    UIButton * _selectButton;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        if (_imageView == nil) {
            
            _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
            [self addSubview:_imageView];
        }
        
        if (_selectButton == nil) {
            
            _selectButton = [[UIButton alloc] initWithFrame:CGRectMake(frame.size.width - AutoSize(22), AutoSize(2), AutoSize(20), AutoSize(20))];
            [_selectButton setBackgroundImage:[UIImage imageForResourcePath:@"CameraSelect" ofType:@".png" inBundle:[NSBundle bundleWithIdentifier:@"ZCamera"]] forState:UIControlStateNormal];
            [_selectButton setBackgroundImage:[UIImage imageForResourcePath:@"CameraSelectHigh" ofType:@".png" inBundle:[NSBundle bundleWithIdentifier:@"ZCamera"]] forState:UIControlStateSelected];
            [self addSubview:_selectButton];
            
            [_selectButton addTarget:self action:@selector(setSelect:) forControlEvents:UIControlEventTouchUpInside];
        }
   
    }
    return self;
}

- (void)setSelect:(UIButton *)sender {
    NSLog(@"我被选中了");
    
//    self.selected = sender.selected;
    _imageModel.selected = !sender.selected;
    sender.selected = _imageModel.selected;
    [_delegete didSelectCellWithAtSelectButton:_imageModel button:sender];
    
}

- (void)setImageModel:(ZCameraImageModel *)imageModel {
    
    _imageModel = imageModel;
    _selectButton.selected = _imageModel.selected;
//     _imageView.image = [UIImage imageWithCGImage:imageModel.thumbnail];
    ALAssetsLibrary *assetLibrary = [[ALAssetsLibrary alloc] init];
    [assetLibrary assetForURL:_imageModel.imageUrl resultBlock:^(ALAsset *asset)  {
        _imageView.image = [UIImage imageWithCGImage:asset.thumbnail];
        
    }failureBlock:^(NSError *error) {
        
    }];
}



@end
