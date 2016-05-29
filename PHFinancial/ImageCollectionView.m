//
//  ImageCollectionView.m
//  equdao
//
//  Created by 匡 on 16/5/3.
//  Copyright © 2016年 boroo.me. All rights reserved.
//
#import "UIViewExt.h"
#import "ImageItem.h"
#import "ImageCollectionView.h"
#import "DJCameraViewController.h"
static NSString *CellIdentifier = @"CollectionCellIdentifier";
@interface ImageCollectionView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@end
@implementation ImageCollectionView

- (id)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        
        self.dataSource = self;
        self.delegate = self;
        
        [self registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:CellIdentifier];
        self.backgroundView.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _datalist.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, cell.width -10, cell.height -10)];
    imageView.userInteractionEnabled = YES;

//    imageView.image = _datalist[indexPath.row];
    imageView.backgroundColor = [UIColor redColor];
    [cell.contentView addSubview:imageView];
    cell.backgroundColor = [UIColor whiteColor];
    
    return cell;
}

//定义每个Item 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((kScreenWidth - 20)/4,(kScreenWidth - 20)/4);
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_datalist.count) {
        ImageItem *item = _datalist[indexPath.row];
        if (item.isPleaseHolder == YES) {
            // 正常照片  没有点击事件
            NSLog(@"点击了Image");
            return;
        }else{
            // 添加点击添加照片事件
            // 当改变行数的时候  相对页面也要发生改变
            NSLog(@"点击了Image");

        }
        
        DJCameraViewController *VC = [DJCameraViewController new];
        
        [self.pTVC presentViewController:VC animated:YES completion:nil];

    }
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}


@end
