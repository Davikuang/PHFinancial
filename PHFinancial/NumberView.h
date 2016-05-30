//
//  NumberView.h
//  PHFinancial
//
//  Created by 匡 on 16/5/30.
//  Copyright © 2016年 PuHuiFinancial. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NumberView : UIView<UIScrollViewDelegate>
- (instancetype)initWithFrame:(CGRect)frame withLabelColor:(UIColor*)color;
@property (nonatomic,strong) UIScrollView *scrollView;
@end
