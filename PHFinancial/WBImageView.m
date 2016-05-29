//
//  WBImageView.m
//  weibo31
//
//  Created by wxhl31 on 15-3-7.
//  Copyright (c) 2015年 wxhl31. All rights reserved.
//

#import "WBImageView.h"
//#import "ImageViewController.h"
//#import "SDProgressView.h"
@implementation WBImageView 

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // 设置填充模式
//        self.contentMode = UIViewContentModeScaleAspectFit;
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(zoomInImageView)];
        [self addGestureRecognizer:tap];
        
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // 设置填充模式
        self.contentMode = UIViewContentModeScaleAspectFit;
        
        self.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(zoomInImageView)];
        [self addGestureRecognizer:tap];
        
    }
    return self;
}
- (void)zoomInImageView {
    if (self.image == nil) {
        return;
    }
    if (_scorllView == nil) {
        _scorllView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _scorllView.minimumZoomScale = 1.0;
        _scorllView.maximumZoomScale = 1.5;
        _scorllView.delegate = self;
        _scorllView.backgroundColor = [UIColor clearColor];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(zoomOutImageView)];
        [_scorllView addGestureRecognizer:tap];
    }
    // 初始化放大比例
    [_scorllView setZoomScale:1.0];
    // 添加_scoreView到窗口
    [self.window addSubview:_scorllView];
    _scorllView.backgroundColor = [UIColor whiteColor];
    // 创建放大图片
    if (_fullImageView == nil) {
        _fullImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        // 成比例的放大模式  使得当放大时候_fullImageView可以放大到跟屏幕一样大，但是图片的高度只随宽度变大的比例来变大
        _fullImageView.contentMode = UIViewContentModeScaleAspectFit;
        _fullImageView.backgroundColor = [UIColor clearColor];
        [_scorllView addSubview:_fullImageView];
    
    }
    // 把当前对象的位置转化成在UIscoreView的位置
    _fullImageView.frame = [self convertRect:CGRectMake(0, 0,kScreenWidth,kScreenHeight/5) toView:_scorllView];
    // 设置图片
    _fullImageView.image = self.image;
    // 实现动画放大效果
    [UIView animateWithDuration:0.35 animations:^{
        float height = (self.image.size.height / self.image.size.width) * kScreenWidth;
        //_fullImageView可以变得跟屏幕一样大 但图片是随比例变大的 有宽度比例的限制
        _fullImageView.frame = CGRectMake(0,kScreenHeight/8, kScreenWidth, MAX(height,kScreenHeight)/2);
        // 滑动视图变黑
        _scorllView.backgroundColor = [UIColor whiteColor];
        if (height > kScreenHeight) {
            // 可以滑动
            _scorllView.contentSize = CGSizeMake(kScreenWidth, height);
        }
    } completion:^(BOOL finished) {
        // 开始请求高清图片
//        if (self.fullImageUrl != nil) {
//            [_fullImageView sd_setImageWithURL:[NSURL URLWithString:self.fullImageUrl] placeholderImage:self.image options:SDWebImageProgressiveDownload progress:^(NSInteger receivedSize, NSInteger expectedSize) {
//                // 显示加载进度
//                if (_loop == nil) {
//                    _loop = [SDLoopProgressView progressView];
//                    _loop.frame = CGRectMake(50, 100, 100, 100);
//                    _loop.center = CGPointMake(kScreenWidth/2, kScreenHeight/2);
//                }
//                _loop.progress = (float)receivedSize/expectedSize;
//                // 添加到滑动视图上
//                [_scorllView addSubview:_loop];
//            } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//                // 移除slider
//                if (_loop.superview != nil) {
//                    [_loop removeFromSuperview];
//                }
//            }];
//        }
    }];
}
// 点击缩小
- (void)zoomOutImageView {
    if (_slider.subviews != nil) {
        [_slider removeFromSuperview];
    }
    // 01 图片变回原来大小
    // 把当前对象的frame 转化成在UIScrollView的位置
    // 转化
    [UIView animateWithDuration:0.3 animations:^{
        // 虽然_fullImageView已经放大 但是self的大小始终没变
        _fullImageView.frame = [self convertRect:self.bounds toView:_scorllView];
        _scorllView.backgroundColor = [UIColor clearColor];
    } completion:^(BOOL finished) {
        [_scorllView removeFromSuperview];
    }];
}

- (UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return _fullImageView;
}
@end
