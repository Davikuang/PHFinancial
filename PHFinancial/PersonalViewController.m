//
//  PersonalViewController.m
//  PHFinancial
//
//  Created by PuhuiMac01 on 16/5/18.
//  Copyright © 2016年 PuHuiFinancial. All rights reserved.
//

#import "PersonalViewController.h"
#import "SettingViewController.h"
@interface PersonalViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
}
@end

@implementation PersonalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"";
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:0];
    self.navigationController.navigationBar.translucent = YES;
    //    让黑线消失的方法
    self.navigationController.navigationBar.shadowImage=[UIImage new];
    [self _initTableView];
    [self _initRightBtn];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = YES;

}
- (void)_initTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,-kNavBar, kScreenWidth, kScreenHeight+kNavBar) style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    NSLog(@"kScreenHeight *** %f",kScreenHeight);
}

- (void)_initRightBtn{
    
    CGRect backButton_frame = CGRectMake(0, 0, 44, 40);
    UIButton *mesButton =  [UIButton buttonWithType:UIButtonTypeCustom];//
    mesButton.frame = backButton_frame;
    
    // 设置标题
    [mesButton setTitle:@"设置" forState:UIControlStateNormal];
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
    SettingViewController *setVC = [[SettingViewController alloc] init];
    setVC.title = @"设置";
    [self.navigationController pushViewController:setVC animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }else {
        return 4;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        CGFloat height = 1.0 * kScreenWidth / 16 * 9;
        return height;
    }else {
        return 10;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *userCellId = @"userCellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:userCellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:userCellId];
    }
    return cell;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        CGFloat height = 1.0 * kScreenWidth / 16 * 9;
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth,     height)];
        view.backgroundColor = [UIColor colorWithHexString:kThemeColor];
        return view;
    }else {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth,     10)];
        view.backgroundColor = [UIColor grayColor];
        return view;
    }
}
@end
