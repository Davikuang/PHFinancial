//
//  HomeViewController.m
//  PHFinancial
//
//  Created by PuhuiMac01 on 16/5/18.
//  Copyright © 2016年 PuHuiFinancial. All rights reserved.
//

#import "HomeViewController.h"
#import "FTicketViewController.h"
#import "MessageViewController.h"
#import "DraftDetailViewController.h"
#import "CycleScrollView.h"
#import "kHomeModel.h"
#import "HomeImageView.h"
#import "NumberView.h"
#import "PostTicketListViewController.h"

#import "LoginViewController.h"

@interface HomeViewController (){
    NSMutableArray *_imagelist;
    kHomeModel *_model;
    NumberView *_v1;
    NumberView *_v2;
    NumberView *_v3;
    NumberView *_v4;
    NumberView *_v5;
    //累计交易
    UILabel *_sumTrade;
    //昨日交易
    UILabel *_lastTrade;
    UIScrollView *_scrollView;
    // 消息提示view
    UILabel *_notice;
}
@property (nonatomic,strong) CycleScrollView *homeScrollView;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"普汇金服";
    _imagelist = [NSMutableArray array];
    
    [self _initRightBtn];
    
    if (IS_IPHONE_4) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kTabBarHeight)];
        [self.view addSubview:_scrollView];
        // 初始化轮播广告图
        [self _createCycleScrollViewWithView:_scrollView];
        _scrollView.contentSize = CGSizeMake(kScreenWidth, kScreenHeight - kTabBarHeight + 25);
        _scrollView.showsVerticalScrollIndicator = NO;
        [self _initViewWithView:_scrollView];
    }else {
        [self _createCycleScrollViewWithView:self.view];
        [self _initViewWithView:self.view];
    }
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

