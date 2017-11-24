//
//  HTChatListViewController.m
//  ChannelChatDemo
//
//  Created by 海涛 黎 on 2017/11/24.
//Copyright © 2017年 Levi. All rights reserved.
//

#import "HTChatListViewController.h"
// Controllers

// Model

// Views

//Tools

//#define <#macro#> <#value#>


@interface HTChatListViewController ()
#pragma mark - Class Variables


@end

#pragma mark - Class Definition
@implementation HTChatListViewController
#pragma mark - View Controller LifeCyle
- (void)dealloc
{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self basicSettings];
    [self createViews];
    [self layoutSettings];
    [self createEvents];
    [self loadData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

//页面基本设置
-(void)basicSettings{
}

// 创建页面内控件的地方。
- (void)createViews{
}

//页面控件约束
- (void)layoutSettings{
    //    @weakify(self);
    //    [self.; mas_makeConstraints:^(MASConstraintMaker *make) {
    //        @strongify(self);
    //    }];
}


// 创建页面内控件事件的地方
- (void)createEvents{
}

// 如果页面加载过程需要读取数据, 则写在这个地方。
- (void)loadData
{
    
}

#pragma mark - Target Methods

#pragma mark - Notification Methods

#pragma mark - Overridden Methods

#pragma mark - KVO Methods

#pragma mark - UITableViewDelegate, UITableViewDataSource

#pragma mark - Privater Methods

#pragma mark - Setter Getter Methods
@end

