
#import "CYLTabBarControllerConfig.h"
#import "BaseNavgationViewController.h"
#import "HTChatListViewController.h"
#import "HTProfileViewController.h"



@interface CYLTabBarControllerConfig ()

@property (nonatomic, readwrite, strong) CYLTabBarController *tabBarController;

@end

@implementation CYLTabBarControllerConfig

/**
 *  lazy load tabBarController
 *
 *  @return CYLTabBarController
 */
- (CYLTabBarController *)tabBarController {
    if (_tabBarController == nil) {
        HTChatListViewController *firstViewController = [[HTChatListViewController alloc] init];
        BaseNavgationViewController *firstNavigationController = [[BaseNavgationViewController alloc]
                                                       initWithRootViewController:firstViewController];
        
        HTProfileViewController *secondViewController = [[HTProfileViewController alloc] init];
        BaseNavgationViewController *secondNavigationController = [[BaseNavgationViewController alloc]
                                                                  initWithRootViewController:secondViewController];
        
        CYLTabBarController *tabBarController = [[CYLTabBarController alloc] init];
        
        /**
         * 以下两行代码目的在于手动设置让TabBarItem只显示图标，不显示文字，并让图标垂直居中。
         * 等效于在`-setUpTabBarItemsAttributesForController`方法中不传`CYLTabBarItemTitle`字段。
         * 更推荐后一种做法。
         */
//        tabBarController.imageInsets = UIEdgeInsetsMake(0, 0, 0, 0);
//        tabBarController.titlePositionAdjustment = UIOffsetMake(0, MAXFLOAT);
        
        // 在`-setViewControllers:`之前设置TabBar的属性，设置TabBarItem的属性，包括 title、Image、selectedImage。
        [self setUpTabBarItemsAttributesForController:tabBarController];
        
        [tabBarController setViewControllers:@[
                                               firstNavigationController,
                                               secondNavigationController
//                                               thirdNavigationController,
//                                               fourthNavigationController,
//                                               fifthNavigationController
                                               ]];
        // 更多TabBar自定义设置：比如：tabBarItem 的选中和不选中文字和背景图片属性、tabbar 背景图片属性
        [self customizeTabBarAppearance:tabBarController];
        _tabBarController = tabBarController;
//        _tabBarController.delegate = self;
    }
    return _tabBarController;
}

/**
 *  在`-setViewControllers:`之前设置TabBar的属性，设置TabBarItem的属性，包括 title、Image、selectedImage。
 */
- (void)setUpTabBarItemsAttributesForController:(CYLTabBarController *)tabBarController {
    
    NSDictionary *dict1 = @{
                            CYLTabBarItemTitle : @"聊天",
                            CYLTabBarItemImage : @"tabbar_home_deSelect",
                            CYLTabBarItemSelectedImage : @"tabbar_home_select",
                            };
    NSDictionary *dict2 = @{
                            CYLTabBarItemTitle : @"我的",
                            CYLTabBarItemImage : @"tabbar_mine_deSelect",
                            CYLTabBarItemSelectedImage : @"tabbar_mine_select",
                            };
//    NSDictionary *dict3 = @{
//                            CYLTabBarItemTitle : @"扫一扫",
//                            CYLTabBarItemImage : @"camera",
//                            CYLTabBarItemSelectedImage : @"camera",
//                            CYLTabBarItemImageOffset:@0
//                            };
//
//    NSDictionary *dict4 = @{
//                            CYLTabBarItemTitle : @"同频",
//                            CYLTabBarItemImage : @"livecircle_nor",
//                            CYLTabBarItemSelectedImage : @"livecircle",
//                            };
//    NSDictionary *dict5 = @{
//                            CYLTabBarItemTitle : @"我的",
//                            CYLTabBarItemImage : @"setting.png",
//                            CYLTabBarItemSelectedImage : @"settingSelect.png"
//                            };
    NSArray *tabBarItemsAttributes = @[
                                       dict1,
                                       dict2,
//                                       dict3,
//                                       dict4,
//                                       dict5
                                       ];
    tabBarController.tabBarItemsAttributes = tabBarItemsAttributes;
//    tabBarController.imageInsets = UIEdgeInsetsMake(8, 8, 8, 8);
}

/**
 *  更多TabBar自定义设置：比如：tabBarItem 的选中和不选中文字和背景图片属性、tabbar 背景图片属性
 */
