//
//  PostTicketViewController.m
//  PHFinancial
//
//  Created by 匡 on 16/5/25.
//  Copyright © 2016年 PuHuiFinancial. All rights reserved.
//

#import "PostTicketViewController.h"
#import "ImageCollectionView.h"
#import "ImageItem.h"

@interface PostTicketViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    ImageCollectionView *_collectionView;
    NSMutableArray *_imageItems;
    CGFloat _fristCellHeight;
    CGFloat _cellHeight;
    CGFloat _headerHeight;
    NSArray *_titiles;
}
@end

@implementation PostTicketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"我要出票";
    NSArray *names = @[@"票据类型",@"出票银行",@"票面金额",@"到期时间",@"几手背书",@"汇票张数",@"交易城市"];
    _titiles = [NSMutableArray  arrayWithArray:names];
    _imageItems = [NSMutableArray array];
    _cellHeight = 44;
    [self _initTableView];
    
    ImageItem *item = [[ImageItem alloc] init];
    item.image = [UIImage imageNamed:@"home_tab"];
    item.isPleaseHolder = YES;
    [_imageItems addObject:item];
    
    // 底部按钮
    UIButton *bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    bottomBtn.frame = CGRectMake(0, kScreenHeight - kTabBarHeight - kNavBar, kScreenWidth, kTabBarHeight);
    bottomBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    bottomBtn.backgroundColor = [UIColor redColor];
    [bottomBtn setTitle:@"提交汇票" forState:UIControlStateNormal];
    [self.view addSubview:bottomBtn];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (_imageItems.count / 4 == 0) {
        _headerHeight = (_imageItems.count/4 + 1) * (kScreenWidth - 20)/4 + 50*kScaleX+10*kScaleY;
    }
    if (_imageItems.count / 4 != 0 && _imageItems.count %4 == 0) {
        _headerHeight = (_imageItems.count/4) * (kScreenWidth - 20)/4 + 50*kScaleX+10*kScaleY;
    }
    if (_imageItems.count / 4 != 0 && _imageItems.count %4 != 0) {
        _headerHeight = (_imageItems.count/4 + 1) * (kScreenWidth - 20)/4 + 50*kScaleX+ 10*kScaleY;
    }
    
    [_tableView reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)_initTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavBar -kTabBarHeight) style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
}

#pragma mark -- tableView代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _titiles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellId = @"cellId";
    static NSString *fristCellId = @"fristCellId";
    
    if (indexPath.row == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:fristCellId];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:fristCellId];
            
            UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 30)];
            title.font = [UIFont systemFontOfSize:14];
            title.text = _titiles[indexPath.row];
            [cell.contentView addSubview:title];
            
            UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(10, _cellHeight-0.5, kScreenWidth - 20, 0.5)];
            line.backgroundColor = [UIColor lightGrayColor];
            [cell.contentView addSubview:line];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        return cell;
    }else {
       UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
            
            UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 30)];
            title.font = [UIFont systemFontOfSize:14];
            title.text = _titiles[indexPath.row];
            [cell.contentView addSubview:title];
            
            MyTextField *tf = [[MyTextField alloc] initWithFrame:CGRectMake(title.right, 10, 100, 30)];
            tf.placeholder = @"请输入金额";
            [cell.contentView addSubview:tf];
            
            UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(10, _cellHeight-0.5, kScreenWidth - 20, 0.5)];
            line.backgroundColor = [UIColor lightGrayColor];
            [cell.contentView addSubview:line];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return _cellHeight;
}



- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, _headerHeight)];
    view.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMakeAT(10, 15, 100, 25)];
    label.text = @"票据照片";
    [view addSubview:label];
  
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    
    _collectionView = [[ImageCollectionView alloc] initWithFrame:CGRectMake(10,42*kScaleX,kScreenWidth - 20,_headerHeight - 50 - 10*kScaleY) collectionViewLayout:flowLayout];
    _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.pTVC = self;
        [view addSubview:_collectionView];
    
    _collectionView.frame = CGRectMake(10,42*kScaleX,kScreenWidth - 20,_headerHeight - 50*kScaleX - 10*kScaleY);//
    
    _collectionView.datalist = _imageItems;
    
    [_collectionView reloadData];

    view.backgroundColor = [UIColor whiteColor];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, _headerHeight - 10*kScaleY, kScreenWidth, 10*kScaleY)];
    line.backgroundColor = [UIColor grayColor];
    [view addSubview:line];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (_imageItems.count / 4 == 0) {
        _headerHeight = (_imageItems.count/4 + 1) * (kScreenWidth - 20)/4 + 50*kScaleX+10*kScaleY;
    }
    if (_imageItems.count / 4 != 0 && _imageItems.count %4 == 0) {
        _headerHeight = (_imageItems.count/4) * (kScreenWidth - 20)/4 + 50*kScaleX+10*kScaleY;
    }
    if (_imageItems.count / 4 != 0 && _imageItems.count %4 != 0) {
        _headerHeight = (_imageItems.count/4 + 1) * (kScreenWidth - 20)/4 + 50*kScaleX+ 10*kScaleY;
    }
    return _headerHeight;
}

#pragma mark -- 自定义相机代理方法
- (void)getImagesWithArray:(NSMutableArray *)array{
    if (array.count != 0) {
        for (int i = 0; i < array.count ; i++) {
            ImageItem *item = array[i];
            [_imageItems insertObject:item atIndex:0];
        }
    }
    [_tableView reloadData];
}



@end
