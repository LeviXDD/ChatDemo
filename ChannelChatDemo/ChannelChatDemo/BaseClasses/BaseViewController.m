//
//  BaseViewController.m
//  Channel
//
//  Created by user on 16/2/22.
//  Copyright © 2016年 ruanxianxiang. All rights reserved.
//

#import "BaseViewController.h"
//#import "UINavigationController+FDFullscreenPopGesture.h"
#import "UIImage+Extension.h"
#import "RTRootNavigationController.h"
//#import "UMMobClick/MobClick.h"
#define BarImageWidth  20
#define BarImageHight  22
@interface BaseViewController ()<UIGestureRecognizerDelegate>
{
}
@property(nonatomic,retain)NSMutableArray *gifPicArr;
@end

@implementation BaseViewController
-(void)dealloc{
    NSString *className = NSStringFromClass([self class]);
//    [MobClick endLogPageView:className];
    NSLog(@"页面被销毁");
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.isShowNavigationgBar = YES;
    self.isExtendLayout = NO;
    NSString *className = NSStringFromClass([self class]);
//    [MobClick beginLogPageView:className];
//    self.fd_prefersNavigationBarHidden = NO;  //隐藏导航栏
    //设置导航栏文字的主题
    [self setNavigationBar];
    self.view.backgroundColor = [UIColor whiteColor];
    self.rt_disableInteractivePop = NO;
}

//-(void)setNavigationBar{
//
//}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    if (self.navigationController.viewControllers.count > 1) {
//          // 记录系统返回手势的代理
//        _delegate = self.navigationController.interactivePopGestureRecognizer.delegate;
//         // 设置系统返回手势的代理为当前控制器
//        self.navigationController.interactivePopGestureRecognizer.delegate = self;
//     }
//    if (!self.isShowNavigationgBar) {
//        [self.navigationController setNavigationBarHidden:YES animated:animated];
//    }
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    // 设置系统返回手势的代理为我们刚进入控制器的时候记录的系统的返回手势代理
//    self.navigationController.interactivePopGestureRecognizer.delegate = _delegate;
//    if (!self.isShowNavigationgBar) {
//        [self.navigationController setNavigationBarHidden:NO animated:animated];
//    }
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return self.navigationController.childViewControllers.count > 1;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return self.navigationController.viewControllers.count > 1;
}

#pragma mark 网络检测
////判断当前网络
//-(AFNetworkReachabilityStatus)getCurrentNetWorkStatus
//{
//    [self reachability];
////    return currentStatus;
//}
//- (void)reachability
//{
//    // 检测网络连接状态
//    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
//    // 连接状态回调处理
//    /* AFNetworking的Block内使用self须改为weakSelf, 避免循环强引用, 无法释放 */
//    __weak  BaseViewController * weakSelf = self;
//    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status)
//     {
//         switch (status)
//         {
//             case AFNetworkReachabilityStatusUnknown:
//                 // 网络未知
//                 [weakSelf showHudWithTitle:@"当前网络未知"];
//                 break;
//             case AFNetworkReachabilityStatusNotReachable:
//                 // 无网络
//                 [weakSelf showHudWithTitle:@"请检查当前网络"];
//                 break;
//             case AFNetworkReachabilityStatusReachableViaWWAN:
//                 // WLAN
//
//                 break;
//             case AFNetworkReachabilityStatusReachableViaWiFi:
//                 // WIFI
//                 [weakSelf showHudWithTitle:@"当前网络是WiFi"];
//                 break;
//             default:
//                 break;
//         }
//         currentStatus=status;
//
//     }];
//}

-(void)removeControllers:(NSArray<NSString*> *)controllers{
    for (RTContainerController *controller in self.rt_navigationController.viewControllers) {
        NSString* vcClassName = NSStringFromClass([controller.contentViewController class]);
        
        if ([controllers containsObject:vcClassName]) {
            [self.rt_navigationController removeViewController:controller.contentViewController];
        }
    }
}

-(void)pushViewController:(UIViewController *)controller animated:(BOOL)animated complete:(void (^)(BOOL finished))block{
    [self.rt_navigationController pushViewController:controller animated:animated complete:^(BOOL finished) {
        block(finished);
    }];
}

-(void)backAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

//-(UINavigationController *)navigationController{
//    return self.rt_navigationController;
//}

#pragma mark - Setter
- (void)setIsExtendLayout:(BOOL)isExtendLayout {
    _isExtendLayout = isExtendLayout;
    if (!isExtendLayout) {
        [self initializeSelfVCSetting];
    }
}

-(void)setIsShowNavigationgBar:(BOOL)isShowNavigationgBar{
    _isShowNavigationgBar = isShowNavigationgBar;
    if (isShowNavigationgBar) {
//        self.fd_prefersNavigationBarHidden = NO;
        self.navigationController.navigationBar.hidden = NO;
        
    } else {
        self.navigationController.navigationBar.hidden = YES;;
//        self.fd_prefersNavigationBarHidden = YES;
    }
}

-(void)setNavigationBar{
//    if(self!=[self.navigationController.viewControllers objectAtIndex:0]){
//        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
//        [button setTitle:@"" forState:UIControlStateNormal];
//        [button setImage:[UIImage imageNamed:@"navBack"] forState:UIControlStateNormal];
//        button.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 20);
//        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [button addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
//        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
//
//    }
//
//    //导航栏主体颜色
//    UIImage *colorImage = [UIImage imageWithColor:[UIColor lcm_greenColor] size:CGSizeMake(self.view.frame.size.width, 0.5)];
//    [self.navigationController.navigationBar setBackgroundImage:colorImage forBarMetrics:UIBarMetricsDefault];
//    //分隔线颜色
//    [self.navigationController.navigationBar setShadowImage:[UIImage imageWithColor:[UIColor clearColor] size:CGSizeMake(self.view.frame.size.width, 0.5)]];
//
//    //导航栏字体
//    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18],NSForegroundColorAttributeName:[UIColor whiteColor]}];
//    self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
//    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:249/255.0f green:249/255.0f blue:249/255.0f alpha:1.0]];
//    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor lcm_greenColor]]
//                                                         forBarPosition:UIBarPositionAny
//                                                             barMetrics:UIBarMetricsDefault];
    
}

- (void)initializeSelfVCSetting {
    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
        [self setAutomaticallyAdjustsScrollViewInsets:NO];
    }
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout=UIRectEdgeNone;
    }
}
@end
