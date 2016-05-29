//
//  PHScrollView.m
//  PHFinancial
//
//  Created by 匡 on 16/5/27.
//  Copyright © 2016年 PuHuiFinancial. All rights reserved.
//

#import "PHScrollView.h"

@implementation PHScrollView
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        self.minimumZoomScale = 1.0;
        self.maximumZoomScale = 3.0;
        self.backgroundColor = [UIColor blackColor];
        self.delegate = self;
        [self setZoomScale:1];
        self.scrollEnabled = YES;
        _fullImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavBar)];
        // 成比例的放大模式  使得当放大时候_fullImageView可以放大到跟屏幕一样大，但是图片的高度只随宽度变大的比例来变大
        _fullImageView.contentMode = UIViewContentModeScaleAspectFit;
        _fullImageView.backgroundColor = [UIColor clearColor];
        [self addSubview:_fullImageView];
        _fullImageView.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        
        UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap:)];
        // 次数（单击、双击）
        doubleTap.numberOfTapsRequired = 2;
        // 触摸数量（手指头的数量）
        //doubleTap.numberOfTouchesRequired = 2;
        [_fullImageView addGestureRecognizer:doubleTap];
        // 当双击时，单击失效
        [singleTap requireGestureRecognizerToFail:doubleTap];
        [_fullImageView addGestureRecognizer:singleTap];
    }
    return self;
}

- (UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return _fullImageView;
}

- (void)tapAction:(UITapGestureRecognizer *)tap {
    [UIView animateWithDuration:0.3 animations:^{
        [self setZoomScale:1.5];
  
    }];
}

- (void)doubleTap:(UITapGestureRecognizer *)tap {
    [UIView animateWithDuration:0.3 animations:^{
        [self setZoomScale:1];
    }];
}
@end
