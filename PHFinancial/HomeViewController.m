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
#import "CycleScrollView.h"
#import "kHomeModel.h"
#import "HomeImageView.h"
#import "NumberView.h"
@interface HomeViewController (){
    NSMutableArray *_imagelist;
    kHomeModel *_model;
    NumberView *_v1;
    NumberView *_v2;
    NumberView *_v3;
    NumberView *_v4;
    NumberView *_v5;
}
@property (nonatomic,strong) CycleScrollView *homeScrollView;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _imagelist = [NSMutableArray array];
    
    // 初始化轮播广告图
    [self _createCycleScrollViewWithView:self.view];

    [self _initRightBtn];
    [self _initView];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIView animateWithDuration:3 animations:^{
        [_v1.scrollView setContentOffset:CGPointMake(0, _v5.height * 6)];
        
        [_v2.scrollView setContentOffset:CGPointMake(0, _v5.height * 3)];
        
        [_v3.scrollView setContentOffset:CGPointMake(0, _v5.height * 8)];
        
        [_v4.scrollView setContentOffset:CGPointMake(0, _v5.height * 2)];
        
        [_v5.scrollView setContentOffset:CGPointMake(0, _v5.height * 5)];
    }];
    
}

- (void)_initView {
    
    for (int i = 0; i < 5; i ++) {
        if (i == 0) {
            _v1 = [[NumberView alloc] initWithFrame:CGRectMake(30 + i * (40 + 10), _homeScrollView.bottom + 60, 40, 60) withLabelColor:[UIColor blackColor]];
            _v1.layer.borderColor = [UIColor grayColor].CGColor;
            _v1.layer.borderWidth = 2;
            _v1.layer.masksToBounds = YES;
            _v1.layer.shadowOffset = CGSizeMake(10, 10);
            _v1.layer.shadowColor = [UIColor grayColor].CGColor;
            [_v1.layer setCornerRadius:3];
            
            [self.view addSubview:_v1];
        }
        if (i == 1) {
            _v2 = [[NumberView alloc] initWithFrame:CGRectMake(30 + i * (40 + 10), _homeScrollView.bottom + 60, 40, 60) withLabelColor:[UIColor blackColor]];
            _v2.layer.borderColor = [UIColor grayColor].CGColor;
            _v2.layer.borderWidth = 2;
            _v2.layer.masksToBounds = YES;
            _v2.layer.shadowOffset = CGSizeMake(10, 10);
            _v2.layer.shadowColor = [UIColor grayColor].CGColor;
            [_v2.layer setCornerRadius:3];
            
            [self.view addSubview:_v2];
        }
        if (i == 2) {
            _v3 = [[NumberView alloc] initWithFrame:CGRectMake(30 + i * (40 + 10), _homeScrollView.bottom + 60, 40, 60) withLabelColor:[UIColor blackColor]];
            _v3.layer.borderColor = [UIColor grayColor].CGColor;
            _v3.layer.borderWidth = 2;
            _v3.layer.masksToBounds = YES;
            _v3.layer.shadowOffset = CGSizeMake(10, 10);
            _v3.layer.shadowColor = [UIColor grayColor].CGColor;
            [_v3.layer setCornerRadius:3];
            
            [self.view addSubview:_v3];
        }
        if (i == 3) {
            
            _v4 = [[NumberView alloc] initWithFrame:CGRectMake(30 + i * (40 + 10), _homeScrollView.bottom + 60, 40, 60) withLabelColor:[UIColor blackColor]];
            _v4.layer.borderColor = [UIColor grayColor].CGColor;
            _v4.layer.borderWidth = 2;
            _v4.layer.masksToBounds = YES;
            _v4.layer.shadowOffset = CGSizeMake(10, 10);
            _v4.layer.shadowColor = [UIColor grayColor].CGColor;
            [_v4.layer setCornerRadius:3];
            
            [self.view addSubview:_v4];
          
        }
       
        if (i == 4) {
            _v5 = [[NumberView alloc] initWithFrame:CGRectMake(30 + i * (40 + 10), _homeScrollView.bottom + 60, 40, 60) withLabelColor:[UIColor colorWithHexString:kThemeColor]];
            _v5.layer.borderColor = [UIColor grayColor].CGColor;
            _v5.layer.borderWidth = 2;
            _v5.layer.masksToBounds = YES;
            _v5.layer.shadowOffset = CGSizeMake(10, 10);
            _v5.layer.shadowColor = [UIColor grayColor].CGColor;
            [_v5.layer setCornerRadius:3];
            [self.view addSubview:_v5];
        }
    }
    
    [UIView animateWithDuration:3 animations:^{
        [_v1.scrollView setContentOffset:CGPointMake(0, _v5.height * 6)];

        [_v2.scrollView setContentOffset:CGPointMake(0, _v5.height * 3)];

        [_v3.scrollView setContentOffset:CGPointMake(0, _v5.height * 8)];

        [_v4.scrollView setContentOffset:CGPointMake(0, _v5.height * 2)];

        [_v5.scrollView setContentOffset:CGPointMake(0, _v5.height * 5)];
    }];
    
    
    
    
    UIButton *ticketBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    ticketBtn.frame = CGRectMake(100, 400, 50, 50);
    ticketBtn.backgroundColor = [UIColor colorWithHexString:kThemeColor];
    [self.view addSubview:ticketBtn];
    ticketBtn.frame = CGRectMakeAT(20, 400, kScreenWidth - 40, 130);
    [ticketBtn setTitle:@"我要出票" forState:UIControlStateNormal];
    [ticketBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchDown];
    
//    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn1.frame = CGRectMake(100, 400, 50, 50);
//    btn1.backgroundColor = [UIColor redColor];
//    [self.view addSubview:btn1];
//    
//    [btn1 addTarget:self action:@selector(btnAction1:) forControlEvents:UIControlEventTouchDown];
    

}

