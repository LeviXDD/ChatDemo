//
//  BaseViewController.h
//  Channel
//
//  Created by user on 16/2/22.
//  Copyright © 2016年 ruanxianxiang. All rights reserved.
//

#import <UIKit/UIKit.h>

//typedef NS_ENUM(NSInteger, PDControllerType) {
//    PDControllerTypeNormal = 0,
//    PDControllerTypeSameChannel  = 1,
//    PDControllerTypeLogin
//};

@interface BaseViewController : UIViewController
/**
 *  VIEW是否渗透导航栏
 * (YES_VIEW渗透导航栏下／NO_VIEW不渗透导航栏下)
 */
@property (assign,nonatomic) BOOL isExtendLayout;

/**
 *  是否需要显示导航栏
 * (YES_显示／NO_不显示)
 */
@property(nonatomic, assign) BOOL isShowNavigationgBar;  //默认YES

-(void)removeControllers:(NSArray<NSString*>*)controllers;

-(void)pushViewController:(UIViewController*)controller animated:(BOOL)animated complete:(void (^)(BOOL finished))block;
@end
