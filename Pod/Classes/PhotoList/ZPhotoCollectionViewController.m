//
//  PhotoCollectionViewController.m
//  IOSLib
//
//  Created by zhuayi on 7/30/15.
//  Copyright (c) 2015 zhuayi. All rights reserved.
//

#import "ZPhotoCollectionViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "ZCameraPhotoBrowserViewController.h"
#import "ZCameraImageModel.h"
#import "MBProgressHUD.h"
#import "ZMacro.h"
#import "UIView+Util.h"

@implementation ZPhotoCollectionViewController {
    
    ZPhotoCollectionView *_photoAlbumView;
    
    UIView *_footView;
    
    // 发送按钮
    UIButton *_sendButton;
    
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.rightButton.title = @"取消";
    
    self.view.backgroundColor = UIColorFromRGB(0xf3f3f3);
    
    [self footView];
    
    _photoAlbumView = [[ZPhotoCollectionView alloc] initWithFrame:CGRectMake(0, 5, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - _footView.height - 5) scrollDirection:UICollectionViewScrollDirectionVertical];
    //    _photoAlbumView.delegate = self;
    _photoAlbumView.photoDelegete = self;
    [self.view addSubview:_photoAlbumView];
    [self.view bringSubviewToFront:_footView];
    
}

/**
 *  检查图库是否可用
 */
- (BOOL)checkPhotoLibraryAvailable {
    //检查相机模式是否可用
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        NSLog(@"sorry, PhotoLibrary is unavailable.");
        return NO;
    }
    return YES;
}

/**
 *  检查相册是否可用
 */
- (BOOL)checkPhotosAlbumAvailable {
    //检查相机模式是否可用
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]) {
        NSLog(@"sorry, PhotoLibrary is unavailable.");
        return NO;
    }
    
    return YES;
}


- (NSMutableDictionary *)selectPhotoDict {
    
    if (_selectPhotoDict == nil) {
        
        _selectPhotoDict = [NSMutableDictionary new];
    }
    
    return _selectPhotoDict;
}


- (void)footView {
    
    _footView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 64 - 50, SCREEN_WIDTH, 50)];
    _footView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_footView];
    
    _sendButton = [[UIButton alloc] initWithFrame:CGRectMake(_footView.width - 240, 0, 230, 50)];
    _sendButton.titleLabel.font = [UIFont systemFontOfSize:15.0];
    _sendButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [_sendButton setTitleColor:UIColorFromRGB(0x27b9e8) forState:UIControlStateNormal];
    [_sendButton setTitle:[NSString stringWithFormat:@"上传（%ld/%ld）张", (long)_threshold, (long)_maximum] forState:UIControlStateNormal];
    [_sendButton addTarget:self action:@selector(sendPhoto) forControlEvents:UIControlEventTouchUpInside];
    [_footView addSubview:_sendButton];
    
}

/**
 *  取消按钮
 */
- (void)rightButtonAction {
    
    [self goBack];
    
}


/**
 *  发送照片
 */
- (void)sendPhoto {
    
    [self dismissViewControllerAnimated:YES completion:^{
        [_delegate didSendPhotoWithImageArray:[_selectPhotoDict allKeys]];
    }];
}


#pragma mark - PhotoViewCellDelegate

/**
 *  选中图标选中 button
 *
 *  @param imageModel
 */
- (void)didSelectCellWithAtSelectButton:(ZCameraImageModel *)imageModel button:(UIButton *)button {
    
    if (imageModel.selected) {
        
        [self.selectPhotoDict setObject:imageModel forKey:imageModel.imageUrl];
    } else {
        
        [self.selectPhotoDict removeObjectForKey:imageModel.imageUrl];
    }
    
    NSInteger maxNum = self.selectPhotoDict.count + (long)_threshold;
    if (maxNum > _maximum) {
        
        NSLog(@"大于了");
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = [NSString stringWithFormat:@"选择的照片不能超过%ld张", (long)_maximum];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
        });
        [self.selectPhotoDict removeObjectForKey:imageModel.imageUrl];
        
        button.selected = NO;
        return;
    }
    
    NSString *buttonStr = [NSString stringWithFormat:@"上传（%ld/%ld）张", (long)maxNum, (long)_maximum];
    [_sendButton setTitle:buttonStr forState:UIControlStateNormal];
}

/**
 *  选中图片 cell
 *
 *  @param indexPath
 */
- (void)didSelectCellWithAtIndexPath:(NSIndexPath *)indexPath {
    
    ZCameraPhotoBrowserViewController *photoView = [[ZCameraPhotoBrowserViewController alloc] init];
    photoView.photoArray = _photoAlbumView.photoArray;
    photoView.index = indexPath.row;
    [self.navigationController pushViewController:photoView animated:YES];
}


- (void)goBack {
    
    [self dismissViewControllerAnimated:YES completion:^{
        [_delegate didDismissViewController];
    }];
}


- (void)dealloc {
    
    self.selectPhotoDict = nil;
    NSLog(@"%s", __func__);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
