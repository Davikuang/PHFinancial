//
//  AppDelegate.m
//  PHFinancial
//
//  Created by PuhuiMac01 on 16/5/17.
//  Copyright © 2016年 PuHuiFinancial. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "LaunchViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate

// 每次从后台退出后  再次进入会走这个函数  如果有账号和密码就登录   账号和密码  密码需要加密保存
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [_window makeKeyAndVisible];
    _window.backgroundColor = [UIColor whiteColor];
    
   //首 次进入
//    if (![[NSUserDefaults standardUserDefaults] valueForKey:@"launchflag"]) {
//        NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
//        [userInfo setBool:YES forKey:@"launchflag"];
//        [userInfo synchronize];
//        
//        LaunchViewController *launchVC = [[LaunchViewController alloc] init];
//        _window.rootViewController = launchVC;
//        
//    }else {
    
        MainViewController *mainVC = [[MainViewController alloc] init];
        //        mainVC.adImage = image;
        _window.rootViewController = mainVC;
        
//    }
    
    if (k_phone&&k_password) {
        [self doLogin];
    }
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

// 将要进入后台
- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

// 从后台进入前台
- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

// 完全退出后台时走该函数
- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
    // 需要清除userId 企业ID 实名认证状态
    
    // 点击退出登录  与  从后台退出只清理userId  退出登录时密码userId 签名等所有数据都要清除
    
}

- (void)doLogin{
    
}

@end
