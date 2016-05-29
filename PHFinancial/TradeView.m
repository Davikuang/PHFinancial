//
//  TradeView.m
//  PHFinancial
//
//  Created by 匡 on 16/5/27.
//  Copyright © 2016年 PuHuiFinancial. All rights reserved.
//

#import "TradeView.h"

@implementation TradeView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *line1 = [[UILabel alloc] initWithFrame:CGRectMake(0,43,self.width, 0.5)];
        line1.backgroundColor = [UIColor grayColor];
        [self addSubview:line1];
        
        UILabel *line2 = [[UILabel alloc] initWithFrame:CGRectMake(0,line1.bottom + 43,self.width, 0.5)];
        line2.backgroundColor = [UIColor grayColor];
        [self addSubview:line2];
        
        UILabel *line3 = [[UILabel alloc] initWithFrame:CGRectMake(0,line2.bottom + 43,self.width, 0.5)];
        line3.backgroundColor = [UIColor grayColor];
        [self addSubview:line3];
        
        UILabel *line4 = [[UILabel alloc] initWithFrame:CGRectMake(0,line3.bottom + 43,self.width, 0.5)];
        line4.backgroundColor = [UIColor grayColor];
        [self addSubview:line4];
        
     
        
        UILabel *line5 = [[UILabel alloc] initWithFrame:CGRectMake(0,line4.bottom + 55,self.width, 0.5)];
        line5.backgroundColor = [UIColor grayColor];
        [self addSubview:line5];
        
        
        MyTextField *tf4 = [[MyTextField alloc] initWithFrame:CGRectMake(self.width/3 + 10,line5.bottom + 40,100, 30)];
        tf4.placeholder = @"请输入金额";
        [self addSubview:tf4];
        
        UILabel *vline = [[UILabel alloc] initWithFrame:CGRectMake(self.width/3, line1.bottom, 0.5, 43*4)];
        vline.backgroundColor = [UIColor grayColor];
        [self addSubview:vline];
        self.backgroundColor = [UIColor whiteColor];
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
