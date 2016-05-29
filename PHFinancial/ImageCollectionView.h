//
//  ImageCollectionView.h
//  equdao
//
//  Created by 匡 on 16/5/3.
//  Copyright © 2016年 boroo.me. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PostTicketViewController.h"
@interface ImageCollectionView : UICollectionView
@property (nonatomic,strong) NSMutableArray *datalist;
@property (nonatomic,strong) PostTicketViewController *pTVC;
@end
