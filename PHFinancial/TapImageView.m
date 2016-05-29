//
//  TapImageView.m
//  PHFinancial
//
//  Created by 匡 on 16/5/27.
//  Copyright © 2016年 PuHuiFinancial. All rights reserved.
//

#import "TapImageView.h"
#import "ImageDetailViewController.h"
@implementation TapImageView
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage:)];
        [self addGestureRecognizer:tap];
        _images = [NSMutableArray array];
        self.userInteractionEnabled = YES;
        self.contentMode = UIViewContentModeScaleAspectFill;
    }
    return self;
}

- (void)tapImage:(UITapGestureRecognizer *)tap{
    ImageDetailViewController *vc = [[ImageDetailViewController alloc] init];
    vc.datalist = _images;
    vc.index = self.tag - 300;
    [self.vc presentViewController:vc animated:YES completion:^{
        
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
