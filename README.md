# ZCamera

[![CI Status](http://img.shields.io/travis/zhuayi/ZCamera.svg?style=flat)](https://travis-ci.org/zhuayi/ZCamera)
[![Version](https://img.shields.io/cocoapods/v/ZCamera.svg?style=flat)](http://cocoapods.org/pods/ZCamera)
[![License](https://img.shields.io/cocoapods/l/ZCamera.svg?style=flat)](http://cocoapods.org/pods/ZCamera)
[![Platform](https://img.shields.io/cocoapods/p/ZCamera.svg?style=flat)](http://cocoapods.org/pods/ZCamera)

## Usage

ZCamera是一款仿微信的相机和图片选择控件.

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

![enter image description here](https://raw.githubusercontent.com/zhuayi/ZCamera/master/screenshots.gif)

## Example

引入头文件


```objectice-c
#import "ZCameraViewManager.h"
```

```objectice-c
ZCameraViewManager *camera = [[ZCameraViewManager alloc] init];
camera.delegate = self;
[camera show];
```

###可选参数

是否多选, 默认 yes
```objectice-c
@property (nonatomic, assign) BOOL multiple;
```

多选图片最大值
```objectice-c
@property (nonatomic, assign) NSInteger maximum;
```

多选图片时初始值
```objectice-c
@property (nonatomic, assign) NSInteger threshold;
```

是否允许编辑, 单选情况下才生效
```objectice-c
@property (nonatomic, assign) BOOL allowsEditing;
```


##ZCameraViewDelegate

相机不可用时调用
```objectice-c
- (void)didCameraUnavailable;
```

图库不可用时调用
```objectice-c
- (void)didPhotoLibraryUnavailable;
```

取消选择图片时调用
```objectice-c
- (void)didDismissViewController;
```

选取一张拍摄后的照片后调用
```objectice-c
- (void)didSendPhotoWidthImage:(UIImage *)image;
```

从图库中选择N 张图片后调用
```objectice-c
- (void)didSendPhotoWithImageArray:(NSArray *)imageArry;
```

## Installation

ZCamera is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "ZCamera"
```

## Author

zhuayi, 2179942@qq.com

## License

ZCamera is available under the MIT license. See the LICENSE file for more info.
