//
//  BaseViewController.m
//  equdao
//
//  Created by 匡 on 15/8/4.
//  Copyright (c) 2015年 boroo.me. All rights reserved.
//

#import "BaseViewController.h"
@interface BaseViewController ()
{
    UILabel *_titleLable;
    UIImageView *_contentLineImageView;
}
@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.navigationController.viewControllers.count >= 2) {
        
        [self _initNaviButton];
    }
    
    self.navigationController.navigationBar.translucent = NO;
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                     [UIColor whiteColor], UITextAttributeTextColor,
                                                                     [UIColor whiteColor], UITextAttributeTextShadowColor,
                                                                     [NSValue valueWithUIOffset:UIOffsetMake(0, 0)], UITextAttributeTextShadowOffset,
                                                                     [UIFont systemFontOfSize:17], UITextAttributeFont,
                                                                     nil]];
    
    

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
}


#pragma mark -- 递归取出下面的line
- (UIImageView*)findHairlineImageunder:(UIView *)view {
    if ([view isKindOfClass:[UIImageView class]] && view.size.height <= 1) {
        return (UIImageView*)view;
    }
    for (UIView *subView in view.subviews) {
        
        UIImageView *imageView = [self findHairlineImageunder:subView];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}



//点击事件
- (void)leftButtonAction:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}




- (void)rightButtonAction:(UIButton *)sender {

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 导航栏返回按钮
- (void)_initNaviButton {
    
    CGRect buttonFrame = CGRectMake(0, 20, 44, 44);
    UIButton *left = [UIButton buttonWithType:UIButtonTypeCustom];
    left.frame = buttonFrame;
   
    [left setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [left addTarget:self action:@selector(leftButtonAction:) forControlEvents:UIControlEventTouchDown];
    [left setImageEdgeInsets:UIEdgeInsetsMake(0, -14, 0, 14)];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:left];
    if (self.navigationController.viewControllers.count == 1) {
        left.hidden = YES;
    }
    self.navigationItem.leftBarButtonItem = leftButton;

}




//创建导航按钮
- (void)_initNaviButton1{
//    CGRect buttonFrame = CGRectMake(20, 30, 100, 44);
//    UIButton *leftButton = [ThemeControl getThemeButtonWithTitleImageName:@"group_btn_all_on_title.png" bgImageName:@"button_title.png" leftCapWidth:50 topCapHeight:0 frame:buttonFrame];
//    [leftButton  setTitle:@"设 置" forState:UIControlStateNormal];
//    leftButton.titleEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
//    leftButton.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
//    
//    //self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
//    [leftButton addTarget:self action:@selector(leftButtonAction1:) forControlEvents:UIControlEventTouchDown];
//    [self.view addSubview:leftButton];
    
    
    
//    CGRect rightButtonFrame = CGRectMake(0, 0, 60, 44);
//    
//    UIButton *rightButton = [ThemeControl getThemeButtonWithTitleImageName: @"button_icon_plus.png"
//                                                               bgImageName:@"button_m.png"
//                                                              leftCapWidth:0
//                                                              topCapHeight:0 frame:rightButtonFrame];
//    // self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
//    [rightButton addTarget:self action:@selector(rightButtonAction:) forControlEvents:UIControlEventTouchDown];
//    [self.view addSubview:rightButton];
}

#pragma mark - 返回按钮
- (void)_initBackItem
{
    CGRect backButton_frame = CGRectMake(0, 0, 75, 44);
    UIButton *backButton =  [UIButton buttonWithType:UIButtonTypeCustom];//
    backButton.frame = backButton_frame;
    
    // 设置标题
    [backButton setTitle:@"返 回" forState:UIControlStateNormal];
    // 修改样式
    //leftButton.titleEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    backButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    // 添加事件
    [backButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
}

#pragma mark - 返回按钮事件
- (void)backAction:(UIButton *)button
{
    // 返回
    [self.navigationController popViewControllerAnimated:YES];
}

// 自定义返回按钮
- (void)_initBackButton {
    
    CGRect buttonFrame = CGRectMake(0, 0, 80, 44);
    UIButton *backButton =  [UIButton buttonWithType:UIButtonTypeCustom];//
    backButton.frame = buttonFrame;
    [backButton setTitle:@"返 回" forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    [backButton addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchDown];
    
}

//

//关闭
- (void)leftButtonAction1:(UIButton *)sender {
    
}


//返回事件
- (void)backButtonAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}



@end
