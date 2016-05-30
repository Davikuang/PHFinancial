//
//  PostTicketViewController.h
//  PHFinancial
//
//  Created by 匡 on 16/5/25.
//  Copyright © 2016年 PuHuiFinancial. All rights reserved.
//
#import "DJCameraViewController.h"
#import "BaseViewController.h"

@interface PostTicketViewController : BaseViewController<imageDelegate>
@property (nonatomic,strong) UITableView *tableView;
@end
