
//  FixPasswordViewController.m
//  PHFinancial
//
//  Created by 匡 on 16/6/1.
//  Copyright © 2016年 PuHuiFinancial. All rights reserved.
//

#import "FixPasswordViewController.h"

@interface FixPasswordViewController ()
{
    UITextField *_newpasswordTF;
    UITextField *_passwordTF;
    UITextField *_codeTF;
    UIButton *_mesBtn;
}
@end

@implementation FixPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"修改密码";
    [self _initView];
    // 添加手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self.view addGestureRecognizer:tap];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)_initView{
    
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
        imagegap = 1;
        phoneImageGap = 1;
    }
    
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(96/2*kScaleX, 196/2*kScaleY, kScreenWidth - 96*kScaleX, 0.5)];
    line1.backgroundColor = [UIColor  colorWithHexString:@"cbcbcb"];
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(96/2*kScaleX,line1.bottom + 50*kScaleX, kScreenWidth - 96*kScaleX, 0.5)];
    line2.backgroundColor = [UIColor  colorWithHexString:@"cbcbcb"];
    UIView *line3 = [[UIView alloc] initWithFrame:CGRectMake(96/2*kScaleX,line2.bottom + 50*kScaleX, kScreenWidth - 96*kScaleX, 0.5)];
    line3.backgroundColor = [UIColor  colorWithHexString:@"cbcbcb"];
    
    [self.view addSubview:line1];
    [self.view addSubview:line2];
    [self.view addSubview:line3];
    
    // 确定按钮
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sureBtn.frame = CGRectMake(line1.left, line3.bottom + 37 *kScaleX, line1.width, 44*kScaleX);
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:17*kScaleX];
    [sureBtn setBackgroundImage:[UIImage imageNamed:@"redbtn"] forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(regist:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:sureBtn];
    
    // 输入手机号
    UIImageView *phoneImage = [[UIImageView alloc] initWithFrame:CGRectMake(line1.left + 10*kScaleX,line1.bottom - (12)*kScaleY - 24*kScaleY - phoneImageGap, 14, 24*kScaleY)];
    phoneImage.image = [UIImage imageNamed:@"lock"];
    phoneImage.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:phoneImage];
    
    _newpasswordTF = [[UITextField alloc] initWithFrame:CGRectMake(0, 0,140,25)];
    _newpasswordTF.font = [UIFont systemFontOfSize:16*kScaleX];
    _newpasswordTF.placeholder = @"请输新密码";
    _newpasswordTF.center = CGPointMake(self.view.width/2 + (10 + tfgap)*kScaleX, line1.bottom - 11*kScaleX - (25/2)*kScaleY);
    _newpasswordTF.keyboardType =UIKeyboardTypeNumberPad;
    
    [self.view addSubview:_newpasswordTF];
    
    // 输入密码
    
    UIImageView *passImage = [[UIImageView alloc] initWithFrame:CGRectMake(line2.left + 10*kScaleX,line2.bottom - (13 + imagegap) *kScaleY - 24*kScaleY, 14, 24*kScaleY)];
    passImage.image = [UIImage imageNamed:@"lock"];
    passImage.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:passImage];
    _passwordTF = [[UITextField alloc] initWithFrame:CGRectMake(0, 0,140,25)];
    _passwordTF.font = [UIFont systemFontOfSize:16*kScaleX];
    _passwordTF.placeholder = @"请再次输入密码";
    
    _passwordTF.center = CGPointMake(self.view.width/2 + (10 + tfgap)*kScaleX, line2.bottom - 10*kScaleX - (28/2)*kScaleY);
    [self.view addSubview:_passwordTF];
    
    _passwordTF.secureTextEntry = YES;
    _passwordTF.enablesReturnKeyAutomatically = YES;
    
    //输入验证码
    
    _codeTF = [[UITextField alloc] initWithFrame:CGRectMake(line1.left + 5*kScaleX, 0,140,25)];
    _codeTF.font = [UIFont systemFontOfSize:16*kScaleX];
    _codeTF.placeholder = @"请输入验证码";
    _codeTF.keyboardType = UIKeyboardTypeNumberPad;
    _codeTF.center = CGPointMake(_codeTF.center.x, line3.bottom - 10*kScaleX - (28/2)*kScaleY);
    [self.view addSubview:_codeTF];
    
    UILabel *vline = [[UILabel alloc] initWithFrame:CGRectMake(line1.left + 336/2*kScaleX,line2.bottom + 14*kScaleX,0.5,(50 - 28)*kScaleX)];
    vline.backgroundColor = [UIColor colorWithHexString:@"cbcbcb"];
    [self.view addSubview:vline];
    
    // 验证码按钮
    
    _mesBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _mesBtn.frame = CGRectMake(vline.left, line2.bottom,line1.right - vline.right,50*kScaleX);
    _mesBtn.titleLabel.font = [UIFont systemFontOfSize:16*kScaleX];
    [_mesBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_mesBtn setTitleColor:[UIColor colorWithHexString:kBlackColor] forState:UIControlStateNormal];
    [_mesBtn addTarget:self action:@selector(messageCode:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:_mesBtn];
    
}


