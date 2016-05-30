//
//  Confige.h
//  equdao
//
//  Created by 匡 on 15/8/4.
//  Copyright (c) 2015年 boroo.me. All rights reserved.
//

#ifndef equdao_Confige_h
#define equdao_Confige_h

//
//  Confige.h
//  equdao
//
//  Created by 匡 on 15/8/4.
//  Copyright (c) 2015年 boroo.me. All rights reserved.
//
//  外网接口
#define kHTTP @"http://www.equdao.com.cn"

#define nHTTP  @"http://192.168.30.172"
//#define kHTTP @"http://192.168.10.199"   // 苏的接口
//#define kHTTP @"http://192.168.10.75"
// 本地服务器 －－ 链接
//#define kHTTP @"http://192.168.10.215:9030"


// 客户端参数配置
#define kAPI_timestamp [NSString stringWithFormat:@"%ld",(long)[[NSDate date] timeIntervalSince1970]]
#define channel_key  @"922f460018319df14bbe7fcc62806b0d"
#define channel_secret  @"aa9dbdb3f0e8bce8fd8acbcb3a72b751"
#define APPVersion   [[[NSBundle mainBundle ] infoDictionary] objectForKey:@"CFBundleVersion"]


// 用于判断是哪类产品
typedef enum {
    
    PHONE_PROJECT = 1,
    FRUIT_PROJECT = 2,
    LIVING_PROJECT = 3,
    NETWORKINGCARD_PROJECT = 4,
    
}COMMONGOODS_TYPE;



// 代码适配  6
#define kScaleX [UIScreen mainScreen].bounds.size.width/375
#define kScaleY [UIScreen mainScreen].bounds.size.height/667

// 按照比例适配不同机型
#define CGRectMakeAT(x,y,w,h)     CGRectMake(x*kScaleX,y*kScaleY,w*kScaleX,h*kScaleY)


// 字体冬青黑
#define kHS_W6  [UIFont fontWithName:@"HiraginoSans-W6" size:(int)18*kAutoScaleX]
#define kHS_W6x  [UIFont fontWithName:@"HiraginoSans-W6" size:(int)13*kAutoScaleX]

//设备尺寸
#define kScreenWidth     [UIScreen mainScreen].bounds.size.width
#define kScreenHeight    [UIScreen mainScreen].bounds.size.height
#define kTabBarHeight  49.0f
#define kNavBar 64.0f

//主体颜色  颜色管理
#define kThemeColor @"d71d18" // 红色

// 字体颜色
#define kWORDCOLOR @"4F5E5E"
#define kBGCOLOR @"F3F3F3"

//用户账号
#define kUserCount    @"kUserCount" // 用户账号
#define kUserPassWord @"kUserPassWord" // 用户密码
#define kUserId    @"kUserId" // 用户ID

//获取缓存的password
#define k_password [[NSUserDefaults standardUserDefaults] objectForKey:@"kUserPassWord"]
//获取缓存的phone
#define k_phone [[NSUserDefaults standardUserDefaults] objectForKey:@"kUserCount"]
//获取缓存的name
#define k_nickName [[NSUserDefaults standardUserDefaults] objectForKey:@"nickname"]
// 获取userId 缓存
#define k_userid [[NSUserDefaults standardUserDefaults] objectForKey:@"kUserId"]


//

//ios系统版本
#define ios8x [[[UIDevice currentDevice] systemVersion] floatValue] >=8.0f
#define ios7x ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f) && ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0f)
#define ios6x [[[UIDevice currentDevice] systemVersion] floatValue] < 7.0f
#define iosNot6x [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f

#define iphone4x_3_5 ([UIScreen mainScreen].bounds.size.height==480.0f)

#define iphone5x_4_0 ([UIScreen mainScreen].bounds.size.height==568.0f)

#define iphone6_4_7 ([UIScreen mainScreen].bounds.size.height==667.0f)

#define iphone6Plus_5_5 ([UIScreen mainScreen].bounds.size.height==736.0f || [UIScreen mainScreen].bounds.size.height==414.0f)


//屏幕frame,bounds,size
#define kScreenFrame [UIScreen mainScreen].frame
#define kScreenBounds [UIScreen mainScreen].bounds
#define kScreenSize [UIScreen mainScreen].bounds.size

// 按钮高度
#define kBTNHEIGHT  (([UIScreen mainScreen].bounds.size.width) <= (320.0f) ? 38 : 40)

// 默认的收获地址
#define kADDRNAME    @"kADDRNAME"
#define kADDRNUMBER  @"kADDRNUMBER"
#define kADDRESS     @"kADDRESS"
#define kADDRTAG     @"kADDRTAG"
#define kADDRID      @"kADDRID"


// 启动广告通知

#define ADImageLoadSecussed @"ADImageLoadSecussed"
#define ADImageLoadFail @"ADImageLoadFail"
#define GuideViewControllerDidFinish @"GuideViewControllerDidFinish"

// 推送消息
#define kInfoNotification @"kInfoNotification"

// 黑色字体颜色
#define kBlackColor  @"595757"//@"050405"//@"597757"
// 数字字体颜色
#define kNumberColor @"e58440"
// 蓝色字体
#define kLitleBlue @"0094db"

// 购物车通知
#define kGoodsNumberADDNotification @"kGoodsNumberADDNotification"
#define kGoodsNumberDecreNotification @"kGoodsNumberDecreADDNotification"
// 第三方微信登录通知
#define kPostWXOpenID @"kPostWXOpenID"
#define kWXBundled @"kWXBundled"
// 新消息通知
#define K_NEWMESSAGES @"K_NEWMESSAGES"


/*---------------------------接口---------------------------*/
#define k_API_MESSAGECODE  [NSString stringWithFormat:@"%@/v1/user/regsms",nHTTP]
#define k_API_SENDIMAGE  [NSString stringWithFormat:@"%@/v1/dev/upfile/",nHTTP]

#endif


