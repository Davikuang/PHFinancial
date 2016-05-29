//
//  PHFManager.h
//  PHFinancial
//
//  Created by PuhuiMac01 on 16/5/18.
//  Copyright © 2016年 PuHuiFinancial. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PHFManager : NSObject

+ (instancetype)shareManager;

// 保存密码
+ (void)storePasswordInKeychain:(NSString*)psd;
+ (NSString*)getPasswordFromKeychain;

// 保存账户
+ (void)storeAccountInKeychain:(NSString*)Account;
// 获取账户
+ (NSString*)getAccountFromKeychain;

// 保存userId
+ (void)storeUserIdInKeychain:(NSString*)userId;
// 获取userId
+ (NSString*)getUserIdFromKeychain;

// 清理  账户  userID 密码
+ (void)clearAccountInfo;



@end
