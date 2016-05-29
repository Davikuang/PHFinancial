//
//  ItemView.h
//  MovieTime3
//
//  Created by wxhl31 on 15-1-14.
//  Copyright (c) 2015年 匡延伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ItemView;
typedef void (^ItemBlock)(ItemView *sender);
@protocol ItemViewDelegate <NSObject>

- (void)didSelectedItemView:(ItemView *)itemView;

@end
@interface ItemView : UIView {
    UIButton *_itemButton;
    UILabel *_itemLabl;
    ItemBlock _block;
    
}
@property (nonatomic,strong) UIButton *itemButton;
@property (nonatomic,strong) UILabel *itemLabl;
//@property (nonatomic,copy) ItemBlock block;


- (void)setItemImage:(UIImage *)image forState:(UIControlState)state ;
- (void)setItemTitle:(NSString *)title ;
- (void)setSelected:(BOOL)selected;
@property(nonatomic,weak)id <ItemViewDelegate> delegate;
@property (nonatomic,copy)ItemBlock block;
@end
