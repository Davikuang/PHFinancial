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

#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件
#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件
@interface AppDelegate ()<BMKLocationServiceDelegate>
{
    BMKMapManager* _mapManager;
    BMKLocationService *_locService;
}
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
     [[UIApplication  sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    // 百度地图
    _mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret = [_mapManager start:@"在此处输入您的授权Key"  generalDelegate:nil];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    
    //初始化BMKLocationService
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    //启动LocationService
    [_locService startUserLocationService];
    [self login];
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
    
    NSLog(@"%@",[PHUserManager shareManager].token);

}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}

// 完全退出后台时走该函数
- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
    // 需要清除userId 企业ID 实名认证状态
    
    
    // 点击退出登录  与  从后台退出只清理userId  退出登录时密码userId 签名等所有数据都要清除
    
}

- (void)doLogin{
    
}

//实现相关delegate 处理位置信息更新
//处理方向变更信息
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    //NSLog(@"heading is %@",userLocation.heading);
}
//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    
    [[NSUserDefaults standardUserDefaults] setFloat:userLocation.location.coordinate.latitude forKey:@"coordX"];
     [[NSUserDefaults standardUserDefaults] setFloat:userLocation.location.coordinate.longitude forKey:@"coordY"];
}

- (void)login {
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.responseSerializer = [AFJSONResponseSerializer serializer];
    //申明返回的结果是json类型
    session.responseSerializer = [AFJSONResponseSerializer serializer];
    //申明请求的数据是json类型
    session.requestSerializer=[AFJSONRequestSerializer serializer];
    //如果报接受类型不一致请替换一致text/html或别的
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    // 默认帮助JSON解析，XML，NSXMLParser对象
    NSDictionary *dic = @{
                          };
    NSString *subUrl = [BaseUtil getUrlWithDic:dic withHttp:k_API_LOGIN];
    NSLog(@"subUrl %@",subUrl);
    
    
    NSDictionary *params = @{
                             @"mobile":[PHUserManager getAccountFromKeychain] ? [PHUserManager getAccountFromKeychain]:@"00000000000",
                             @"password":[BaseUtil md5:[PHUserManager getPasswordFromKeychain]?[PHUserManager getPasswordFromKeychain]:@"000000"],
                             @"coordX":kCoordX ? kCoordX:@0.0,
                             @"coordY":kCoordY ? kCoordY:@0.0,
                             };
    NSLog(@"params %@",params);
    
    [session POST:subUrl
       parameters:params
          success:^(NSURLSessionDataTask *task, id responseObject) {
              
              // 获取数据
              NSDictionary *dic = responseObject;
              NSLog(@"dic***  %@",dic);
              NSString *state = [NSString stringWithFormat:@"%@",dic[@"rec"]];
              NSLog(@" msg %@",dic[@"msg"]);
              if ([state isEqualToString:@"0"]) {
                  NSString *token = dic[@"data"][@"token"];
                  [PHUserManager shareManager].token = token;
              }else {
                  [BaseUtil errorMesssage:state];
              }
              NSLog(@"statusCode == %@",task);
          }
          failure:^(NSURLSessionDataTask *task, NSError *error) {
              [ProgressHUD dismiss];
              NSLog(@"task %@",task);
              NSLog(@"error %@",error);
          }];
}

@end
