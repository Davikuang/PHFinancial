//
//  BaseUtil.m
//  equdao
//
//  Created by 匡 on 15/8/4.
//  Copyright (c) 2015年 boroo.me. All rights reserved.
//

#import "BaseUtil.h"
#import <CommonCrypto/CommonDigest.h>
@implementation BaseUtil

// 1.创建单例
+ (id)shareManager {
    static BaseUtil *manager = nil;
    if (self == nil) {
        manager = [[BaseUtil alloc] init];
    }
    return manager;
}

// 2.创建单例
+ (BaseUtil *)shareOnceManger {
    static BaseUtil *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

// 3.创建单例
+ (BaseUtil *)shareZoneManger {
    static BaseUtil *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self allocWithZone:NULL] init];
    });
    return manager;
}

// 生成二维码图片

- (UIImage *)createQRImageWithUrl:(NSString *)url{
//    NSString *url = @"https://open.weixin.qq.com/connect/oauth2/authorize?appid=wxfe0197c1611b0c21&redirect_uri=http%3A%2F%2Fwww.equdao.com.cn%2FweixinController%3FSAccessToken&response_type=code&scope=snsapi_userinfo&state=equdao#wechat_redirect";
    // Do any additional setup after loading the view, typically from a nib.
    UIImage *qrcode = [self createNonInterpolatedUIImageFormCIImage:[self createQRForString:url] withSize:250.0f];
    UIImage *customQrcode = [self imageBlackToTransparent:qrcode withRed:60.0f andGreen:74.0f andBlue:89.0f];
    return customQrcode;
}


#pragma mark - InterpolatedUIImage
- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size {
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    // create a bitmap image that we'll draw into a bitmap context at the desired size;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    // Create an image with the contents of our bitmap
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    // Cleanup
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}

#pragma mark - QRCodeGenerator
- (CIImage *)createQRForString:(NSString *)qrString {
    // Need to convert the string to a UTF-8 encoded NSData object
    NSData *stringData = [qrString dataUsingEncoding:NSUTF8StringEncoding];
    // Create the filter
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // Set the message content and error-correction level
    [qrFilter setValue:stringData forKey:@"inputMessage"];
    [qrFilter setValue:@"M" forKey:@"inputCorrectionLevel"];
    // Send the image back
    return qrFilter.outputImage;
}

#pragma mark - imageToTransparent
void ProviderReleaseData (void *info, const void *data, size_t size){
    free((void*)data);
}
- (UIImage*)imageBlackToTransparent:(UIImage*)image withRed:(CGFloat)red andGreen:(CGFloat)green andBlue:(CGFloat)blue{
    const int imageWidth = image.size.width;
    const int imageHeight = image.size.height;
    size_t      bytesPerRow = imageWidth * 4;
    uint32_t* rgbImageBuf = (uint32_t*)malloc(bytesPerRow * imageHeight);
    // create context
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(rgbImageBuf, imageWidth, imageHeight, 8, bytesPerRow, colorSpace,
                                                 kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipLast);
    CGContextDrawImage(context, CGRectMake(0, 0, imageWidth, imageHeight), image.CGImage);
    // traverse pixe
    int pixelNum = imageWidth * imageHeight;
    uint32_t* pCurPtr = rgbImageBuf;
    for (int i = 0; i < pixelNum; i++, pCurPtr++){
        if ((*pCurPtr & 0xFFFFFF00) < 0x99999900){
            // change color
            uint8_t* ptr = (uint8_t*)pCurPtr;
            ptr[3] = red; //0~255
            ptr[2] = green;
            ptr[1] = blue;
        }else{
            uint8_t* ptr = (uint8_t*)pCurPtr;
            ptr[0] = 0;
        }
    }
    // context to image
    CGDataProviderRef dataProvider = CGDataProviderCreateWithData(NULL, rgbImageBuf, bytesPerRow * imageHeight, ProviderReleaseData);
    CGImageRef imageRef = CGImageCreate(imageWidth, imageHeight, 8, 32, bytesPerRow, colorSpace,
                                        kCGImageAlphaLast | kCGBitmapByteOrder32Little, dataProvider,
                                        NULL, true, kCGRenderingIntentDefault);
    CGDataProviderRelease(dataProvider);
    UIImage* resultUIImage = [UIImage imageWithCGImage:imageRef];
    // release
    CGImageRelease(imageRef);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    return resultUIImage;
}

