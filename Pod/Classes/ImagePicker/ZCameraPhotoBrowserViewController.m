//
//  PhotoViewController.m
//  IOSLib
//
//  Created by zhuayi on 7/30/15.
//  Copyright (c) 2015 zhuayi. All rights reserved.
//

#import "ZCameraPhotoBrowserViewController.h"
#import "ZCameraImageModel.h"
//#import <AssetsLibrary/AssetsLibrary.h>

@implementation ZCameraPhotoBrowserViewController {
    
    NSMutableArray *_mwPhotoArray;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.delegate = self;
        
        self.displayActionButton = YES; // Show action button to allow sharing, copying, etc (defaults to YES)
        self.displayNavArrows = NO; // Whether to display left and right nav arrows on toolbar (defaults to NO)
        self.displaySelectionButtons = NO; // Whether selection buttons are shown on each image (defaults to NO)
        self.zoomPhotosToFill = YES; // Images that almost fill the screen will be initially zoomed to fill (defaults to YES)
        self.alwaysShowControls = NO; // Allows to control whether the bars and controls are always visible or whether they fade away to show the photo full (defaults to NO)
        self.enableGrid = YES; // Whether to allow the viewing of all the photo thumbnails on a grid (defaults to YES)
        self.startOnGrid = NO; // Whether to start on the grid of thumbnails instead of the first photo (defaults to NO)
        self.autoPlayOnAppear = NO; // Auto-play first video
        
        // Customise selection images to change colours if required
//        self.customImageSelectedIconName = @"ImageSelected.png";
//        self.customImageSelectedSmallIconName = @"ImageSelectedSmall.png";
//        
        _mwPhotoArray = [NSMutableArray new];
    }
    return self;
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
}

- (void)setPhotoArray:(NSArray *)photoArray {
    for (ZCameraImageModel *cameraImageModel in photoArray) {
        
        [_mwPhotoArray addObject:[MWPhoto photoWithURL:cameraImageModel.imageUrl]];
    }
}

- (void)setIndex:(NSUInteger)index {
    [self setCurrentPhotoIndex:index];
}

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return _mwPhotoArray.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    return _mwPhotoArray[index];
}


- (void)dealloc {
    
    NSLog(@"%s", __func__);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
