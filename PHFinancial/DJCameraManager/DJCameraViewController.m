//
//  ViewController.m
//  照相机demo
//
//  Created by Jason on 11/1/16.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import "DJCameraViewController.h"
#import "PhotoViewController.h"
#import "UIButton+DJBlock.h"
#import "DJCameraManager.h"
#import "UIViewExt.h"
#import "DJImageCollectionView.h"
#import "ImageItem.h"

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
#define AppWidth [[UIScreen mainScreen] bounds].size.width
#define AppHeigt [[UIScreen mainScreen] bounds].size.height
@interface DJCameraViewController () <DJCameraManagerDelegate>
{
    UIView *_bgView;
    DJImageCollectionView *_collectionView;
}
@property (nonatomic,strong)DJCameraManager *manager;
@end

@implementation DJCameraViewController


/**
 *  在页面结束或出现记得开启／停止摄像
 *
 *  @param animated
 */
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.view.backgroundColor = [UIColor blackColor];
    if (![self.manager.session isRunning]) {
        [self.manager.session startRunning];
    }
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if ([self.manager.session isRunning]) {
        [self.manager.session stopRunning];
    }
}


- (void)dealloc
{
    NSLog(@"照相机释放了");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initLayout];
    [self initPickButton];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(10, 20, 50, 40);
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(doBack:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:backBtn];
}

- (void)doBack:(UIButton *)sender {
    
    // 将上传成功的图片返回给上一个页面
    
    if (_collectionView.datalist.count >= 2) {
        [_collectionView.datalist removeLastObject];
        [self.imageDelegate getImagesWithArray:_collectionView.datalist];
    }
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)initLayout
{
    self.view.backgroundColor = [UIColor blackColor];
    
    UIView *pickView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, AppWidth, AppWidth-50)];
    [self.view addSubview:pickView];
    
    _bgView = [[UIView alloc] initWithFrame:CGRectMake(0,pickView.bottom, self.view.frame.size.width, 120)];
    _bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_bgView];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];

    flowLayout.minimumLineSpacing = 0;
    
    
    flowLayout.minimumInteritemSpacing = 0;
    
    _collectionView = [[DJImageCollectionView alloc] initWithFrame:CGRectMake(0, 0, _bgView.width, _bgView.height) collectionViewLayout:flowLayout];
    [_bgView addSubview:_collectionView];
    _collectionView.backgroundColor = [UIColor whiteColor];
    
    ImageItem *item1 = [[ImageItem alloc] init];
    item1.isPleaseHolder = NO;
    item1.imageName = @"sdds";
    item1.image = nil;
    
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:item1];
    _collectionView.datalist = array;

    // 传入View的frame 就是摄像的范围
    DJCameraManager *manager = [[DJCameraManager alloc] initWithParentView:pickView];
    manager.delegate = self;
    manager.canFaceRecognition = YES;
    [manager setFaceRecognitonCallBack:^(CGRect faceFrame) {
        
        NSLog(@"你的脸在%@",NSStringFromCGRect(faceFrame));
        
    }];
    
    self.manager = manager;
}

/**
 *  拍照按钮
 */
- (void)initPickButton
{
    static CGFloat buttonW = 80;
    UIButton *button = [self buildButton:CGRectMake(AppWidth/2-buttonW/2, AppWidth+120+(AppHeigt-AppWidth-100-20)/2 - buttonW/2, buttonW, buttonW)
                            normalImgStr:@"shot.png"
                         highlightImgStr:@"shot_h.png"
                          selectedImgStr:@""
                              parentView:self.view];
    WS(weak);
    
    [button addActionBlock:^(id sender) {
        [weak.manager takePhotoWithImageBlock:^(UIImage *originImage, UIImage *scaledImage, UIImage *croppedImage) {
            if (croppedImage) {
                
                [weak sendImageWithImage:originImage];

            }
            
        }];
        
    }
          forControlEvents:UIControlEventTouchUpInside];
}

