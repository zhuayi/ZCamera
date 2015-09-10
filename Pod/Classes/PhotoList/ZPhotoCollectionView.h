//
//  PhotoAlubmView.h
//  IOSLib
//
//  Created by zhuayi on 7/30/15.
//  Copyright (c) 2015 zhuayi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZCameraDelegate.h"

@interface ZPhotoCollectionView : UICollectionView<UICollectionViewDataSource,UICollectionViewDelegate,UINavigationControllerDelegate>


- (instancetype)initWithFrame:(CGRect)frame scrollDirection:(UICollectionViewScrollDirection)scrollDirection;

@property (nonatomic, strong) NSMutableArray *photoArray;

@property (nonatomic, weak) id<PhotoViewCellDelegate> photoDelegete;

@end
