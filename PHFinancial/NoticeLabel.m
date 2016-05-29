//
//  NoticeLabel.m
//  equdao
//
//  Created by 匡 on 16/3/3.
//  Copyright © 2016年 boroo.me. All rights reserved.
//

#import "NoticeLabel.h"

@implementation NoticeLabel
//注销观察者
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(messageCountChange:) name:kInfoNotification object:nil];
    }
    return self;
}

- (void)messageCountChange:(NSNotification *)notif {
    NSLog(@"%@",notif);
    NSNumber *num = notif.object;
    if ([num integerValue] < 1) {
        self.hidden = YES;
    }else {
        self.hidden = NO;
        self.text = [num stringValue];
    }
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kInfoNotification object:nil];
}
@end
