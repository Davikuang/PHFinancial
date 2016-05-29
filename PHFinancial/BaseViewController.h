//
//  BaseViewController.h
//  equdao
//
//  Created by 匡 on 15/8/4.
//  Copyright (c) 2015年 boroo.me. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WPAutoSpringTextViewController.h"
@interface BaseViewController : WPAutoSpringTextViewController
- (void)leftButtonAction:(UIButton *)sender;
- (void)rightButtonAction:(UIButton *)sender;
@end
