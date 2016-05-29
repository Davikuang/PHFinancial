//
//  MyTextField.m
//  equdao
//
//  Created by 匡 on 15/12/30.
//  Copyright © 2015年 boroo.me. All rights reserved.
//

#import "MyTextField.h"

@implementation MyTextField
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _customView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
        _customView.backgroundColor = [UIColor whiteColor];
        self.inputAccessoryView = _customView; // 往自定义view中添加各种UI控件(以UIButton为例)
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - 50, 5, 40, 30)];
        
        [btn setTitle:@"完成" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [btn addTarget:self action:@selector(closeBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_customView addSubview:btn];
    }
    return self;
}
- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        _customView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
        _customView.backgroundColor = [UIColor whiteColor];
        self.inputAccessoryView = _customView; // 往自定义view中添加各种UI控件(以UIButton为例)
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - 50, 5, 40, 30)];
        
        [btn setTitle:@"关闭" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [btn addTarget:self action:@selector(closeBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_customView addSubview:btn];
    }
    return self;
}

- (void)closeBtn:(UIButton *)sender {
    NSLog(@"关闭键盘");
    [self resignFirstResponder];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