- (void)initDismissButton
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(30, AppWidth+120+(AppHeigt-AppWidth-100-20)/2 - 11, 40, 22);
    [button setTitle:@"取消" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    WS(weak);
    [button addActionBlock:^(id sender) {
        
    
        [weak dismissViewControllerAnimated:YES completion:nil];
        
    } forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}
/**
 *  点击对焦
 *
 *  @param touches
 *  @param event
 */


- (UIButton*)buildButton:(CGRect)frame
            normalImgStr:(NSString*)normalImgStr
         highlightImgStr:(NSString*)highlightImgStr
          selectedImgStr:(NSString*)selectedImgStr
              parentView:(UIView*)parentView {
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    if (normalImgStr.length > 0) {
        [btn setImage:[UIImage imageNamed:normalImgStr] forState:UIControlStateNormal];
    }
    if (highlightImgStr.length > 0) {
        [btn setImage:[UIImage imageNamed:highlightImgStr] forState:UIControlStateHighlighted];
    }
    if (selectedImgStr.length > 0) {
        [btn setImage:[UIImage imageNamed:selectedImgStr] forState:UIControlStateSelected];
    }
    [parentView addSubview:btn];
    return btn;
}



#pragma mark --- 上传照片
- (void)sendImageWithImage:(UIImage*)image{
    __weak UIImage *wkImage = image;
    __weak DJImageCollectionView *wkCollectionView = _collectionView;
    NSData *data = UIImageJPEGRepresentation(image, 0.6);
    
    SCLAlertView *alert = [[SCLAlertView alloc] init];
    alert.showAnimationType = SlideInToCenter;
    alert.hideAnimationType = SlideOutFromCenter;
    alert.backgroundType = Transparent;
    
    [alert showWaiting:nil title:@"等待..."
              subTitle:@"图片正在上传"
      closeButtonTitle:nil duration:59.0f];
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    //申明请求的数据是json类型
    session.requestSerializer=[AFJSONRequestSerializer serializer];
    // 默认帮助JSON解析，XML，NSXMLParser对象
    NSDictionary *dic = @{
                          @"time":kAPI_timestamp,
                          @"channel":channel_key,
                          };
    NSString *url = [BaseUtil getUrlWithDic:dic withHttp:k_API_SENDIMAGE];
    NSDictionary *params = @{
                             @"upkey":[BaseUtil ret6bitString],
                             };
    [session POST:url
       parameters:params
constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSString *homeDir = NSHomeDirectory();
        NSString *imagePath = [homeDir stringByAppendingString:@".jpeg"];
        [formData appendPartWithFileData:data
                                    name:@"upfile"
                                fileName:imagePath
                                mimeType:@"image/jpeg"];

}
          success:^(NSURLSessionDataTask *task, id responseObject) {
              [alert hideView];
              NSLog(@"responseObject : %@", responseObject);
              NSDictionary *dic = responseObject;
              NSLog(@"dic %@",dic);
              
              NSString *rec = dic[@"rec"];
              NSString *state = [NSString stringWithFormat:@"%@",rec];
              
              // 请求成功后保存数据
              if ([state isEqualToString:@"0"]) {
                  ImageItem *item = [[ImageItem alloc] init];
                  item.image = wkImage;
                  item.isPleaseHolder = NO;
                  // 应该在图片上传成功后 将图片数据加到datalist
                  [wkCollectionView.datalist insertObject:item atIndex:0];
                  //
                  [wkCollectionView reloadData];
                  NSIndexPath *indexPath = [NSIndexPath indexPathForItem:wkCollectionView.datalist.count-1 inSection:0];
                  [wkCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionRight animated:YES];
              }
              [[TKAlertCenter defaultCenter] postAlertWithMessage:dic[@"msg"]];
              return ;
              
          }
          failure:^(NSURLSessionDataTask *task, NSError *error) {
              [alert hideView];
              [[TKAlertCenter defaultCenter] postAlertWithMessage:@"图片上传失败"];
              
              NSLog(@"error : %@", error);
              
          }];
}

@end
