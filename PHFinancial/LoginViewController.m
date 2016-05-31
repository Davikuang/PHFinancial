//
//  LoginViewController.m
//  PHFinancial
//
//  Created by 匡 on 16/5/26.
//  Copyright © 2016年 PuHuiFinancial. All rights reserved.
//

#import "LoginViewController.h"
#import "MyTextField.h"
@interface LoginViewController ()<UITextFieldDelegate>{
    MyTextField *_phoneTF;
    MyTextField *_passwordTF;
}

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    CGFloat ImageHeight =  1.0 * kScreenWidth / 3 * 2;
    UIImageView *bannerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, ImageHeight)];
    bannerView.image = [UIImage imageNamed:@"login_banner"];
    bannerView.userInteractionEnabled = YES;
    [self.view addSubview:bannerView];
    
    // 取消按钮
    UIButton *cancel = [UIButton buttonWithType:UIButtonTypeCustom];
    cancel.frame = CGRectMake(15, 15, 44, 44);
    [cancel setImage:[UIImage imageNamed:@"cancel"] forState:UIControlStateNormal];
    [cancel addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:cancel];
    
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
    
    UIImageView *phoneImage = [[UIImageView alloc] initWithFrame:CGRectMake(17*kScaleX + 2,line.bottom - 15*kScaleY - 24*kScaleY, 14, 24*kScaleY)];
    phoneImage.image = [UIImage imageNamed:@"phone"];
    phoneImage.contentMode = UIViewContentModeScaleAspectFit;
    [tfView addSubview:phoneImage];
    
    _phoneTF = [[MyTextField alloc] initWithFrame:CGRectMake(0, 0,140,25)];
    _phoneTF.font = [UIFont systemFontOfSize:16*kScaleX];
    _phoneTF.placeholder = @"输入手机号";
    _phoneTF.center = CGPointMake(tfView.width/2 + 20 *kScaleX, line.bottom - 15*kScaleX - 25/2);
    
    [tfView addSubview:_phoneTF];
    
    UIImageView *passImage = [[UIImageView alloc] initWithFrame:CGRectMake(17*kScaleX + 2,tfView.height - 17*kScaleY - 24*kScaleY, 14, 24*kScaleY)];
    passImage.image = [UIImage imageNamed:@"lock"];
    passImage.contentMode = UIViewContentModeScaleAspectFit;
    
    _passwordTF = [[MyTextField alloc] initWithFrame:CGRectMake(0, 0,140,25)];
    _passwordTF.font = [UIFont systemFontOfSize:16*kScaleX];
    _passwordTF.placeholder = @"输入密码";
    _passwordTF.center = CGPointMake(tfView.width/2 + 20*kScaleX, tfView.height - 15*kScaleX - 28/2);
    [tfView addSubview:_passwordTF];
    
    [tfView addSubview:passImage];
    
}

- (void)cancelAction:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
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
