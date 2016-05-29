//
//  TapImageView.h
//  PHFinancial
//
//  Created by 匡 on 16/5/27.
//  Copyright © 2016年 PuHuiFinancial. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DraftDetailViewController.h"
@interface TapImageView : UIImageView
@property (nonatomic,strong) DraftDetailViewController *vc;
@property (nonatomic,strong) NSMutableArray *images;
@end
