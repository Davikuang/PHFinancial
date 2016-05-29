//
//  ImageItem.h
//  equdao
//
//  Created by 匡 on 16/5/3.
//  Copyright © 2016年 boroo.me. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageItem : NSObject
@property (nonatomic,assign) BOOL isPleaseHolder;
@property (nonatomic,strong) NSString *imageName;
@property (nonatomic,strong) UIImage *image;
@end
