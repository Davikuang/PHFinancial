//
//  HomeImageView.h
//  equdao
//
//  Created by 匡 on 15/9/6.
//  Copyright (c) 2015年 boroo.me. All rights reserved.
//
@protocol HomeImageDelegate <NSObject>

- (void)homeImageWithUrl:(NSString *)url;

@end
#import <UIKit/UIKit.h>

@interface HomeImageView : UIImageView
@property (nonatomic,strong) UITapGestureRecognizer *tap;
@property (nonatomic,strong) NSString *linkurl;
@property (nonatomic,copy) NSString *url;
@property (nonatomic,weak) id<HomeImageDelegate> imageDelegate;
@end
