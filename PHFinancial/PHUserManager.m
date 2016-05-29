//
//  PHUserManager.m
//  PHFinancial
//
//  Created by 匡 on 16/5/26.
//  Copyright © 2016年 PuHuiFinancial. All rights reserved.
//

#import "PHUserManager.h"
#import "SFHFKeychainUtils.h"

@implementation PHUserManager
static PHUserManager *userManager= nil;
+ (instancetype)shareManager
{
    if (!userManager) {
        userManager = [[PHUserManager alloc] init];
    }
    return userManager;
}

// 保存账户
+ (void)storeAccountInKeychain:(NSString*)Account
{
    if (Account) {
        [SFHFKeychainUtils storeUsername:kUserCount andPassword:Account
                          forServiceName:kUserCount updateExisting:YES error:nil];
    }
}


// 获取账户
+ (NSString*)getAccountFromKeychain
{
    NSString* key = [SFHFKeychainUtils getPasswordForUsername:kUserCount andServiceName:kUserCount error:nil];
    return key;
}

// 保存userId
+ (void)storeUserIdInKeychain:(NSString*)userId
{
    if (userId) {
        [SFHFKeychainUtils storeUsername:kUserId andPassword:userId
                          forServiceName:kUserId updateExisting:YES error:nil];
    }
}
// 获取userId
+ (NSString*)getUserIdFromKeychain
{
    NSString* key = [SFHFKeychainUtils getPasswordForUsername:kUserId andServiceName:kUserId error:nil];
    return key;
}

// 保存密码
+ (void)storePasswordInKeychain:(NSString*)psd
{
    if (psd) {
        [SFHFKeychainUtils storeUsername:kUserId andPassword:psd
                          forServiceName:kUserPassWord updateExisting:YES error:nil];
    }
}

// 获取密码
+ (NSString*)getPasswordFromKeychain
{
    NSString* key = [SFHFKeychainUtils getPasswordForUsername:kUserId andServiceName:kUserPassWord error:nil];
    return key;
}

// 清理 账户  密码   userId
+ (void)clearAccountInfo
{
    // 清理账户
    [SFHFKeychainUtils deleteItemForUsername:kUserCount andServiceName:kUserCount error:nil];
    // 清理密码
    [SFHFKeychainUtils deleteItemForUsername:kUserId andServiceName:kUserPassWord error:nil];
    // 清理UserID
    [SFHFKeychainUtils deleteItemForUsername:kUserId andServiceName:kUserId error:nil];
    
}

@end
