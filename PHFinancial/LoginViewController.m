//
//  LoginViewController.m
//  PHFinancial
//
//  Created by 匡 on 16/5/26.
//  Copyright © 2016年 PuHuiFinancial. All rights reserved.
//

#import "LoginViewController.h"
#import "MyTextField.h"
#import "RegistViewController.h"
@interface LoginViewController ()<UITextFieldDelegate>{
    MyTextField *_phoneTF;
    MyTextField *_passwordTF;
}

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"";
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:0];
    self.navigationController.navigationBar.translucent = YES;
    //    让黑线消失的方法
    self.navigationController.navigationBar.shadowImage=[UIImage new];
    
    [self _initLeftBtn];

    
    
    CGFloat ImageHeight =  1.0 * kScreenWidth / 3 * 2;
    UIImageView *bannerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, ImageHeight)];
    bannerView.image = [UIImage imageNamed:@"login_banner"];
    bannerView.userInteractionEnabled = YES;
    [self.view addSubview:bannerView];
    
    // icon
    UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60*kScaleX, (60+20)*kScaleX)];
    iconView.image = [UIImage imageNamed:@"puhui_icon"];
    iconView.contentMode = UIViewContentModeScaleAspectFit;
    [bannerView addSubview:iconView];
    
    iconView.center = CGPointMake(bannerView.center.x,bannerView.center.y - 30 *kScaleX);
    
    UILabel *iconTitle = [[UILabel alloc] initWithFrame:CGRectMake(iconView.left,iconView.bottom + 10, iconView.width, 20)];
    iconTitle.text = @"普汇金服";
    iconTitle.textColor = [UIColor whiteColor];
    iconTitle.font = [UIFont boldSystemFontOfSize:15*kScaleX];
    iconTitle.backgroundColor = [UIColor clearColor];
    [bannerView addSubview:iconView];
//    [bannerView addSubview:iconTitle];
    
    // 取消按钮
