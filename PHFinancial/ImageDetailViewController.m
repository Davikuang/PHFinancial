//
//  ImageDetailViewController.m
//  PHFinancial
//
//  Created by 匡 on 16/5/27.
//  Copyright © 2016年 PuHuiFinancial. All rights reserved.
//

#import "ImageDetailViewController.h"
#import "PHScrollView.h"
@interface ImageDetailViewController ()<UIScrollViewDelegate>
{
    UIImageView * _fullImageView;
}
@end

@implementation ImageDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];
    [self _initBackBtn];
    [self _initScrollView];
}


- (void)_initScrollView {
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kNavBar, kScreenWidth, kScreenHeight - kNavBar)];
    scrollView.contentSize = CGSizeMake(kScreenWidth*self.datalist.count, kScreenHeight - kNavBar);
    scrollView.pagingEnabled = YES;
    
    for (int i = 0; i < self.datalist.count; i ++) {
        PHScrollView *sv = [[PHScrollView alloc] initWithFrame:CGRectMake(i*kScreenWidth, 0, kScreenWidth, kScreenHeight - kNavBar)];
        sv.fullImageView.image = [UIImage imageNamed:self.datalist[i]];
        [scrollView addSubview:sv];
    }
    scrollView.backgroundColor = [UIColor blackColor];
   
    [scrollView setContentOffset:CGPointMake(kScreenWidth*self.index, 0)];
    [self.view addSubview:scrollView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)_initBackBtn {
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(10, 20, 50, 40);
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(doBack:) forControlEvents:UIControlEventTouchDown];
    backBtn.backgroundColor = [UIColor blueColor];
    [self.view addSubview:backBtn];
}

- (void)doBack:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}



@end
