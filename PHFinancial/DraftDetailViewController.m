//
//  DraftDetailViewController.m
//  PHFinancial
//
//  Created by 匡 on 16/5/27.
//  Copyright © 2016年 PuHuiFinancial. All rights reserved.
//

#import "DraftDetailViewController.h"
#import "TapImageView.h"
#import "TradeView.h"
@interface DraftDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    SMPageControl *_pageControl;
    UIView *_bgView;
    UIView *_bgNavView;
    TradeView *_tradeView;
}
@end

@implementation DraftDetailViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self _initTableView];
    [self _initMaskView];
    UIButton *bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    bottomBtn.frame = CGRectMake(0,kScreenHeight - kNavBar -kTabBarHeight,kScreenWidth, 49);
    [bottomBtn setTitle:@"提交报价" forState:UIControlStateNormal];
    bottomBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    bottomBtn.backgroundColor = [UIColor redColor];
    [self.view addSubview:bottomBtn];
    [bottomBtn addTarget:self action:@selector(tradeAction:) forControlEvents:UIControlEventTouchDown];
    
}
- (void)_initMaskView{
    
    _bgNavView = [[UIView alloc] initWithFrame:CGRectMake(0,0, kScreenWidth, kNavBar)];
    _bgNavView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ccmask.png"]];
    [[UIApplication sharedApplication].keyWindow addSubview:_bgNavView];
    
    _bgView = [[UIView alloc] initWithFrame:CGRectMake(0,0, kScreenWidth, kScreenHeight)];
    _bgView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ccmask.png"]];
    [self.view addSubview:_bgView];
    
    
    _tradeView = [[TradeView alloc] initWithFrame:CGRectMake(20, 100, kScreenWidth - 40, 280*kScaleX)];
    _tradeView.backgroundColor = [UIColor whiteColor];
    [_bgView addSubview:_tradeView];
    
    UIButton *cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, _tradeView.height - 38, _tradeView.width/2, 38)];
    [_tradeView addSubview:cancelBtn];
    [cancelBtn addTarget:self action:@selector(cancelOrSure:) forControlEvents:UIControlEventTouchDown];
    cancelBtn.tag = 101;
    cancelBtn.backgroundColor = [UIColor blueColor];
    
    
    _bgView.alpha = 0;
    _bgNavView.alpha = 0;
}
//  点击提交报价
- (void)tradeAction:(UIButton *)sender {
    [UIView animateWithDuration:0.3 animations:^{
        _bgView.alpha = 1;
        _bgNavView.alpha = 1;
    }];
}

// 取消或者确定
- (void)cancelOrSure:(UIButton *)sender {
    if (sender.tag == 101) {
        
        [UIView animateWithDuration:0.3 animations:^{
            [_tradeView setTransform:CGAffineTransformMakeScale(0.01, 0.01)];
            _bgView.alpha = 0;
            _bgNavView.alpha = 0;
        } completion:^(BOOL finished) {
            [_tradeView setTransform:CGAffineTransformMakeScale(1,1)];

        }];
        
        
    }
}
//- (void)_initTradeView {
//    TradeView *v = [[TradeView alloc] initWithFrame:CGRectMake(20, 100, kScreenWidth - 40, 60*5)];
//    v.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:v];
//}

- (void)_initTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavBar) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.allowsSelection = NO;
}

#pragma mark -- tableView 代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *draftDetailcellId = @"draftDetailcellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:draftDetailcellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:draftDetailcellId];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 180;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 180)];
    
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 180)];
    scrollView.contentSize = CGSizeMake(kScreenWidth * 3, 100);
    
    NSArray *images = @[@"image.jpg",@"image.jpg",@"image.jpg"];
    for (int i = 0; i < 3; i++) {
        TapImageView *imagView = [[TapImageView alloc] initWithFrame:CGRectMake(i*kScreenWidth,0, kScreenWidth, 180)];
        imagView.tag = 300 + i;
        imagView.vc = self;
        imagView.images = [images mutableCopy];
        imagView.image = [UIImage imageNamed:@"image.jpg"];
        [scrollView addSubview:imagView];
    }
    scrollView.pagingEnabled = YES;
    scrollView.tag = 200;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.delegate = self;
    _pageControl = [[SMPageControl alloc]init];
    _pageControl.frame = CGRectMake(scrollView.width/2 - 40,scrollView.height - 20, 80, 10);
    _pageControl.numberOfPages = 3;
    
    _pageControl.currentPage = 0;
    _pageControl.pageIndicatorTintColor = [UIColor grayColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor colorWithHexString:kLitleBlue];
    
    
    [view addSubview:scrollView];
    [view addSubview:_pageControl];
    return view;
}

/*---------------------滚动代理事件------------------*/
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
   
    if (scrollView.tag == 200) {
        
        int page =(scrollView.contentOffset.x +scrollView.frame.size.width*0.5)/scrollView.frame.size.width;
        _pageControl.currentPage=page;
        
    }
}

@end
