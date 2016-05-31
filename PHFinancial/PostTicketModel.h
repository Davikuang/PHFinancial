//
//  PostTicketModel.h
//  PHFinancial
//
//  Created by 匡 on 16/5/31.
//  Copyright © 2016年 PuHuiFinancial. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PostTicketModel : NSObject
@property (nonatomic,strong) NSString *draftType; // 票据类型
@property (nonatomic,strong) NSString *bankNmae;
@property (nonatomic,strong) NSString *postTime;
@property (nonatomic,strong) NSString *draftNumber;
@property (nonatomic,strong) NSString *restDay;
@property (nonatomic,copy) NSMutableArray *images;
@end