- (void)customizeTabBarAppearance:(CYLTabBarController *)tabBarController {
//#warning CUSTOMIZE YOUR TABBAR APPEARANCE
    // Customize UITabBar height
    // 自定义 TabBar 高度
    // tabBarController.tabBarHeight = 40.f;
    
    // set the text color for unselected state
    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    // set the text color for selected state
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    // set the text Attributes
    // 设置文字属性
    UITabBarItem *tabBar = [UITabBarItem appearance];
    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [tabBar setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
    // Set the dark color to selected tab (the dimmed background)
    // TabBarItem选中后的背景颜色
    // [self customizeTabBarSelectionIndicatorImage];
    
    // update TabBar when TabBarItem width did update
    // If your app need support UIDeviceOrientationLandscapeLeft or UIDeviceOrientationLandscapeRight，
    // remove the comment '//'
    // 如果你的App需要支持横竖屏，请使用该方法移除注释 '//'
    // [self updateTabBarCustomizationWhenTabBarItemWidthDidUpdate];
    
    // set the bar shadow image
    // This shadow image attribute is ignored if the tab bar does not also have a custom background image.So at least set somthing.
    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc] init]];
    [[UITabBar appearance] setBackgroundColor:[UIColor whiteColor]];
    [[UITabBar appearance] setShadowImage:[UIImage imageNamed:@"tapbar_top_line"]];
    
    // set the bar background image
    // 设置背景图片
//     UITabBar *tabBarAppearance = [UITabBar appearance];
//     [tabBarAppearance setBackgroundImage:[UIImage imageNamed:@"tabbar_background"]];
    
    // remove the bar system shadow image
    // 去除 TabBar 自带的顶部阴影
    // [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
}

- (void)updateTabBarCustomizationWhenTabBarItemWidthDidUpdate {
    void (^deviceOrientationDidChangeBlock)(NSNotification *) = ^(NSNotification *notification) {
        UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
        if ((orientation == UIDeviceOrientationLandscapeLeft) || (orientation == UIDeviceOrientationLandscapeRight)) {
            NSLog(@"Landscape Left or Right !");
        } else if (orientation == UIDeviceOrientationPortrait){
            NSLog(@"Landscape portrait!");
        }
        [self customizeTabBarSelectionIndicatorImage];
    };
    [[NSNotificationCenter defaultCenter] addObserverForName:CYLTabBarItemWidthDidChangeNotification
                                                      object:nil
                                                       queue:[NSOperationQueue mainQueue]
                                                  usingBlock:deviceOrientationDidChangeBlock];
}

- (void)customizeTabBarSelectionIndicatorImage {
    ///Get initialized TabBar Height if exists, otherwise get Default TabBar Height.
    UITabBarController *tabBarController = [self cyl_tabBarController] ?: [[UITabBarController alloc] init];
    CGFloat tabBarHeight = tabBarController.tabBar.frame.size.height;
    CGSize selectionIndicatorImageSize = CGSizeMake(CYLTabBarItemWidth, tabBarHeight);
    //Get initialized TabBar if exists.
    UITabBar *tabBar = [self cyl_tabBarController].tabBar ?: [UITabBar appearance];
    [tabBar setSelectionIndicatorImage:
     [[self class] imageWithColor:[UIColor redColor]
                             size:selectionIndicatorImageSize]];
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    if (!color || size.width <= 0 || size.height <= 0) return nil;
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width + 1, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}



- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
//    CYLBaseNavigationController *nav = (CYLBaseNavigationController*)viewController;
//    UIViewController *vc = nav.viewControllers[0];
//    if ([vc isKindOfClass:[AddressBookViewController class]] ||
//        [vc isKindOfClass:[SettingViewController class]] ||
//        [vc isKindOfClass:[FindViewController class]]||[vc isKindOfClass:[NewScanViewController class]]) {
//        PDUser *user = [PDUser sharedInstance];
//        if (![user isLogin]) {
//            [[NSNotificationCenter defaultCenter] postNotificationName:Channel_ReLogin object:nil];
//            
//            return FALSE;
//        }
//    }
//    return TRUE;
//}
//
//- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
//{
//    CYLBaseNavigationController *nav = (CYLBaseNavigationController*)viewController;
//    UIViewController *vc = nav.viewControllers[0];
//    if ([vc isKindOfClass:[SettingViewController class]]) {
//        SettingViewController *setting = (SettingViewController*)vc;
//        [setting loadUserInfo];
//    }
//}
//
@end
