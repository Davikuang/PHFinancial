//
//  MyPageControl.m
//  PHFinancial
//
//  Created by 匡 on 16/5/31.
//  Copyright © 2016年 PuHuiFinancial. All rights reserved.
//

#import "MyPageControl.h"

@implementation MyPageControl

-(id) initWithCoder:(NSCoder *)aDecoder

{
    
    self = [super initWithCoder:aDecoder];
    
    [self setCurrentPage:1];
    
    return self;
    
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
//    activeImage = [UIImage imageNamed:@"red_fire"];
    
//    inactiveImage = [UIImage imageNamed:@"yellow_fire"];
    
    [self setCurrentPage:1];
    
    return self;
}

-(void) updateDots

{
    
    for (int i = 0; i < [self.subviews count]; i++)
        
    {
        
        UIView* dot = [self.subviews objectAtIndex:i];
        dot.size = CGSizeMake(4, 2);
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0,11, 3)];
        view.backgroundColor = [UIColor whiteColor];
        view.alpha = 0.28;
        dot.alpha = 0.28;
        [dot addSubview:view];
        if (i == self.currentPage) view.alpha = 1,dot.alpha = 1;
        
        else view.alpha = 0.28,dot.alpha = 0.28;
        
    }
    
}


-(void)setCurrentPage:(NSInteger)page

{
    
    [super setCurrentPage:page];
    
    [self updateDots];
    
}



@end
