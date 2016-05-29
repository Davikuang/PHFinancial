//
//  BaseModel.m
//  equdao
//
//  Created by 匡 on 15/8/4.
//  Copyright (c) 2015年 boroo.me. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel
- (id)initWithContentsWithDictionary:(NSMutableDictionary *)dic {
    self = [super init];
    dic = [dic mutableCopy];
    NSLog(@"*** dic *** %@",dic);
    
    if (self) {
        if (dic[@"oneOrOld"] != nil) {
            
        }
        if (dic[@"id"] != nil) {
            // 将服务器返回的系统关键字字段进行处理  所有是id的字段都改为mid
            [dic setValue:dic[@"id"] forKey:@"mid"];
        }
        [self setModelWithDictionary:dic];
    }
    
    return self;
    
}

// 通过字典设置属性值
- (void)setModelWithDictionary:(NSDictionary *)dic {
    
    NSArray *allKeys = [dic allKeys];
    
    for(int i = 0 ; i < allKeys.count ; i++){
        NSString *key = allKeys[i];
        if (key != nil) {
            // 将key转换成set方法 weibo ->setWeibo
            if ([key isEqualToString:@"newOrOld"]) {
                key = @"mNewOrOld";
            }
            
            NSString *first = [[key substringToIndex:1] uppercaseString];
            NSString *end = [key substringFromIndex:1];
            NSString *sel = [NSString stringWithFormat:@"set%@%@:",first,end];
            
            SEL setter = NSSelectorFromString(sel);
            
            if ([self respondsToSelector:setter]) {
                [self  performSelector:setter withObject:[dic objectForKey:key]];
            }
            
        }
        
    }
    
}@end
