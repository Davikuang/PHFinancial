//
//  BaseUtil.h
//  equdao
//
//  Created by 匡 on 15/8/4.
//  Copyright (c) 2015年 boroo.me. All rights reserved.
//
//#import "PhoneNumberModel.h"
#import <Foundation/Foundation.h>

@interface BaseUtil : NSObject

+(id)shareManager;
// 生成二维码
- (UIImage *)createQRImageWithUrl:(NSString *)url;
+ (BOOL)validateMobile:(NSString *)mobileNum;
+ (BOOL)isEmpty:(NSString*)str;
+(NSString *)md5:(NSString *)inPutText;
+(NSString *)md5SubString:(NSString *)inPutText;
+(NSString*)md532BitUpper:(NSString *)inPutText;
+(NSString*)md532BitLower:(NSString *)inPutText;
+(NSString*)MD5X:(NSString *)inPutText;

//+(void)postImages:(NSMutableArray *)datas withId:(id)delegate

// 拉伸图片
+ (UIImage *)stretchableImageWithLeftCapWidth:(float)width topCapHeight:(float)top withUImage:(UIImage *)image;


// 检测联通号码
+(BOOL)validateCMMobile:(NSString*)number;
// 分割电话号码
+(NSString *)dealTelePhoneNumber:(NSString*)number;
// 检测号码是否被占用
//+(BOOL)textNumber:(PhoneNumberModel *)model;

+ (NSString *)getAPPScheme;
+ (void)callAndBackWeb:(NSString *)phoneNum;
- (NSString *)getPath:(NSString *)name; // 获取本地路径 保存在Document文件夹下
//对图片尺寸进行压缩--
+(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;
+(UIImage *)addImage:(UIImage *)useImage addMsakImage:(UIImage *)maskImage msakRect:(CGRect)rect;//图片加水印
//拉伸图片
+ (UIImage *)setImageName:(NSString *)imageName withLeftCapWidth:(CGFloat)leftCapWidth withTopCapHeight:(CGFloat)topCapHeight;

// 根据时间戳转换成时间
+ (NSString *)getTimeWithDate:(NSNumber *)seconds;
// 验证身份证ID
+ (BOOL)validateIDCardNumber:(NSString *)value;
//时间戳转时间
+ (NSString *)timeWithNsnumber:(NSNumber *)number;

#pragma mark -- 获取导航栏下面的黑线
+ (UIImageView*)findHairlineImageunder:(UIView *)view;

#pragma mark -- 划线
+ (void)drawPathWithStartPoint:(CGPoint)startPoint withEndPoint:(CGPoint)endPoint withColor:(UIColor*)color;

#pragma mark -- view递归取出想要的View
+ (id)findSubViewOfClass:(Class)aClass inView:(UIView *)view;

#pragma mark -- 查看号码是否被占用
+(BOOL)textNumberW:(NSString *)simId;

//  计算lable的高度
+ (CGFloat)getLableHeigt:(UILabel *)lable withText:(NSString *)string withFont:(CGFloat)font;

// 生成签名
+ (NSString *)getSigWithDic:(NSDictionary *)dic;
// 生成一个带有sign 的URL
+ (NSString *)getUrlWithDic:(NSDictionary *)dic withHttp:(NSString*)url;

// 保存json类文件到 缓存文件夹下的 filePath中
+ (void)saveDataToPlist:(id)responseObject withPath:(NSString *)path;

+ (id)getDataFromPlistWithPath:(NSString *)path;


// 请求头状态码
+ (void)httpStateMessage:(NSString *)state;
// 网络返回状态码
+ (void)errorMesssage:(NSString *)state;

//  按照系统生成随机key访问的图片商品图片
+ (NSURL *)systemRandomlyGenerated:(NSString *)default_image;
+ (NSURL *)systemRandomlyGenerated:(NSString *)default_image type:(NSString *)type number:(NSString *)number;

// 随机生成6位字符串
+ (NSString *)ret6bitString;

@end
