//
//  HomeViewController.m
//  PHFinancial
//
//  Created by PuhuiMac01 on 16/5/18.
//  Copyright © 2016年 PuHuiFinancial. All rights reserved.
//

#import "HomeViewController.h"
#import "FTicketViewController.h"
#import "PostTicketViewController.h"
#import "MessageViewController.h"
#import "DraftDetailViewController.h"
@interface HomeViewController (){

}

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    // Do any additional setup after loading the view.
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 100, 50, 50);
    btn.backgroundColor = [UIColor blueColor];
    [self.view addSubview:btn];
    btn.frame = CGRectMakeAT(10, 10, 40, 40);
    [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchDown];
    
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(100, 200, 50, 50);
    btn1.backgroundColor = [UIColor redColor];
    [self.view addSubview:btn1];
    
    [btn1 addTarget:self action:@selector(btnAction1:) forControlEvents:UIControlEventTouchDown];
    
    
}

- (void)_initRightBtn{

    CGRect backButton_frame = CGRectMake(0, 0, 75, 44);
    UIButton *mesButton =  [UIButton buttonWithType:UIButtonTypeCustom];//
    mesButton.frame = backButton_frame;
    
    // 设置标题
    [mesButton setTitle:@"返 回" forState:UIControlStateNormal];
    // 修改样式
    //leftButton.titleEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    mesButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    // 添加事件
    [mesButton addTarget:self action:@selector(mesAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:mesButton];
    
}
    
#pragma mark - 返回按钮事件
- (void)mesAction:(UIButton *)button
{
    // 返回
    MessageViewController *mesVC = [[MessageViewController alloc] init];
    mesVC.title = @"消息中心";
    [self.navigationController pushViewController:mesVC animated:YES];
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

//- (void)init

- (void)afn{
    // post请求Url参与签名，body不参与签名   请求所有的都参与签名
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    
    //申明返回的结果是json类型
    session.responseSerializer = [AFJSONResponseSerializer serializer];
    //申明请求的数据是json类型
    session.requestSerializer=[AFJSONRequestSerializer serializer];
    //如果报接受类型不一致请替换一致text/html或别的
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    
    // 默认帮助JSON解析，XML，NSXMLParser对象
    NSDictionary *dic = @{
//                          @"channel1":channel_key,
//                          @"time1":kAPI_timestamp,
                          };
    NSString *subUrl = [BaseUtil getUrlWithDic:dic withHttp:k_API_MESSAGECODE];
    NSLog(@"subUrl %@",subUrl);
    
    NSDictionary *params = @{
                          @"mobile":@"13412345678",
                          };
    
    [session POST:subUrl
      parameters:params
         success:^(NSURLSessionDataTask *task, id responseObject) {
             // 获取数据
             NSDictionary *dic = responseObject;
             NSLog(@"dic***  %@",dic);
             NSString *state = [NSString stringWithFormat:@"%@",dic[@"rec"]];
             NSLog(@" msg %@",dic[@"msg"]);
             [BaseUtil errorMesssage:[NSString stringWithFormat:@"%@",state]];
             if ([state isEqualToString:@"0"]) {
                 
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

- (void)btnAction:(UIButton *)sender {
    
    // 出票
    PostTicketViewController *vc = [[PostTicketViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)btnAction1:(UIButton *)sender {
    
    // 出票
    DraftDetailViewController *vc = [[DraftDetailViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