// 生成二维码

// 检测特殊《》字段
+ (void)validate:(NSString *)text {
    
    NSString *valied = @"《([^》]*)》";
    //    NSString *valied2 =  @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", valied];
    
    if ([regextestmobile evaluateWithObject:text] == YES)
    {
        NSLog(@"检测到 《》");
    }else {
        NSLog(@"没有检测到");
    }
    
//    NSString *contentStr = @"简介：hello world";
//    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:contentStr];
//    //设置：在0-3个单位长度内的内容显示成红色
//    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 3)];
//    label.attributedText = str;
    
}

+ (BOOL)validateMobile:(NSString *)mobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    
    /**
     10         * 中国移动：China Mobile
     * 移动号段：134/135/136/137/138/139/150/151/152/157/158/159/182/183/184/187/188/147/178
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|4[7]|5[0127-9]|7[8]|8[23478])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     * 联通号段:130/131/132/155/156/185/186/145/176
     17         */
    NSString * CU = @"^1(3[0-2]|4[5]|5[56]|7[06]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189 新增181 177
     22         */
    NSString * CT = @"^1((33|53|8[09]|81|77)[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

+ (BOOL)validateCMMobile:(NSString *)mobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    
    // 中国联通
    NSString * CM = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     * 移动号段：134/135/136/137/138/139/150/151/152/157/158/159/182/183/184/187/188/147/178
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
//    NSString * CM = @"^1(34[0-8]|(3[5-9]|4[7]|5[0127-9]|7[8]|8[23478])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     * 联通号段:130/131/132/155/156/185/186/145/176
     17         */
//    NSString * CU = @"^1(3[0-2]|4[5]|5[56]|7[06]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
//    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
//    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
//    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
//    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if ([regextestcm evaluateWithObject:mobileNum] == YES)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}


+ (BOOL)isEmpty:(NSString*)str
{
    if (str == nil || [str length] == 0) {
        return YES;
    } else {
        return NO;
    }
}

//*************************MD5************************************//
+(NSString *)md5:(NSString *)inPutText
{
    const char *cStr = [inPutText UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, strlen(cStr), result);
    return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];
}


