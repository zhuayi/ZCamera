//
//  PhotoAlubmView.m
//  IOSLib
//
//  Created by zhuayi on 7/30/15.
//  Copyright (c) 2015 zhuayi. All rights reserved.
//

#import "ZPhotoCollectionView.h"
#import "ZPhotoCollectionViewCell.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "ZMacro.h"
#import "ZCameraImageModel.h"

@implementation ZPhotoCollectionView


static NSString * const reuseIdentifier = @"Cell";

- (instancetype)initWithFrame:(CGRect)frame scrollDirection:(UICollectionViewScrollDirection)scrollDirection {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = 5;
    layout.minimumLineSpacing = 5;
    
    if (scrollDirection == UICollectionViewScrollDirectionHorizontal) {
        layout.itemSize = CGSizeMake(AutoSize(107), AutoSize(190));
    } else {
        layout.itemSize = CGSizeMake(AutoSize(73), AutoSize(73));
    }
    
    [layout setScrollDirection:scrollDirection];
    
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        
        [self registerClass:[ZPhotoCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = [UIColor colorWithRed:246.0 / 255 green:247.0 / 255 blue:249.0 / 255 alpha:1];
        
        [self getPhotoArray];
        
    }
    return self;
}

- (NSMutableArray *)photoArray {
    
    if (_photoArray == nil) {
        _photoArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
    
    return _photoArray;
}

- (void)getPhotoArray {
    
    // 生成整个photolibrary句柄的实例
    ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc] init];
    [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {//获取所有group
        
        if (group != nil) {
            [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {//从group里面
                NSString* assetType = [result valueForProperty:ALAssetPropertyType];
                if ([assetType isEqualToString:ALAssetTypePhoto]) {

                    ZCameraImageModel *imageModel = [[ZCameraImageModel alloc] init];
                    imageModel.imageUrl = result.defaultRepresentation.url;
                    [self.photoArray addObject:imageModel];
                }
            }];
        } else {
            
            [self reloadData];
            
            // 滚动到底部
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:(self.photoArray.count - 1) inSection:0]
                                        atScrollPosition:UICollectionViewScrollPositionBottom animated:NO];
            });
        }
        
    } failureBlock:^(NSError *error) {
        NSLog(@"Enumerate the asset groups failed.");
    }];
}


#pragma mark- Source Delegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _photoArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZPhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.imageModel = _photoArray[indexPath.row];
    cell.delegete = _photoDelegete;
    return cell;
}

#pragma mark -collectionViewDelegate

/**
 *  定义每个UICollectionView 的 margin
 *
 *  @param collectionView
 *  @param collectionViewLayout
 *  @param section
 *
 *  @return
 */
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 5, 0, 5);
}

/**
 *  UICollectionView被选中时调用的方法
 *
 *  @param collectionView
 *  @param indexPath
 */
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {    
        [_photoDelegete didSelectCellWithAtIndexPath:indexPath];
}

/**
 *  返回这个UICollectionView是否可以被选择
 *
 *  @param collectionView
 *  @param indexPath
 *
 *  @return
 */
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}



- (void)dealloc {
    NSLog(@"%s", __func__);
}

@end
