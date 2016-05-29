//
//  ImageCollectionView.h
//  equdao
//
//  Created by 匡 on 16/5/3.
//  Copyright © 2016年 boroo.me. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DJImageCollectionView : UICollectionView<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong) NSMutableArray *datalist;

@end