/*--------------------私有方法-----------------------*/
- (void)_initViewWithView:(UIView *)view {
    
    UILabel *subtitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 10, 10)];
    subtitle.frame = CGRectMakeAT(0, 21, 200, 23);
    subtitle.center = CGPointMake(view.center.x,_homeScrollView.bottom +  subtitle.center.y);
    subtitle.text = @"今日正在交易";
    subtitle.textAlignment = 1;
    subtitle.font = [UIFont systemFontOfSize:21*kScaleX];
    subtitle.textColor = [UIColor colorWithHexString:@"333333"];
    [view addSubview:subtitle];
    
    UIImageView *subImage = [[UIImageView alloc] initWithFrame:CGRectMake(0,200, 20, 20)];
    subImage.frame = CGRectMakeAT(102, 200, 22, 23);
    subImage.center = CGPointMake(subImage.center.x,subtitle.center.y - 1);

    if (IS_IPHONE_4) {
        subImage.center = CGPointMake(subImage.center.x,subtitle.center.y - 1);
    }
    if (IS_IPHONE_5) {
        
    }
    if (IS_IPHONE_6PLUS) {
        
    }
    
    subImage.contentMode = UIViewContentModeScaleAspectFit;
    subImage.image = [UIImage imageNamed:@"red_fire.png"];

    [view addSubview:subImage];
    
    for (int i = 0; i < 5; i ++) {
        if (i == 0) {
            _v1 = [[NumberView alloc] initWithFrame:CGRectMake(138/2*kScaleX + i * (40 + 9)*kScaleX, subtitle.bottom + 15*kScaleY, 40*kScaleX, 62*kScaleY) withLabelColor:[UIColor colorWithHexString:@"333333"]];
            _v1.layer.borderColor = [UIColor colorWithHexString:@"d9d9d9"].CGColor;
            _v1.layer.borderWidth = 2.5;
            _v1.layer.masksToBounds = YES;
            [_v1.layer setCornerRadius:2.5];
            
            [view addSubview:_v1];
        }
        if (i == 1) {
            _v2 = [[NumberView alloc] initWithFrame:CGRectMake(138/2*kScaleX + i * (40 + 9)*kScaleX, subtitle.bottom + 15*kScaleY, 40*kScaleX, 62*kScaleY) withLabelColor:[UIColor colorWithHexString:@"333333"]];
            _v2.layer.borderColor = [UIColor colorWithHexString:@"d9d9d9"].CGColor;
            _v2.layer.borderWidth = 2.5;
            _v2.layer.masksToBounds = YES;
            [_v2.layer setCornerRadius:2.5];
            
            [view addSubview:_v2];
        }
        if (i == 2) {
            _v3 = [[NumberView alloc] initWithFrame:CGRectMake(138/2*kScaleX + i * (40 + 9)*kScaleX, subtitle.bottom + 15*kScaleY, 40*kScaleX, 62*kScaleY) withLabelColor:[UIColor colorWithHexString:@"333333"]];
            _v3.layer.borderColor = [UIColor colorWithHexString:@"d9d9d9"].CGColor;
            _v3.layer.borderWidth = 2.5;
            _v3.layer.masksToBounds = YES;
            [_v3.layer setCornerRadius:2.5];
            
            [view addSubview:_v3];
        }
        if (i == 3) {
            
            _v4 = [[NumberView alloc] initWithFrame:CGRectMake(138/2*kScaleX + i * (40 + 9)*kScaleX, subtitle.bottom + 15*kScaleY, 40*kScaleX, 62*kScaleY) withLabelColor:[UIColor colorWithHexString:@"333333"]];
            _v4.layer.borderColor = [UIColor colorWithHexString:@"d9d9d9"].CGColor;
            _v4.layer.borderWidth = 2.5;
            _v4.layer.masksToBounds = YES;
            [_v4.layer setCornerRadius:2.5];
            
            [view addSubview:_v4];
          
        }
       
        if (i == 4) {
            _v5 = [[NumberView alloc] initWithFrame:CGRectMake(138/2*kScaleX + i * (40 + 9)*kScaleX, subtitle.bottom + 15*kScaleY, 40*kScaleX, 62*kScaleY) withLabelColor:[UIColor colorWithHexString:kThemeColor]];
            _v5.layer.borderColor = [UIColor colorWithHexString:@"d9d9d9"].CGColor;
            _v5.layer.borderWidth = 2.5;
            _v5.layer.masksToBounds = YES;
            [_v5.layer setCornerRadius:2.5];
            [view addSubview:_v5];
            UILabel *unit = [[UILabel alloc] initWithFrame:CGRectMake(_v5.right + 5, _v5.bottom -20, 20, 20)];
            unit.text = @"万";
            unit.font = [UIFont boldSystemFontOfSize:18];
            [view addSubview:unit];
        }
    }
    
    [UIView animateWithDuration:3 animations:^{
        [_v1.scrollView setContentOffset:CGPointMake(0, _v5.height * 6)];

        [_v2.scrollView setContentOffset:CGPointMake(0, _v5.height * 3)];

        [_v3.scrollView setContentOffset:CGPointMake(0, _v5.height * 8)];

        [_v4.scrollView setContentOffset:CGPointMake(0, _v5.height * 2)];

        [_v5.scrollView setContentOffset:CGPointMake(0, _v5.height * 5)];
    }];
    
    CGFloat _gap = 0;
    
    if (IS_IPHONE_5) {
        _gap = 6;
    }
    
    
    // 累计交易  昨日交易
    _sumTrade = [[UILabel alloc] initWithFrame:CGRectMake(28*kScaleX, _v5.bottom + 21 * kScaleY - _gap, (kScreenWidth/2 - (28 + 8)*kScaleX), 20)];
    _sumTrade.text = [NSString stringWithFormat:@"累计交易：%@亿",@"2182.36"];
    _sumTrade.textColor = [UIColor colorWithHexString:@"666666"];
    _sumTrade.textAlignment = NSTextAlignmentLeft;
    _sumTrade.font = [UIFont systemFontOfSize:15*kScaleX];
    
    [view addSubview:_sumTrade];
    
    // 横线
    UILabel *vline = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth/2-1, _sumTrade.top + 3, 1, _sumTrade.height - 6)];
    vline.backgroundColor = [UIColor colorWithHexString:@"666666"];
    [view addSubview:vline];
    
    // 昨日交易
    _lastTrade = [[UILabel alloc] initWithFrame:CGRectMake(vline.right + 7, _v5.bottom + 21 * kScaleY - _gap, (kScreenWidth/2 - (28 + 8)*kScaleX), 20)];
    _lastTrade.text = [NSString stringWithFormat:@"昨日交易：%@千万",@"1.72"];
    _lastTrade.textColor = [UIColor colorWithHexString:@"666666"];
    _lastTrade.textAlignment = NSTextAlignmentLeft;
    _lastTrade.font = [UIFont systemFontOfSize:15*kScaleX];
    [view addSubview:_lastTrade];
    
    // 底部view
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(20*kScaleX, _sumTrade.bottom + 19*kScaleY - _gap, kScreenWidth - 40*kScaleX, 131*kScaleY- _gap)];
    bottomView.backgroundColor = [UIColor colorWithHexString:@"f0f1f5"];
    [view addSubview:bottomView];
    
    UIButton *ticketBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    ticketBtn.frame = CGRectMake(100, 400, 50, 50);
    ticketBtn.backgroundColor = [UIColor colorWithHexString:kThemeColor];
    [view addSubview:ticketBtn];
    ticketBtn.frame = CGRectMakeAT(11.5*kScaleX, 12.5*kScaleY, bottomView.width - 23*kScaleX, bottomView.height - 25*kScaleY);
    [ticketBtn setTitle:@"我要出票" forState:UIControlStateNormal];
    ticketBtn.titleLabel.font = [UIFont systemFontOfSize:36*kScaleX];
    [ticketBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchDown];
    [ticketBtn.layer setBorderColor:[UIColor colorWithHexString:kThemeColor].CGColor];
    [ticketBtn.layer setBorderWidth:1];
    [ticketBtn.layer setCornerRadius:3];
    ticketBtn.layer.masksToBounds = YES;
    [bottomView addSubview:ticketBtn];
    
    
    UIImageView *btnImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    btnImage.frame = CGRectMakeAT(ticketBtn.right - 92, (ticketBtn.height - 48)/2, 28, 40);
    
    if (IS_IPHONE_4) {
        btnImage.frame = CGRectMakeAT(ticketBtn.right - 92, (ticketBtn.height - 32)/2, 28, 40);
    }
    if (IS_IPHONE_5) {
        btnImage.frame = CGRectMakeAT(ticketBtn.right - 92, (ticketBtn.height - 32)/2, 28, 40);
    }
    if (IS_IPHONE_6PLUS) {
        btnImage.frame = CGRectMakeAT(ticketBtn.right - 92, (ticketBtn.height - 54)/2, 28, 40);
    }
    
    btnImage.image = [UIImage imageNamed:@"yellow_fire.png"];
    btnImage.contentMode = UIViewContentModeScaleAspectFit;
    btnImage.userInteractionEnabled = YES;
    [ticketBtn addSubview:btnImage];
    
    // 底部信息
     UILabel *bottomTitle = [[UILabel alloc] initWithFrame:CGRectMake(((20+11.5) + 18 + 4) * kScaleX, bottomView.bottom, kScreenWidth - 80, view.bottom -kNavBar -kTabBarHeight - bottomView.bottom)];
    
    if (IS_IPHONE_4) {
        bottomTitle.frame  = CGRectMake(60, bottomView.bottom + 3, kScreenWidth - 80, view.bottom - bottomView.bottom);
    }
    bottomTitle.text = @"普汇金服安全保护用户信息、交易安全";
    bottomTitle.font = [UIFont systemFontOfSize:13*kScaleX];
    bottomTitle.textColor = [UIColor colorWithHexString:@"999999"];
    bottomTitle.textAlignment = NSTextAlignmentLeft;
    [view addSubview:bottomTitle];
    
    UIImageView *titleIcon = [[UIImageView alloc] initWithFrame:CGRectMake(ticketBtn.left + 20 *kScaleX, bottomView.bottom + 10, 18*kScaleX, 18*kScaleX)];
    titleIcon.center = CGPointMake(titleIcon.center.x, bottomTitle.center.y);
    titleIcon.contentMode = UIViewContentModeScaleAspectFit;
    titleIcon.image = [UIImage imageNamed:@"safe"];
    [view addSubview:titleIcon];

    NSLog(@" view.height - bottomView.bottom ==  %f",view.height - kNavBar - kTabBarHeight - bottomView.bottom);