+(NSString*)md532BitLower:(NSString *)inPutText
{
    const char *cStr = [inPutText UTF8String];
    unsigned char result[16];
    NSNumber *num = [NSNumber numberWithUnsignedLong:strlen(cStr)];
    CC_MD5( cStr,[num intValue], result );
    return [[NSString stringWithFormat:
             @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];
}

+(NSString*)MD5X:(NSString *)inPutText {
    
    NSString *md5 = [BaseUtil md532BitUpper:inPutText];
    
    NSString *m = [md5 stringByAppendingString:@"HXWcjvQWVG1wI4FQBLZpQ3pWj48AV63d"];
   return [BaseUtil md532BitUpper:m];
}

+(NSString*)md532BitUpper:(NSString *)inPutText
{
    const char *cStr = [inPutText UTF8String];
    unsigned char result[16];
    NSNumber *num = [NSNumber numberWithUnsignedLong:strlen(cStr)];
    CC_MD5( cStr,[num intValue], result );
    return [[NSString stringWithFormat:
             @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] uppercaseString];
}

+ (void)callAndBackWeb:(NSString *)phoneNum
{
    //    NSString *phoneNum = @"10086";// 电话号码
    
    NSURL *phoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",phoneNum]];
    [[UIApplication sharedApplication] openURL:phoneURL];
    
    //    UIWebView *phoneCallWebView = nil;
    //    if (!phoneCallWebView) {
    //        phoneCallWebView = [[UIWebView alloc] initWithFrame:CGRectZero];
    //        // 这个webView只是一个后台的容易 不需要add到页面上来  效果跟方法二一样 但是这个方法是合法的
    //    }
    //    [phoneCallWebView loadRequest:[NSURLRequest requestWithURL:phoneURL]];
}

+ (void)errorMesssage:(NSString *)state
{
    if ([state isEqualToString:@"0"]) {
        [[TKAlertCenter defaultCenter] postAlertWithMessage:@"操作成功"];
    }
    if ([state isEqualToString:@"1"]) {
        [[TKAlertCenter defaultCenter] postAlertWithMessage:@"操作失败"];
    }
    if ([state isEqualToString:@"2"]) {
        [[TKAlertCenter defaultCenter] postAlertWithMessage:@"禁止访问"];
    }
    if ([state isEqualToString:@"3"]) {
        [[TKAlertCenter defaultCenter] postAlertWithMessage:@"登录后允许访问"];
    }
    if ([state isEqualToString:@"4"]) {
        [[TKAlertCenter defaultCenter] postAlertWithMessage:@"参数错误"];
    }
    if ([state isEqualToString:@"5"]) {
        [[TKAlertCenter defaultCenter] postAlertWithMessage:@"未知错误"];
    }
}

// 请求头状态说明
+ (void)httpStateMessage:(NSString *)state{
    if ([state isEqualToString:@"200"]) {
        [[TKAlertCenter defaultCenter] postAlertWithMessage:@"请求成功"];
    }
    if ([state isEqualToString:@"400"]) {
        [[TKAlertCenter defaultCenter] postAlertWithMessage:@"Bad Request"];
    }
    if ([state isEqualToString:@"401"]) {
        [[TKAlertCenter defaultCenter] postAlertWithMessage:@"Unauthorized"];
    }
    if ([state isEqualToString:@"403"]) {
        [[TKAlertCenter defaultCenter] postAlertWithMessage:@"Forbidden"];
    }
    if ([state isEqualToString:@"404"]) {
        [[TKAlertCenter defaultCenter] postAlertWithMessage:@"page not found"];
    }
    if ([state isEqualToString:@"500"]) {
        [[TKAlertCenter defaultCenter] postAlertWithMessage:@"Internal Server Error"];
    }
    if ([state isEqualToString:@"502"]) {
        [[TKAlertCenter defaultCenter] postAlertWithMessage:@"Bad Gateway"];
    }
    if ([state isEqualToString:@"503"]) {
        [[TKAlertCenter defaultCenter] postAlertWithMessage:@"Service Unavailable"];
    }
    if ([state isEqualToString:@"504"]) {
        [[TKAlertCenter defaultCenter] postAlertWithMessage:@"Gateway Timeout"];
    }
}

//获取配置在URL Type中的的APP Scheme
+ (NSString *)getAPPScheme
{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Info" ofType:@"plist"];
    NSDictionary *dic = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    NSArray *urls = [dic objectForKey:@"CFBundleURLTypes"];
    return [[[urls firstObject] objectForKey:@"CFBundleURLSchemes"] firstObject];
}

+ (void)drawShadow:(UIView *)view shadowHeight:(CGFloat)height;
{
    //the colors for the gradient.  highColor is at the top, lowColor as at the bottom
    UIColor *highColor = [UIColor colorWithWhite:1.000 alpha:1.000];
    UIColor *lowColor = [UIColor colorWithRed:0.851 green:0.859 blue:0.867 alpha:1.000];
    
    //The gradient, simply enough.  It is a rectangle
    CAGradientLayer *gradient = [CAGradientLayer layer];
    [gradient setFrame:[view bounds]];
    [gradient setColors:[NSArray arrayWithObjects:(id)[highColor CGColor], (id)[lowColor CGColor], nil]];
    
    //the rounded rect, with a corner radius of 6 points.
    //this *does* maskToBounds so that any sublayers are masked
    //this allows the gradient to appear to have rounded corners
    CALayer *roundRect = [CALayer layer];
    [roundRect setFrame:[view bounds]];
    [roundRect setCornerRadius:3.0f];
    [roundRect setMasksToBounds:YES];
    [roundRect addSublayer:gradient];
    
    //add the rounded rect layer underneath all other layers of the view
    [[view layer] insertSublayer:roundRect atIndex:0];
    
    //set the shadow on the view's layer
    [[view layer] setShadowColor:[[UIColor blackColor] CGColor]];
    [[view layer] setShadowOffset:CGSizeMake(0, height)];
    [[view layer] setShadowOpacity:1.0];
    [[view layer] setShadowRadius:3.0];
}

//对图片尺寸进行压缩--
+(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}

// 保存在Document文件夹下
+ (NSString *)getPath:(NSString *)name {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];
    NSString *path = [docDir stringByAppendingString:name];
    return path;
}

