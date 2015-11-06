//
//  CameraImagePickerViewController.m
//  IOSLib
//
//  Created by zhuayi on 7/30/15.
//  Copyright (c) 2015 zhuayi. All rights reserved.
//

#import "ZCameraImagePickerViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <MobileCoreServices/UTCoreTypes.h>

@implementation ZCameraImagePickerViewController {
    
    UIActivityIndicatorView *_activity;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.delegate = self;
        self.allowsEditing = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    _activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    _activity.frame = CGRectMake(140, 80, 30, 30);
    _activity.center = self.view.center;
    [self.view addSubview:_activity];
    
    
}

/**
 *  检查相机是否可用
 */
- (BOOL)checkCameraAvailable {
    
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied) {
        return NO;
    }
    
    return YES;
}



#pragma mark -UIImagePickerControllerDelegate
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [self dismissViewControllerAnimated:YES completion:^{
        
        [_cameraDelegate didDismissViewController];
        
    }];
}


/**
 *  完成拍照
 *
 *  @param picker
 *  @param info
 */
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    NSString *mediaType=[info objectForKey:UIImagePickerControllerMediaType];
 
    NSURL *mediaUrl = [info objectForKey:UIImagePickerControllerMediaURL];
    
    [_activity startAnimating];

    NSLog(@"info : %@", info);
    // 视频
    if ([mediaType isEqualToString:(NSString *)kUTTypeMovie]) {
        
        [self video:picker videoUrl:mediaUrl];
        
    } else if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        
        UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
        if (image == nil) {
            
            image = [info objectForKey:UIImagePickerControllerOriginalImage];
        }
        [_cameraDelegate didSendPhotoWidthImage:image];
        [_activity stopAnimating];
        [self dismissViewControllerAnimated:YES completion:^{}];
    }
    
}

- (void)video:(UIImagePickerController *)picker videoUrl:(NSURL *)videoUrl {
    
    [_activity stopAnimating];
    [_cameraDelegate didSendVideoUrl:videoUrl];
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    
    if (!error) {
        
        [_cameraDelegate didSendPhotoWidthImage:image];
        
        NSLog(@"OK");
    } else {
        
        NSLog(@"Error: %@", error);
    }
}

- (void)dealloc {
    NSLog(@"%s", __func__);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