//    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn1.frame = CGRectMake(100, 400, 50, 50);
//    btn1.backgroundColor = [UIColor redColor];
//    [self.view addSubview:btn1];
//    
//    [btn1 addTarget:self action:@selector(btnAction1:) forControlEvents:UIControlEventTouchDown];
    NSLog(@" 8888 %f",kScaleY);

}

// 初始化右边按钮
- (void)_initRightBtn{

    CGRect backButton_frame = CGRectMake(0, 0, 44, 40);
    UIButton *mesButton =  [UIButton buttonWithType:UIButtonTypeCustom];//
    mesButton.frame = backButton_frame;
    // 设置标题
    [mesButton setImage:[UIImage imageNamed:@"horn"] forState:UIControlStateNormal];
    // 修改样式
    mesButton.imageEdgeInsets = UIEdgeInsetsMake(0,13,0,-13);
    // 添加事件
    [mesButton addTarget:self action:@selector(mesAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:mesButton];
    
    _notice = [[UILabel alloc] initWithFrame:CGRectMake(39, 8, 10, 10)];
    _notice.layer.borderColor = [UIColor whiteColor].CGColor;
    _notice.layer.borderWidth = 1;
    _notice.layer.cornerRadius = 5.0f;
    _notice.backgroundColor = [UIColor whiteColor];
    _notice.layer.masksToBounds = YES;
    [mesButton addSubview:_notice];
    
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

    self.homeScrollView.backgroundColor = [[UIColor purpleColor] colorWithAlphaComponent:0.1];
    
    [view addSubview:self.homeScrollView];
    
    
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
        
//        [HI1 sd_setImageWithURL:[NSURL URLWithString:@"http://pic13.nipic.com/20110310/6400731_100538610118_2.jpg"]];
        [HI1 setImage:[UIImage imageNamed:@"banner1"]];
        
//        [HI2 sd_setImageWithURL:[NSURL URLWithString:@"http://pic.qiantucdn.com/58pic/17/97/31/95G58PIC4qb_1024.jpg"]];
        [HI2 setImage:[UIImage imageNamed:@"banner1"]];

        
//        [HI3 sd_setImageWithURL:[NSURL URLWithString:@"http://pic.58pic.com/58pic/12/77/30/44758PIC2er.jpg"]];
        [HI3 setImage:[UIImage imageNamed:@"banner1"]];

        
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
//    PostTicketListViewController *vc = [[PostTicketListViewController alloc] init];
//    vc.hidesBottomBarWhenPushed = YES;
//    self.view.backgroundColor = [UIColor whiteColor];
    
    LoginViewController *vc = [[LoginViewController alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
    [self presentViewController:vc animated:YES completion:^{
        
    }];
    
}

// 我要出票按钮
- (void)btnAction1:(UIButton *)sender {
    
    // 出票
    DraftDetailViewController *vc = [[DraftDetailViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.view.backgroundColor = [UIColor greenColor];
    [self.navigationController pushViewController:vc animated:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