+(UIImage *)addImage:(UIImage *)useImage addMsakImage:(UIImage *)maskImage msakRect:(CGRect)rect
{
    UIGraphicsBeginImageContext(useImage.size);
    [useImage drawInRect:CGRectMake(0, 0, useImage.size.width, useImage.size.height)];
    
    //四个参数为水印图片的位置
    [maskImage drawInRect:rect];
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultingImage;
}


// 图片添加水印
- (UIImage *)generate:(UIImage *)pimage imageWith:(float)width imageHeight:(float)height
{
    // start
    UIGraphicsBeginImageContext(CGSizeMake(width,height));
    [pimage drawInRect:CGRectMake(0.f, 0.f,width,height)];
    // (2) 文字
    NSString *water = @"e渠道业务专用";
    // 设置断落风格
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.alignment = NSTextAlignmentCenter;
    // 字体对象
    UIFont *font = [UIFont systemFontOfSize:18];
    NSDictionary *attributes = @{
                                 
                                 NSFontAttributeName : font,
                                 NSBackgroundColorAttributeName : [UIColor clearColor],
                                 NSStrokeColorAttributeName:[UIColor redColor],
                                 NSForegroundColorAttributeName:[UIColor redColor],
                                 NSParagraphStyleAttributeName : style
                                 
                                 };
    
    [water drawInRect:CGRectMake(0.f, 50.f, 200.f, 40.f) withAttributes:attributes];
    
    // 从上下文得到图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    // end
    UIGraphicsEndImageContext();
    
    return image;
}


// 手动添加限制
+ (void)addConstraints:(id)object{
//    [object addConstraints:@[
//                           [NSLayoutConstraint constraintWithItem:nil attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:object attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0],
//                           [NSLayoutConstraint constraintWithItem:nil attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:object attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0],
//                           [NSLayoutConstraint constraintWithItem:nil attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:object attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0],
//                           [NSLayoutConstraint constraintWithItem:nil attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:object attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.0],
//                           ]];
}



// 移除观察者 键盘
+ (void)removeObserver{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
}


+ (UIImage *)setImageName:(NSString *)imageName withLeftCapWidth:(CGFloat)leftCapWidth withTopCapHeight:(CGFloat)topCapHeight{
    UIImage *newImage;
    UIImage *image = [UIImage imageNamed:imageName];
        newImage = [image stretchableImageWithLeftCapWidth:leftCapWidth topCapHeight:topCapHeight];
    return newImage;
}

// 根据时间戳得到日期
+ (NSString *)getTimeWithDate:(NSNumber*)seconds{
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[seconds floatValue]/1000];
    
    NSString *time = [formatter stringFromDate:date];
    

    return time;
    
}

