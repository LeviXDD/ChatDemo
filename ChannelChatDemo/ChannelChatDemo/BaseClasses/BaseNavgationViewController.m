//
//  BaseNavgationViewController.m
//  Channel
//
//  Created by user on 16/2/22.
//  Copyright © 2016年 ruanxianxiang. All rights reserved.
//

#import "BaseNavgationViewController.h"

@interface BaseNavgationViewController()

@end

@implementation BaseNavgationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

//-(void)setIsSameTopic:(BOOL)isSameTopic{
//    _isSameTopic = isSameTopic;
//    if (isSameTopic) {
//        [self.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor pd_textWhiteColor]}];
//        self.navigationBar.barStyle = UIStatusBarStyleLightContent;
//        [self.navigationBar setBarTintColor:[UIColor pd_commonBgGrayColor]];
//        [self.navigationBar setTintColor:[UIColor blackColor]];
//        [self.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor pd_commonBgGrayColor]]
//                                                                 forBarPosition:UIBarPositionAny
//                                                                     barMetrics:UIBarMetricsDefault];
//    }
//}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

- (BOOL)shouldAutorotate
{
    return self.topViewController.shouldAutorotate;
}
#if __IPHONE_OS_VERSION_MAX_ALLOWED < __IPHONE_9_0
- (NSUInteger)supportedInterfaceOrientations
#else
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
#endif
{
    return self.topViewController.supportedInterfaceOrientations;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return self.topViewController.preferredInterfaceOrientationForPresentation;
}

@end
