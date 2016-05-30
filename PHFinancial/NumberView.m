//
//  NumberView.m
//  PHFinancial
//
//  Created by 匡 on 16/5/30.
//  Copyright © 2016年 PuHuiFinancial. All rights reserved.
//

#import "NumberView.h"

@implementation NumberView

- (instancetype)initWithFrame:(CGRect)frame withLabelColor:(UIColor*)color{
    self = [super initWithFrame:frame];
    if (self) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        _scrollView.delegate = self;
        _scrollView.contentSize = CGSizeMake(self.width, 10 * self.height);
        [self addSubview:_scrollView];
        
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        for (int i = 0; i<10; i ++) {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0,i*(self.height), self.width, self.height - 2)];
            label.text = [NSString stringWithFormat:@"%d",i];
            label.textAlignment = 1;
            label.font = [UIFont boldSystemFontOfSize:42];
            label.textColor = [UIColor whiteColor];
            label.backgroundColor = color;
            
            [_scrollView addSubview:label];
        }
        self.backgroundColor = [UIColor whiteColor];
        _scrollView.pagingEnabled = YES;
    }
    return self;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
