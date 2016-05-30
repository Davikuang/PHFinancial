//
//  ViewController.h
//  照相机demo
//
//  Created by Jason on 11/1/16.
//  Copyright © 2016年 Jason. All rights reserved.
//
@protocol imageDelegate <NSObject>
// 传输图片协议
- (void)getImagesWithArray:(NSMutableArray *)array;

@end

#import <UIKit/UIKit.h>
#import "PostTicketViewController.h"
@interface DJCameraViewController : UIViewController
@property (nonatomic,weak) id<imageDelegate> imageDelegate;

@end