/*--------------------------按钮方法----------------------------*/
// 获取验证码
- (void)messageCode:(UIButton *)sender {
    if ([BaseUtil isEmpty:_newpasswordTF.text] == YES) {
        [[TKAlertCenter defaultCenter] postAlertWithMessage:@"请输入密码"];
        return;
    }
    if ([BaseUtil isEmpty:_passwordTF.text] == YES) {
        [[TKAlertCenter defaultCenter] postAlertWithMessage:@"请输入确认密码"];
        return;
    }
    
    if (![_newpasswordTF.text isEqualToString:_passwordTF.text]) {
        [[TKAlertCenter defaultCenter] postAlertWithMessage:@"两次密码输入不一致"];
        return;
    }
    [self getMesCode];
}
// 确定按钮
- (void)regist:(UIButton *)sender {
    
    if([BaseUtil isEmpty:_newpasswordTF.text] == YES){
        [[TKAlertCenter defaultCenter] postAlertWithMessage:@"请输入手机号"];
        return;
    }
    if (_newpasswordTF.text.length != 11) {
        [[TKAlertCenter defaultCenter] postAlertWithMessage:@"请输入正确手机号"];
        return;
    }
    if([BaseUtil isEmpty:_passwordTF.text] == YES){
        [[TKAlertCenter defaultCenter] postAlertWithMessage:@"密码不能为空"];
        return;
    }
    if ([BaseUtil isEmpty:_codeTF.text] == YES) {
        [[TKAlertCenter defaultCenter] postAlertWithMessage:@"请输入短信验证码"];
        return;
    }
    
    [self getPassword];
}

/*--------------------------网络请求-------------------------*/
//  获取验证码
- (void)getMesCode{
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.responseSerializer = [AFJSONResponseSerializer serializer];
    session.requestSerializer.timeoutInterval = 20;
    
    //申明返回的结果是json类型
    session.responseSerializer = [AFJSONResponseSerializer serializer];
    //申明请求的数据是json类型
    session.requestSerializer=[AFJSONRequestSerializer serializer];
    //如果报接受类型不一致请替换一致text/html或别的
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    // 默认帮助JSON解析，XML，NSXMLParser对象
    NSDictionary *dic = @{
                          };
    NSString *subUrl = [BaseUtil getUrlWithDic:dic withHttp:k_API_MESSAGECODE];
    NSLog(@"subUrl %@",subUrl);
    
    NSDictionary *params = @{
                             @"mobile":_newpasswordTF.text,
                             };
    
    [session POST:subUrl
       parameters:params
          success:^(NSURLSessionDataTask *task, id responseObject) {
              // 获取数据
              NSDictionary *dic = responseObject;
              NSLog(@"dic***  %@",dic);
              NSString *state = [NSString stringWithFormat:@"%@",dic[@"rec"]];
              NSLog(@" msg %@",dic[@"msg"]);
              
              if ([state isEqualToString:@"0"]) {
                  [[TKAlertCenter defaultCenter] postAlertWithMessage:@"验证码获取成功"];
              }else {
                  [BaseUtil errorMesssage:state];
              }
              NSLog(@"statusCode == %@",task);
          }
          failure:^(NSURLSessionDataTask *task, NSError *error) {
              NSLog(@"task %@",task);
              NSLog(@"error %@",error);
          }];
    
}

//
- (void)getPassword{
    [ProgressHUD show:@"请稍候..."];
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.responseSerializer = [AFJSONResponseSerializer serializer];
    //申明返回的结果是json类型
    session.responseSerializer = [AFJSONResponseSerializer serializer];
    //申明请求的数据是json类型
    session.requestSerializer=[AFJSONRequestSerializer serializer];
    //如果报接受类型不一致请替换一致text/html或别的
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    // 默认帮助JSON解析，XML，NSXMLParser对象
    NSDictionary *dic = @{
                          };
    NSString *subUrl = [BaseUtil getUrlWithDic:dic withHttp:k_API_RORGETPASSWORD];
    NSLog(@"subUrl %@",subUrl);
    
    
    NSDictionary *params = @{
                             @"mobile":[PHUserManager getAccountFromKeychain],
                             @"code":_codeTF.text,
                             @"password":[BaseUtil md5:_passwordTF.text],
                             @"coordX":kCoordX ? kCoordX:@0.0,
                             @"coordY":kCoordY ? kCoordY:@0.0,
                             };
    NSLog(@"params %@",params);
    
    [session POST:subUrl
       parameters:params
          success:^(NSURLSessionDataTask *task, id responseObject) {
              [ProgressHUD dismiss];
              
              // 获取数据
              NSDictionary *dic = responseObject;
              NSLog(@"dic***  %@",dic);
              NSString *state = [NSString stringWithFormat:@"%@",dic[@"rec"]];
              NSLog(@" msg %@",dic[@"msg"]);
              
              if ([state isEqualToString:@"0"]) {
                  [[TKAlertCenter defaultCenter] postAlertWithMessage:@"注册成功"];
                  NSString *token = dic[@"data"][@"token"];
                  [PHUserManager shareManager].token = token;
                  // 保存用户帐号
                  [PHUserManager storeAccountInKeychain:_newpasswordTF.text];
                  // 保存密码
                  [PHUserManager storePasswordInKeychain:_passwordTF.text];
                  [self dismissViewControllerAnimated:YES completion:^{
                      
                  }];
                  
              }else {
                  [BaseUtil errorMesssage:state];
              }
              NSLog(@"statusCode == %@",task);
          }
          failure:^(NSURLSessionDataTask *task, NSError *error) {
              NSLog(@"task %@",task);
              NSLog(@"error %@",error);
              [ProgressHUD dismiss];
          }];
}

#pragma mark -- 点击事件
- (void)tap:(UITapGestureRecognizer *)tap {
    [_codeTF resignFirstResponder];
    [_passwordTF resignFirstResponder];
    [_newpasswordTF resignFirstResponder];
    //    [_invitorTF resignFirstResponder];
}

// 点击协议
- (void)labTap:(UITapGestureRecognizer *)tap {
    NSLog(@"点击了协议");
    //    ProtoclViewController *vc = [[ProtoclViewController alloc] init];
    //    [self.navigationController pushViewController:vc animated:YES];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [ProgressHUD dismiss];
}

@end
