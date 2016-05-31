//
//  HomeImageView.m
//  equdao
//
//  Created by 匡 on 15/9/6.
//  Copyright (c) 2015年 boroo.me. All rights reserved.
//

#import "HomeImageView.h"

@implementation HomeImageView
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.contentMode = UIViewContentModeScaleToFill;
        _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        self.userInteractionEnabled = YES;
        [self addGestureRecognizer:_tap];
    }
    return self;
}
- (void)tapAction:(UITapGestureRecognizer *)tap {
    NSLog(@"点击了图片");
    if (self.imageDelegate != nil) {
        // 轮播图 点击后链接地址
        
//        [self.imageDelegate homeImageWithUrl:self.linkurl];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