+ (BOOL)validateIDCardNumber:(NSString *)value {
    value = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSLog(@" value %@",value);
    int length =0;
    if (!value) {
        return NO;
    }else {
        length = value.length;
        
        if (length !=15 && length !=18) {
            return NO;
        }
    }
    // 省份代码
    NSArray *areasArray =@[@"11",@"12", @"13",@"14", @"15",@"21", @"22",@"23", @"31",@"32", @"33",@"34", @"35",@"36", @"37",@"41", @"42",@"43", @"44",@"45", @"46",@"50", @"51",@"52", @"53",@"54", @"61",@"62", @"63",@"64", @"65",@"71", @"81",@"82", @"91"];
    
    NSString *valueStart2 = [value substringToIndex:2];
    BOOL areaFlag =NO;
    for (NSString *areaCode in areasArray) {
        if ([areaCode isEqualToString:valueStart2]) {
            areaFlag =YES;
            break;
        }
    }
    
    if (!areaFlag) {
        return false;
    }
    
    
    NSRegularExpression *regularExpression;
    NSUInteger numberofMatch;
    
    int year =0;
    switch (length) {
        case 15:
            year = [value substringWithRange:NSMakeRange(6,2)].intValue +1900;
            
            if (year %4 ==0 || (year %100 ==0 && year %4 ==0)) {
                
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}$"
                                                                       options:NSRegularExpressionCaseInsensitive
                                                                         error:nil];//测试出生日期的合法性
            }else {
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}$"
                                                                       options:NSRegularExpressionCaseInsensitive
                                                                         error:nil];//测试出生日期的合法性
            }
            numberofMatch = [regularExpression numberOfMatchesInString:value
                                                              options:NSMatchingReportProgress
                                                                range:NSMakeRange(0, value.length)];
            
            
            if(numberofMatch >0) {
                return YES;
            }else {
                return NO;
            }
        case 18:
            
            year = [value substringWithRange:NSMakeRange(6,4)].intValue;
            if (year %4 ==0 || (year %100 ==0 && year %4 ==0)) {
                
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}[0-9Xx]$"
                                                                       options:NSRegularExpressionCaseInsensitive
                                                                         error:nil];//测试出生日期的合法性
            }else {
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}[0-9Xx]$"
                                                                       options:NSRegularExpressionCaseInsensitive
                                                                         error:nil];//测试出生日期的合法性
            }
            numberofMatch = [regularExpression numberOfMatchesInString:value
                                                              options:NSMatchingReportProgress
                                                                range:NSMakeRange(0, value.length)];
            
            
            if(numberofMatch >0) {
                int S = ([value substringWithRange:NSMakeRange(0,1)].intValue + [value substringWithRange:NSMakeRange(10,1)].intValue) *7 + ([value substringWithRange:NSMakeRange(1,1)].intValue + [value substringWithRange:NSMakeRange(11,1)].intValue) *9 + ([value substringWithRange:NSMakeRange(2,1)].intValue + [value substringWithRange:NSMakeRange(12,1)].intValue) *10 + ([value substringWithRange:NSMakeRange(3,1)].intValue + [value substringWithRange:NSMakeRange(13,1)].intValue) *5 + ([value substringWithRange:NSMakeRange(4,1)].intValue + [value substringWithRange:NSMakeRange(14,1)].intValue) *8 + ([value substringWithRange:NSMakeRange(5,1)].intValue + [value substringWithRange:NSMakeRange(15,1)].intValue) *4 + ([value substringWithRange:NSMakeRange(6,1)].intValue + [value substringWithRange:NSMakeRange(16,1)].intValue) *2 + [value substringWithRange:NSMakeRange(7,1)].intValue *1 + [value substringWithRange:NSMakeRange(8,1)].intValue *6 + [value substringWithRange:NSMakeRange(9,1)].intValue *3;
                int Y = S %11;
                NSString *M =@"F";
                NSString *JYM =@"10X98765432";
                M = [JYM substringWithRange:NSMakeRange(Y,1)];// 判断校验位
                if ([M isEqualToString:[value substringWithRange:NSMakeRange(17,1)]]) {
                    return YES;// 检测ID的校验位
                }else {
                    return NO;
                }
                
            }else {
                return NO;
            }
        default:
            return false;
    }
}

#pragma mark 处理电话号码
+(NSString *)dealTelePhoneNumber:(NSString*)number {
    if (number.length != 11) {
        return nil;
    }
    NSRange range1 = {0,3};
    NSString *str1 = [number substringWithRange:range1];
    NSRange range2 = {3,4};
    NSString *str2 = [number substringWithRange:range2];
    NSRange range3 = {7,4};
    NSString *str3 = [number substringWithRange:range3];
    
    return [NSString stringWithFormat:@"%@ %@ %@",str1,str2,str3];
}


