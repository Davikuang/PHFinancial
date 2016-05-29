//
//  WPAutoSpringTextViewController.m
//  wespy
//
//  Created by ZhuGuangwen on 15/10/10.
//  Copyright © 2015年 wepie. All rights reserved.
//

#import "WPAutoSpringTextViewController.h"
#import "UIResponder+FirstResponder.h"

#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@implementation WPAutoSpringTextViewController{
    BOOL keyboardIsShowing;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    // 注册观察者
    [self enableEditTextScroll];
    self.view.userInteractionEnabled = YES;
//    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewClicked)]];
}

- (void)viewClicked{
    // 点击 键盘退出
    if(keyboardIsShowing){
        id responder = [UIResponder currentFirstResponder];
        if([responder isKindOfClass:[UITextView class]] || [responder isKindOfClass:[UITextField class]]){
            UIView *view = responder;
            [view resignFirstResponder];
        }
    }
    
}

- (CGFloat)shouldScrollWithKeyboardHeight:(CGFloat)keyboardHeight{
    // respoder 是当前的TextView
    id responder = [UIResponder currentFirstResponder];
    if([responder isKindOfClass:[UITextView class]] || [responder isKindOfClass:[UITextField class]]){
        UIView *view = responder;
        // 获得textView的 
        CGFloat y = [responder convertPoint:CGPointZero toView:[UIApplication sharedApplication].keyWindow].y;
        // y值  加上 textView的高度   bottom
        CGFloat bottom = y + view.frame.size.height;
        NSLog(@"shouldScrollWithKeyboardHeight -->keyboradHeight %@, keyboradBottom %@, viewY %@, bottom %@", @(keyboardHeight), @(SCREEN_HEIGHT - keyboardHeight), @(y), @(bottom));
        // 确保textView 以及键盘在同一个视图窗口内  不会溢出
        if(bottom > SCREEN_HEIGHT - keyboardHeight){
            return bottom - (SCREEN_HEIGHT - keyboardHeight);
        }
    }
    return 0;
}

- (void)enableEditTextScroll{
    // keyboard 将要弹出
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(wpKeyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    // keyboard 将要隐藏
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(wpKeyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    // keyboard 已经显示
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(wpKeyboardDidShow) name:UIKeyboardDidShowNotification object:nil];
    // keyboard 已经隐藏
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(wpKeyboardDidHide) name:UIKeyboardDidHideNotification object:nil];
}

- (void)wpKeyboardDidShow{
    keyboardIsShowing = YES;
}

- (void)wpKeyboardDidHide{
    keyboardIsShowing = NO;
}

- (void)wpKeyboardWillHide:(NSNotification *)note {
    // 获取将要隐藏的时间
    float duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    __weak WPAutoSpringTextViewController *weakSelf = self;
    [UIView animateWithDuration:duration animations:^{
        CGRect bounds = weakSelf.view.bounds;
        weakSelf.view.bounds = CGRectMake(0, 0, bounds.size.width, bounds.size.height);
    }];
}

- (void)wpKeyboardWillShow:(NSNotification *)note {
    float duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    // 获取键盘本身高度
    CGFloat keyboardHeight = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    // 将要滚动的高度
    CGFloat shouldScrollHeight = [self shouldScrollWithKeyboardHeight:keyboardHeight];
    if(shouldScrollHeight == 0){
        return;
    }
    // 当前控制器  滚动到指定高度 改变View的整体高度
    __weak WPAutoSpringTextViewController *weakSelf = self;
    [UIView animateWithDuration:duration animations:^{
        CGRect bounds = weakSelf.view.bounds;
        weakSelf.view.bounds = CGRectMake(0, shouldScrollHeight + 10, bounds.size.width, bounds.size.height);
    }];
}

@end
