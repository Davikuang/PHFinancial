//
//  ItemView.m
//  MovieTime3
//
//  Created by wxhl31 on 15-1-14.
//  Copyright (c) 2015年 匡延伟. All rights reserved.
//

#import "ItemView.h"

@implementation ItemView

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if(self){
        
        _itemButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _itemButton.frame = self.bounds;
        _itemButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0,10, 0);
        [self addSubview:_itemButton];
        [_itemButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchDown];
        
        _itemLabl = [[UILabel alloc] initWithFrame:CGRectMake(0,kTabBarHeight-22,frame.size.width, 20)];
        _itemLabl.textColor = [UIColor whiteColor];
        _itemLabl.highlightedTextColor = [UIColor colorWithHexString:kLitleBlue];
        _itemLabl.textAlignment = NSTextAlignmentCenter;
        _itemLabl.backgroundColor = [UIColor clearColor];
        _itemLabl.textColor = [UIColor grayColor];
        _itemLabl.font = [UIFont systemFontOfSize:9];
        [self addSubview:_itemLabl];
        [self addSubview:_itemButton];
        
    }
    return self;
}

#pragma mark - Pravit Method
- (void)setItemImage:(UIImage *)image forState:(UIControlState)state {
    [_itemButton setImage:image forState:state];
}

- (void)setItemTitle:(NSString *)title {
    _itemLabl.text = title;
}

- (void)setSelected:(BOOL)selected {
    _itemButton.selected = selected;
    _itemLabl.highlighted = selected;
}

#pragma mark - button Method
- (void)click:(UIButton *)sender {
//    if([_delegate respondsToSelector:@selector(didSelectedItemView:)])
//    {
//        [_delegate didSelectedItemView:self];
//    }
    if (_block != nil) {
     self.block(self);//调用block方法代替代理
    }
}

@end