#pragma mark -- 上传照片
+(void)postImages:(NSMutableArray *)datas withId:(id)delegate
{
    
    SCLAlertView *alert = [[SCLAlertView alloc] init];
    
    alert.showAnimationType = SlideInToCenter;
    alert.hideAnimationType = SlideOutFromCenter;
    
    alert.backgroundType = Transparent;
    
    [alert showWaiting:delegate title:@"等待..."
              subTitle:@"图片正在上传"
      closeButtonTitle:nil duration:59.0f];
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    NSDictionary *dic = @{
                          @"userId" : [[NSUserDefaults standardUserDefaults] valueForKey:kUserId], //
                          @"mobile" : [[NSUserDefaults standardUserDefaults] valueForKey:kUserCount],// 注册手机号
                          };
    
    [session POST:@""
       parameters:dic
constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
    //添加上传的数据
    for (int i = 0; i < datas.count; i++) {
        
        NSDictionary *dic = datas[i];
        
        [formData appendPartWithFileData:[dic allValues][0]
                                    name:[dic allKeys][0]
                                fileName:[NSString stringWithFormat:@"image%@.jpg",[dic allKeys][0]]//
                                mimeType:@"image/jpeg"];
    }
}
          success:^(NSURLSessionDataTask *task, id responseObject) {
              [alert hideView];
              NSLog(@"responseObject : %@", responseObject);
              NSDictionary *dic = responseObject;
              NSLog(@"dic %@",dic);
              [[TKAlertCenter defaultCenter] postAlertWithMessage:@"图片上传成功"];
              if ([dic[@"resultCode"] isEqualToString:@"SUCCESS"]) {
                  // 隐藏状态
              }
              
              UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"已提交申请，请耐心等待" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
              [alert show];
              return ;
              
          }
          failure:^(NSURLSessionDataTask *task, NSError *error) {
              [alert hideView];
              [[TKAlertCenter defaultCenter] postAlertWithMessage:@"图片上传失败"];
              
              NSLog(@"error : %@", error);
              
          }];
}


+ (NSString *)timeWithNsnumber:(NSNumber *)number {
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[number floatValue]/1000];
    
    NSString *time = [formatter stringFromDate:date];
    return time;
}


#pragma mark -- 拉伸图片
+ (UIImage *)stretchableImageWithLeftCapWidth:(float)width topCapHeight:(float)top withUImage:(UIImage *)image{
    return [image stretchableImageWithLeftCapWidth:width topCapHeight:top];
}

#pragma mark -- 获取导航栏下面的黑线
+ (UIImageView*)findHairlineImageunder:(UIView *)view {
    
    if ([view isKindOfClass:[UIImageView class]] && view.size.height <= 1) {
        return (UIImageView*)view;
    }
    
    for (UIView *subView in view.subviews) {
        
        UIImageView *imageView = [self findHairlineImageunder:subView];
        if (imageView) {
            return imageView;
        }
        
    }
    return nil;
}


#pragma mark -- 划线

+ (void)drawPathWithStartPoint:(CGPoint)startPoint withEndPoint:(CGPoint)endPoint withColor:(UIColor*)color
 {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineCap(context, kCGLineCapButt);
    CGContextSetLineWidth(context, 2);  //线宽
    CGContextSetAllowsAntialiasing(context, true);
    CGContextSetRGBStrokeColor(context, 70.0 / 255.0, 241.0 / 255.0, 241.0 / 255.0, 1.0);  //线的颜色
    CGContextBeginPath(context);
    
    CGContextMoveToPoint(context,startPoint.x,startPoint.y);  //起点坐标
    CGContextAddLineToPoint(context,endPoint.x,endPoint.y);   //终点坐标
    
    CGContextStrokePath(context);
}