- (void)_initRightBtn{

    CGRect backButton_frame = CGRectMake(0, 0, 44, 40);
    UIButton *mesButton =  [UIButton buttonWithType:UIButtonTypeCustom];//
    mesButton.frame = backButton_frame;
    // 设置标题
    [mesButton setTitle:@"消息" forState:UIControlStateNormal];
    // 修改样式
    //leftButton.titleEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    mesButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    // 添加事件
    [mesButton addTarget:self action:@selector(mesAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:mesButton];
    
}
    
#pragma mark - 返回按钮事件
- (void)mesAction:(UIButton *)button
{
    // 返回
    MessageViewController *mesVC = [[MessageViewController alloc] init];
    mesVC.title = @"消息中心";
    [self.navigationController pushViewController:mesVC animated:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

/*--------------------------私有方法---------------------------*/

// 添加循环滚动视图
- (void)_createCycleScrollViewWithView:(UIView *)view {
    
    CGFloat Height =1.0 * kScreenWidth / 16 * 9 ;
    self.homeScrollView = [[CycleScrollView alloc] initWithFrame:CGRectMake(0,0,kScreenWidth,Height) animationDuration:5];
    
    UIImageView *IV = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,kScreenWidth,100)];
    [IV setContentMode:UIViewContentModeScaleToFill];
    IV.userInteractionEnabled = YES;
//    [self.homeScrollView insertSubview:IV belowSubview:_homeScrollView.scrollView];
    self.homeScrollView.backgroundColor = [[UIColor purpleColor] colorWithAlphaComponent:0.1];
    
    [self.view addSubview:self.homeScrollView];
    
    
    __block NSMutableArray *arr = [self images];
    
    // 获取对应的数组图片
    self.homeScrollView.fetchContentViewAtIndex = ^HomeImageView *(NSInteger pageIndex){
        
        return arr[pageIndex];
        
    };
    
    self.homeScrollView.totalPagesCount = ^NSInteger(void){
        return arr.count;
    };
}

- (NSMutableArray *)images {
    
    NSMutableArray *dataLists = [NSMutableArray array];
    if (_model != nil) {
        
        for (int i = 0; i <_model.adImages.count; i++) {
            
            HomeImageView *HI = [[HomeImageView alloc] initWithFrame:CGRectMake(0, 0, _homeScrollView.width, _homeScrollView.height)];
            [HI sd_setImageWithURL:[NSURL URLWithString:_model.adImages[i]]];
            
            HI.url = _model.adImages[i];
            
            [dataLists addObject:HI];
            
        }
        
    }else {
        
        HomeImageView *HI1 = [[HomeImageView alloc] initWithFrame:CGRectMake(0, 0, _homeScrollView.width, _homeScrollView.height)];
        HomeImageView *HI2 = [[HomeImageView alloc] initWithFrame:CGRectMake(0, 0, _homeScrollView.width, _homeScrollView.height)];
        HomeImageView *HI3 = [[HomeImageView alloc] initWithFrame:CGRectMake(0, 0, _homeScrollView.width, _homeScrollView.height)];
        HomeImageView *HI4 = [[HomeImageView alloc] initWithFrame:CGRectMake(0, 0, _homeScrollView.width, _homeScrollView.height)];
        
        [HI1 sd_setImageWithURL:[NSURL URLWithString:@"http://pic13.nipic.com/20110310/6400731_100538610118_2.jpg"]];
        
        [HI2 sd_setImageWithURL:[NSURL URLWithString:@"http://pic.qiantucdn.com/58pic/17/97/31/95G58PIC4qb_1024.jpg"]];
        
        [HI3 sd_setImageWithURL:[NSURL URLWithString:@"http://pic.58pic.com/58pic/12/77/30/44758PIC2er.jpg"]];
        
        [HI4 sd_setImageWithURL:[NSURL URLWithString:@"https://github.com/wjmwjmwb/GitImage/blob/master/12312.png"]];
        
        NSMutableArray *array = [NSMutableArray array];
        
        [array addObject:HI1];
        [array addObject:HI2];
        [array  addObject:HI3];
        
        [dataLists addObjectsFromArray:array];
        
    }
    return dataLists;
}

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
