//
//  ZViewController.m
//  ZCamera
//
//  Created by zhuayi on 09/10/2015.
//  Copyright (c) 2015 zhuayi. All rights reserved.
//

#import "ZViewController.h"
#import "ZCameraViewManager.h"

@interface ZViewController ()<ZCameraViewDelegate>

@end

@implementation ZViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UIButton *button2 = [[UIButton alloc] initWithFrame:CGRectMake(30, 200, 100, 30)];
    button2.backgroundColor = [UIColor redColor];
    [button2 setTitle:@"多选拍照" forState:UIControlStateNormal];
    [self.view addSubview:button2];
    [button2 addTarget:self action:@selector(gotoCamera) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *button3 = [[UIButton alloc] initWithFrame:CGRectMake(30, 300, 100, 30)];
    button3.backgroundColor = [UIColor redColor];
    [button3 setTitle:@"打开图库" forState:UIControlStateNormal];
    [self.view addSubview:button3];
    [button3 addTarget:self action:@selector(goToPhotoLibrary) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(200, 200, 100, 30)];
    button.backgroundColor = [UIColor redColor];
    [button setTitle:@"单选拍照" forState:UIControlStateNormal];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(gotoCamera2) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)gotoCamera {
    
    ZCameraViewManager *camera = [[ZCameraViewManager alloc] init];
    //    camera.allowsEditing = YES;
    //    camera.multiple = NO;
    camera.delegate = self;
    camera.maximum = 9;
    camera.threshold = 7;
    [camera show];
}

- (void)goToPhotoLibrary {
    
    ZCameraViewManager *camera = [[ZCameraViewManager alloc] init];
    camera.delegate = self;
    camera.maximum = 9;
    camera.threshold = 7;
    camera.allowsEditing = YES;
    [camera goToPhotoLibrary];
}

- (void)gotoCamera2 {
    
    ZCameraViewManager *camera = [[ZCameraViewManager alloc] init];
        camera.allowsEditing = YES;
        camera.multiple = NO;
    camera.delegate = self;
//    camera.maximum = 9;
//    camera.threshold = 7;
    [camera show];
}

#pragma mark - CameraDelegate

/**
 *  发送图片
 *
 *  @param dict
 */
- (void)didSendPhotoWithImageArray:(NSArray *)dict {
    
    [ZCameraViewManager getImageFullScreenWithArray:dict imageArray:^(NSArray *imageArray) {
        
        NSLog(@"imageArray is %@", imageArray);
        
    }];
    
}


- (void)didSendPhotoWidthImage:(UIImage *)image {
    
    NSLog(@"image %@", image);
}

- (void)didPhotoLibraryUnavailable {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"相机不可用"
                                                    message:@"设置 -> 隐私 -> 打开相机"
                                                   delegate:nil
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil, nil];
    
    [alert show];
    
}

- (void)didSendPhotoWithImageArray {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"图库不可用"
                                                    message:@"设置 -> 隐私 -> 打开图库"
                                                   delegate:nil
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil, nil];
    
    [alert show];
    
}

- (void)didCameraUnavailable {
    
}

- (void)didDismissViewController {
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