#pragma mark -- view递归
+ (id)findSubViewOfClass:(Class)aClass inView:(UIView *)view{
    for (id subView in view.subviews) {
        if ([subView isKindOfClass:aClass]) {
            return subView;
        }else {
            //
            id view = [self findSubViewOfClass:aClass inView:subView];
            if (view) {
                return view;
            }
        }
    }
    return nil;
}



- (id)AFNetWorkingWithParam:(NSDictionary *)dic withUrl:(NSString *)url withInModel:(BaseModel *)model
{
    __block BaseModel *Mmodel = model;
    // 创建会话对象
    NSMutableDictionary *mdic = [NSMutableDictionary dictionaryWithDictionary:dic];
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.responseSerializer = [AFJSONResponseSerializer serializer];
    [session POST:url
      parameters:mdic
         success:^(NSURLSessionDataTask *task, id responseObject) {
             NSLog(@"responseObject : %@", responseObject);
             NSDictionary *dic = responseObject;
             NSString *state = dic[@"resultCode"];
             NSLog(@" msg %@",dic[@"msg"]);
             if ([state isEqualToString:@"SUCCESS"]) {
                 Mmodel = [[[model class] alloc] initWithDictionary:dic[@"data"]];
//                return Mmodel;
             }else {
                 [[TKAlertCenter defaultCenter] postAlertWithMessage:dic[@"msg"]];
             }
//             return Mmodel;
         }
         failure:^(NSURLSessionDataTask *task, NSError *error) {
             [[TKAlertCenter defaultCenter] postAlertWithMessage:@"网络繁忙稍后重试!"];
         }];
    return Mmodel;
}

// 计算lable的高度
+ (CGFloat)getLableHeigt:(UILabel *)lable withText:(NSString *)string withFont:(CGFloat)font{
    lable.font = [UIFont systemFontOfSize:font];
    lable.text = string;
    //设置一个行高上限
    lable.numberOfLines = 0;
    lable.lineBreakMode = NSLineBreakByWordWrapping;
    CGSize size = [lable sizeThatFits:CGSizeMake(lable.frame.size.width, MAXFLOAT)];
    return size.height;
}

// 保存json类文件到 缓存文件夹下的 filePath中
+ (void)saveDataToPlist:(id)responseObject withPath:(NSString *)path{
    
    // 保存到plist文件夹中
    NSData *kdata = [NSKeyedArchiver archivedDataWithRootObject:responseObject];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);                                                                                   NSString *plistPath1 = [paths lastObject];
    
    NSString *plistPath = [NSString stringWithFormat:@"%@.plist",path];
    
    //得到完整的文件名
    NSString *filename=[plistPath1 stringByAppendingPathComponent:plistPath];
    NSLog(@"filename ** %@",filename);
    [kdata writeToFile:filename atomically:YES];
    
}


//封装的sig 按字母顺序排列
+ (NSString *)getSigWithDic:(NSDictionary *)dic
{
    NSArray *keyArr = dic.allKeys;
    NSArray *kArr = [keyArr sortedArrayUsingSelector:@selector(compare:)];
    
    NSMutableString *str = [NSMutableString string];
    for (int i = 0; i < kArr.count; i++) {
        [str appendString:[NSString stringWithFormat:@"%@=%@",kArr[i],[dic objectForKey:kArr[i]]]];
        
    }
    // 拼接一个钥匙串
    [str appendString:channel_secret];
   NSString *mad5Str = [BaseUtil md5:str];
    return mad5Str;
}
// 生成一个带有sign 的URL
+ (NSString *)getUrlWithDic:(NSDictionary *)spDic withHttp:(NSString*)url
{
    // 固定签名写在里面  只需要写入特殊的签名参数
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:channel_key forKey:@"channel"];
    [dic setObject:kAPI_timestamp forKey:@"time"];
    
    NSArray *sDicKeys = spDic.allKeys;
    for (int i = 0; i<sDicKeys.count; i++) {
        [dic setObject:spDic[sDicKeys[i]] forKey:sDicKeys[i]];
    }
    
    NSLog(@"dic *** -- %@",dic);
    NSArray *keyArr = dic.allKeys;
    NSMutableString *str = [NSMutableString string];
    for (int i = 0; i < keyArr.count; i++) {
        if (i == 0) {
            [str appendString:[NSString stringWithFormat:@"?%@=%@",keyArr[i],[dic objectForKey:keyArr[i]]]];
        }else{
             [str appendString:[NSString stringWithFormat:@"&%@=%@",keyArr[i],[dic objectForKey:keyArr[i]]]];
        }
       
        
    }
    NSString *sign = [self getSigWithDic:dic];
    // 拼接一个钥匙串
    [str appendFormat:@"&sign=%@",sign];
   NSString *newUrl = [url stringByAppendingString:str];
    
    return newUrl;
}

