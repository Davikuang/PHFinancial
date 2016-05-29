//
//  MainViewController.m
//  
//
//  Created by PuhuiMac01 on 16/5/18.
//
//

#import "MainViewController.h"
#import "BaseNavigationController.h"
#import "ItemView.h"

@interface MainViewController (){
    ItemView *_lastItemView;
    UIImageView *_selectedImage;
}

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self _createTabBarController];
    [self _createTabBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Pravite
//创建视图控制器
- (void)_createTabBarController {
    
    HomeViewController *homeVC = [[HomeViewController alloc] init];
    homeVC.title = @"首页";
    
    FTicketViewController *FtVC = [[FTicketViewController alloc] init];
    FtVC.title = @"找票";
    
    InfoViewController *infoVC = [[InfoViewController alloc] init];
    infoVC.title = @"咨询";
    
    PersonalViewController *myVC = [[PersonalViewController alloc] init];
    myVC.title = @"我的";
    
    NSArray *arr = @[homeVC,FtVC,infoVC,myVC];
    
    NSMutableArray *arraysNVC = [[NSMutableArray alloc] initWithCapacity:arr.count];
    
    for (UIViewController * item in arr) {
        BaseNavigationController *navigation = [[BaseNavigationController alloc] initWithRootViewController:item];
        
        //        [navigation.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bg_all@2x"] forBarMetrics:UIBarMetricsDefault];
        
        [arraysNVC addObject:navigation];
    }
    self.viewControllers = arraysNVC;
    
}

//创建tabBar
- (void)_createTabBar {
    
    //移除tabBar上的item
    for (UIView *SubView in [self.tabBar subviews]) {
        // 反射，指定名字，返回一个类，UITabBarButton是一个隐藏类名
        Class class = NSClassFromString(@"UITabBarButton");
        //移除item
        if ([SubView isKindOfClass:class]) {
            [SubView removeFromSuperview];
        }
    }
    
    //给TabBar自定义背景视图
    
    UIImageView *tbImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"lunpay"]];
    tbImg.frame = self.tabBar.bounds;
    tbImg.userInteractionEnabled = YES;
    //    [self.tabBar addSubview:tbImg];
    
    
    // 添加选中图片，选中图片必须放在下面，即优先加载否则会盖住下面的图标
    CGFloat width = kScreenWidth/self.viewControllers.count;
    
    //给TabBar添加按钮
    NSArray *images = @[@"Home", @"Grid", @"UserProfile", @"Shopping"];
    NSArray *select =@[@"首页", @"服务", @"我的",@"商品"];
    
    NSArray *titles = @[@"首页", @"找票", @"咨询",@"我的"];
    
    
    for (int i = 0 ;i < self.viewControllers.count ; i++ ) {
        ItemView *itemView = [[ItemView alloc] initWithFrame:CGRectMake(i*width, 0, width, kTabBarHeight)];
        [itemView setItemImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        [itemView setItemImage:[UIImage imageNamed:select[i]] forState:UIControlStateSelected];
        [itemView setItemTitle:titles[i]];
        itemView.tag = 100+i;
        
        if (i == 4) {
            
//            NoticeLabel *_message = [[NoticeLabel alloc] initWithFrame:CGRectMake(width - 20,1, 15, 15)];
//            _message.backgroundColor = [UIColor redColor];
//            _message.mesageCount = 0;
//            _message.hidden = YES;
//            _message.text = [NSString stringWithFormat:@"%d",_message.mesageCount];
//            _message.textAlignment = 1;
//            _message.textColor = [UIColor whiteColor];
//            _message.font = [UIFont systemFontOfSize:10];
//            [_message.layer setBorderWidth:0.5];
//            _message.layer.cornerRadius = 7.5;
//            _message.layer.borderColor = [UIColor redColor].CGColor;
//            _message.layer.masksToBounds = YES;
//            _message.tag = 505;
//            [itemView addSubview:_message];
            
        }
        // itemView.delegate = self;
        [self.tabBar addSubview:itemView];
        //使用blockd代替代理方法
        [itemView setBlock:^ (ItemView * sender) {
            [[NSNotificationCenter defaultCenter] postNotificationName:kInfoNotification object:nil];
            
            if (_lastItemView != sender) {
                if (sender.tag == 104) {
//                    NoticeLabel *_message = (NoticeLabel *)[sender viewWithTag:505];
//                    _message.mesageCount = 0;
//                    
//                    _message.hidden = YES;
                }
                
                // 取消上一次的选中状态
                [_lastItemView setSelected:NO];
                // 让当前按钮成为选中状态
                [sender setSelected:YES];
                // 设置itemView，全局变量指向该对象可以，修改全局变量属性时就是修改该对象属性，该赋值本质是指向该地址而不是copy
                _lastItemView = sender;
                // 选取视图控制器
                self.selectedIndex = sender.tag-100;
                [UIView animateWithDuration:0.3 animations:^{
                    //                    _selectedImage.center = sender.center;
                }];
            }
            
        }];
        
        if(i==0){
            
            [itemView setSelected:YES];
            _lastItemView = itemView;
        }
        
    }
    
}



@end