//    UIButton *cancel = [UIButton buttonWithType:UIButtonTypeCustom];
//    cancel.frame = CGRectMake(15, 15, 44, 44);
//    [cancel setImage:[UIImage imageNamed:@"cancel"] forState:UIControlStateNormal];
//    [cancel addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchDown];
//    [self.view addSubview:cancel];
    
    UIView *tfView = [[UIView alloc] initWithFrame:CGRectMake((kScreenWidth - 560/2*kScaleX)/2, 218*kScaleY,560/2*kScaleX, 268/2*kScaleY)];
    UIImageView *tfImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, tfView.width, tfView.height)];
    tfImage.userInteractionEnabled = YES;
    tfImage.image = [UIImage imageNamed:@"loginBgImag"];
    [tfView addSubview:tfImage];
    
    //
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(17*kScaleX, tfView.height/2-0.5, tfView.width - 17*kScaleX*2, 0.5)];
    line.backgroundColor = [UIColor colorWithHexString:@"cbcbcb"];
    [tfView addSubview:line];
    
    [self.view addSubview:tfView];
    
    CGFloat tfgap , imagegap ,phoneImageGap;
    tfgap = 0;
    imagegap = 0;
    phoneImageGap = 0;
    
    if (IS_IPHONE_6) {
        tfgap = 11;
        imagegap = 2;
        
    }
    if (IS_IPHONE_5 || IS_IPHONE_4 ) {
        tfgap = 11;
        imagegap = 3;
        phoneImageGap = 1;
    }
    
    
    
    UIImageView *phoneImage = [[UIImageView alloc] initWithFrame:CGRectMake(17*kScaleX + 4,line.bottom - (16)*kScaleY - 24*kScaleY - phoneImageGap, 14, 24*kScaleY)];
    phoneImage.image = [UIImage imageNamed:@"phone"];
    phoneImage.contentMode = UIViewContentModeScaleAspectFit;
    [tfView addSubview:phoneImage];
    
    _phoneTF = [[MyTextField alloc] initWithFrame:CGRectMake(0, 0,140,25)];
    _phoneTF.font = [UIFont systemFontOfSize:16*kScaleX];
    _phoneTF.placeholder = @"输入手机号";
    _phoneTF.center = CGPointMake(tfView.width/2 + (30 + tfgap)*kScaleX, line.bottom - 15*kScaleX - (25/2)*kScaleY);
    _phoneTF.keyboardType =UIKeyboardTypeNumberPad;
    
    [tfView addSubview:_phoneTF];
    
    UIImageView *passImage = [[UIImageView alloc] initWithFrame:CGRectMake(17*kScaleX + 4,tfView.height - (18 + imagegap) *kScaleY - 24*kScaleY, 14, 24*kScaleY)];
    passImage.image = [UIImage imageNamed:@"lock"];
    passImage.contentMode = UIViewContentModeScaleAspectFit;
    
    _passwordTF = [[MyTextField alloc] initWithFrame:CGRectMake(0, 0,140,25)];
    _passwordTF.font = [UIFont systemFontOfSize:16*kScaleX];
    _passwordTF.placeholder = @"输入密码";
    _passwordTF.center = CGPointMake(tfView.width/2 + (30 + tfgap)*kScaleX, tfView.height - 15*kScaleX - (28/2)*kScaleY);
    [tfView addSubview:_passwordTF];
    
    [tfView addSubview:passImage];
    
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.frame = CGRectMake(tfView.left, tfView.bottom + 96/2*kScaleY, tfView.width,45*kScaleX);
    [loginBtn setBackgroundImage:[UIImage imageNamed:@"redbtn"] forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:loginBtn];
    loginBtn.titleLabel.font = [UIFont systemFontOfSize:16*kScaleX];
    
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    
    UIButton *registBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    registBtn.frame = CGRectMake(tfView.left, loginBtn.bottom + 24*kScaleY, tfView.width,45*kScaleX);
    [registBtn setBackgroundImage:[UIImage imageNamed:@"greenbtn"] forState:UIControlStateNormal];
    [registBtn addTarget:self action:@selector(regist:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:registBtn];
    registBtn.titleLabel.font = [UIFont systemFontOfSize:16*kScaleX];
    [registBtn setTitle:@"注册" forState:UIControlStateNormal];
    
    // 忘记密码
    UIButton *forgetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    forgetBtn.frame = CGRectMake(loginBtn.right - 100, registBtn.bottom + 34/2 * kScaleY, 100, 20);
    
    [forgetBtn addTarget:self action:@selector(forget:) forControlEvents:UIControlEventTouchDown];
    UILabel *forgetLb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, forgetBtn.width, forgetBtn.height)];
    [forgetBtn addSubview:forgetLb];
    forgetLb.font = [UIFont systemFontOfSize:14*kScaleX];
    forgetLb.textColor = [UIColor colorWithHexString:kThemeColor];
    forgetLb.text = @"忘记密码？";
    forgetLb.alpha = 0.8;
    forgetLb.userInteractionEnabled = YES;
    forgetLb.textAlignment = 2;
    forgetLb.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:forgetBtn];
    
    // 底部信息
    UILabel *bottomTitle = [[UILabel alloc] initWithFrame:CGRectMake(((20+11.5) + 18 + 32) * kScaleX, self.view.height - 26, kScreenWidth - 80,20)];
    

    bottomTitle.text = @"普汇金服安全保护用户信息、交易安全";
    bottomTitle.font = [UIFont systemFontOfSize:13*kScaleX];
    bottomTitle.textColor = [UIColor colorWithHexString:@"999999"];
    bottomTitle.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:bottomTitle];
    
    UIImageView *titleIcon = [[UIImageView alloc] initWithFrame:CGRectMake(bottomTitle.left - 20 *kScaleX, bottomTitle.top, 16*kScaleX, 16*kScaleX)];
    
    if (IS_IPHONE_5) {
        titleIcon = [[UIImageView alloc] initWithFrame:CGRectMake(bottomTitle.left - 20 *kScaleX, bottomTitle.top + 3, 16*kScaleX, 16*kScaleX)];
    }
    if (IS_IPHONE_5) {
        titleIcon = [[UIImageView alloc] initWithFrame:CGRectMake(bottomTitle.left - 20 *kScaleX, bottomTitle.top + 3, 16*kScaleX, 16*kScaleX)];
    }

    titleIcon.contentMode = UIViewContentModeScaleAspectFit;
    titleIcon.image = [UIImage imageNamed:@"safe"];
    [self.view addSubview:titleIcon];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = YES;
    
}

// 取消按钮
- (void)_initLeftBtn{
    
    CGRect backButton_frame = CGRectMake(0, 0, 44, 40);
    UIButton *cancel =  [UIButton buttonWithType:UIButtonTypeCustom];//
    cancel.frame = backButton_frame;
    
    // 设置标题
//    [cancel setTitle:@"设置" forState:UIControlStateNormal];
    [cancel setImage:[UIImage imageNamed:@"cancel"] forState:UIControlStateNormal];
    // 修改样式
    //leftButton.titleEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    cancel.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    // 添加事件
    [cancel addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:cancel];
    
}

#pragma mark  注册 登录 找回密码
- (void)login:(UIButton *)sender {
    
}
- (void)regist:(UIButton *)sender {
    RegistViewController *rgVC = [[RegistViewController alloc] init];
    [self.navigationController pushViewController:rgVC animated:YES];
}
- (void)cancelAction:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
//忘记密码
- (void)forget:(UIButton *)sender {
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
