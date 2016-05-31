//
//  PostTicketListViewController.m
//  PHFinancial
//
//  Created by 匡 on 16/5/31.
//  Copyright © 2016年 PuHuiFinancial. All rights reserved.
//

#import "PostTicketListViewController.h"
#import "PostTicketViewController.h"

@interface PostTicketListViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    NSMutableArray *_datalist;
    CGFloat _cellHeight;
}
@end

@implementation PostTicketListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"f0f1f5"];
    self.title = @"我要出票";
    // cell 的高度
    _cellHeight = 136.0f + 10;
    [self _initData];
    [self _initTableView];
}

- (void)_initData{
    _datalist = [NSMutableArray array];
    [_datalist addObject:@"s"];
    [_datalist addObject:@"s"];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)_initTableView{
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    UIImageView *companyImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 9, 18, 20)];
    companyImageView.contentMode = UIViewContentModeScaleAspectFit;
    companyImageView.image = [UIImage imageNamed:@"company"];
    [topView addSubview:companyImageView];

    UILabel *companyId = [[UILabel alloc] initWithFrame:CGRectMake(companyImageView.right + 4, 0, 200, topView.height)];
    companyId.text = [NSString stringWithFormat:@"企业邮编：%@",@"648236"];
    companyId.font = [UIFont systemFontOfSize:16];
    companyId.textColor = [UIColor colorWithHexString:kGrayColor];
    
    [topView addSubview:companyId];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(kScreenWidth - 55, 5, 50, 30);
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [rightBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [rightBtn setTitle:@"完成" forState:UIControlStateSelected];
    [rightBtn setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor colorWithHexString:@"666666"] forState:UIControlStateSelected];
    [rightBtn addTarget:self action:@selector(editAction:) forControlEvents:UIControlEventTouchDown];
    [topView addSubview:rightBtn];
    
    // 初始化TableView
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, topView.bottom, kScreenWidth, kScreenHeight - kNavBar -kTabBarHeight - topView.height) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor colorWithHexString:@"f0f1f5"];
    
}

#pragma mark -- 点击按钮编辑
- (void)editAction:(UIButton *)sender {
    if (sender.selected == YES) {
        sender.selected = NO;
    }else{
        sender.selected = YES;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _datalist.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == _datalist.count-1) {
        static NSString *addTicketCellId = @"addTicketCellId";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:addTicketCellId];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:addTicketCellId];
            UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, kScreenWidth - 20, _cellHeight - 10)];
            UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, bgView.width, bgView.height)];
            bgImageView.userInteractionEnabled = YES;
            bgImageView.image = [UIImage imageNamed:@"cellGrayBgImage"];
            [bgView addSubview:bgImageView];
            
            UIImageView *addImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 45, 45)];
            addImage.userInteractionEnabled = YES;
            [bgImageView addSubview:addImage];
            addImage.image = [UIImage imageNamed:@"add"];
            addImage.center = bgImageView.center;
            [cell.contentView addSubview:bgView];
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 15,200, 20)];
            label.text = @"添加票据信息";
            label.textColor = [UIColor colorWithHexString:kGrayColor];
            [bgImageView addSubview:label];
            label.font = [UIFont systemFontOfSize:16];
            cell.backgroundColor = [UIColor colorWithHexString:@"f0f1f5"];
        }
        
        return cell;
    }else {
        static NSString *ticketCellId = @"ticketCellId";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ticketCellId];
        if (cell == nil) {
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ticketCellId];
            UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, kScreenWidth - 20, _cellHeight - 10)];
            
            UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, bgView.width, bgView.height)];
            bgImageView.userInteractionEnabled = YES;
            bgImageView.image = [UIImage imageNamed:@"cellBgImage"];
            [bgView addSubview:bgImageView];
            [cell.contentView addSubview:bgView];
            
            UIView *grayView = [[UIView alloc] initWithFrame:CGRectMake(1, 0, bgImageView.width-2, bgImageView.height - 42)];
            grayView.backgroundColor = [UIColor colorWithHexString:@"d6d6d6"];
            [bgImageView addSubview:grayView];
            cell.backgroundColor = [UIColor colorWithHexString:@"f0f1f5"];
        }
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return _cellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == _datalist.count - 1) {
        PostTicketViewController *vc = [[PostTicketViewController alloc] init];
        vc.title = @"我的出票";
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
