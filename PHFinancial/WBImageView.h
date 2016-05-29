//
//  WBImageView.h
//  weibo31
//
//  Created by wxhl31 on 15-3-7.
//  Copyright (c) 2015年 wxhl31. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "SDProgressView.h"
@interface WBImageView : UIImageView<UIScrollViewDelegate>
{
    UIImageView *_fullImageView;
     UISlider *_slider;
//    SDLoopProgressView  *_loop;
}
@property (nonatomic,strong)NSString *urlString;
@property (nonatomic,strong)UIScrollView *scorllView;
@property (nonatomic,strong) NSString *fullImageUrl;
@end
