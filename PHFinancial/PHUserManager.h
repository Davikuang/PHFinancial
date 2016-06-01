//
//  PHUserManager.h
//  PHFinancial
//
//  Created by 匡 on 16/5/26.
//  Copyright © 2016年 PuHuiFinancial. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PHUserManager : NSObject
+ (instancetype)shareManager;
@property (nonatomic, strong) NSString *token;

@property (nonatomic, strong) NSString *file_url;//图片的url
@property (nonatomic, strong) NSString *phone; //用户电话
@property (nonatomic, strong) NSString *password; //用户密码
// 保存用户帐号
+ (void)storeAccountInKeychain:(NSString*)Account;
// 获取用户账户
+ (NSString*)getAccountFromKeychain;
// 保存用户密码
+ (void)storePasswordInKeychain:(NSString*)psd;
// 获取用户密码
+ (NSString*)getPasswordFromKeychain;
@end
