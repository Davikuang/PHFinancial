//
//  kHomeModel.h
//  equdao
//
//  Created by 匡 on 16/3/24.
//  Copyright © 2016年 boroo.me. All rights reserved.
//

#import "BaseModel.h"

@interface kHomeModel : BaseModel
@property (nonatomic,strong) NSMutableArray *adImages;
@property (nonatomic,strong) NSString *middleImage;
@property (nonatomic,strong) NSString *bottomImage;
@property (nonatomic,strong) NSNumber *account;
@property (nonatomic,strong) NSNumber *monthlyCount;
@end