#pragma mark --获取本地缓存文件夹下的数据
+ (id)getDataFromPlistWithPath:(NSString *)path {
    // 获取Library中的Cache
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);                                                                                   NSString *plistPath11 = [paths lastObject];
    //得到完整的文件名
    NSString *plistPath = [NSString stringWithFormat:@"%@.plist",path];
    NSString *filename1=[plistPath11 stringByAppendingPathComponent:plistPath];
    NSLog(@"filename1  ** %@",filename1);

    NSData *udata = [NSData dataWithContentsOfFile:filename1];
    id responseObject = [NSKeyedUnarchiver unarchiveObjectWithData:udata];
    return responseObject;
}


//  按照系统生成随机key访问的图片商品图片
+ (NSURL *)systemRandomlyGenerated:(NSString *)default_image
{
    
    NSArray *arr =[default_image componentsSeparatedByString:@"|"];
    NSString *timeStr = [arr objectAtIndex:1];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyyMM"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timeStr doubleValue]];
    NSString *dataStr = [formatter stringFromDate:date];
    
    NSString *string2 = [arr objectAtIndex:2];
    
    NSString *allStr = [NSString stringWithFormat:@"%@11/%@/%@/%@_%@_1.jpg",[PHUserManager shareManager].file_url,dataStr,[[string2 substringWithRange:NSMakeRange(0, 2)] lowercaseString],timeStr,[string2 lowercaseString]];
    
    NSURL *url = [NSURL URLWithString:allStr];
    return url;
    
}


+ (NSURL *)systemRandomlyGenerated:(NSString *)default_image type:(NSString *)type number:(NSString *)number
{
    if (default_image.length < 10) {
        return nil;
    }
    NSArray *arr =[default_image componentsSeparatedByString:@"|"];
    if ([[arr objectAtIndex:1] length]) {
        NSString *timeStr = [arr objectAtIndex:1];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        [formatter setDateFormat:@"yyyyMM"];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timeStr doubleValue]];
        NSString *dataStr = [formatter stringFromDate:date];
        
        NSString *string2 = [arr objectAtIndex:2];
        
        NSString *allStr;
        if ([number isEqualToString:@""]) {
            allStr = [NSString stringWithFormat:@"%@%@/%@/%@/%@_%@.jpg",[PHUserManager shareManager].file_url,arr.firstObject,dataStr,[[string2 substringWithRange:NSMakeRange(0, 2)] lowercaseString],timeStr,[string2 lowercaseString]];
        }else{
            allStr = [NSString stringWithFormat:@"%@%@/%@/%@/%@_%@_%@.jpg",[PHUserManager shareManager].file_url,arr.firstObject,dataStr,[[string2 substringWithRange:NSMakeRange(0, 2)] lowercaseString],timeStr,[string2 lowercaseString],number];
        }
        
        NSURL *url = [NSURL URLWithString:allStr];
        return url;
    }
    
    return nil;
}

#pragma mark 随机生成 6位字符串
+ (NSString *)ret6bitString

{
    
    char data[6];
    
    for (int x=0;x<6;data[x++] = (char)('A' + (arc4random_uniform(26))));
    
    return [[NSString alloc] initWithBytes:data length:6 encoding:NSUTF8StringEncoding];
    
}

@end
