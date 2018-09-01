//
//  HTChatListViewController.m
//  ChannelChatDemo
//
//  Created by 海涛 黎 on 2017/11/24.
//Copyright © 2017年 Levi. All rights reserved.
//

#import "HTChatListViewController.h"
// Controllers
#import "HTChatViewController.h"

// Model

// Views
#import "HTBaseTableView.h"
#import "HTChatTableViewCell.h"
//Tools

#define HTChatTableViewCellIdentifier @"HTChatTableViewCellIdentifier"


@interface HTChatListViewController ()<UITableViewDataSource,UITableViewDelegate>
#pragma mark - Class Variables
@property(nonatomic, strong) HTBaseTableView *chatListTable;

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

//页面基本设置
-(void)basicSettings{
    self.navigationItem.title = @"聊天";
}

// 创建页面内控件的地方。
- (void)createViews{
    [self.view addSubview:self.chatListTable];
}

//页面控件约束
- (void)layoutSettings{
        [self.chatListTable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.view);
        }];
}


// 创建页面内控件事件的地方
- (void)createEvents{
}

// 如果页面加载过程需要读取数据, 则写在这个地方。
- (void)loadData
{
    
}

#pragma mark - Target Methods
-(void)viewDidTapped:(id)sender{
    
}
#pragma mark - Notification Methods

#pragma mark - Overridden Methods

#pragma mark - KVO Methods

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HTChatTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:HTChatTableViewCellIdentifier];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.navigationController pushViewController:[HTChatViewController new] animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.width, 0.01)];
}
#pragma mark - Privater Methods

#pragma mark - Setter Getter Methods
-(HTBaseTableView *)chatListTable{
    if (!_chatListTable) {
        _chatListTable = [[HTBaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _chatListTable.delegate = self;
        _chatListTable.dataSource = self;
        [_chatListTable registerNib:[UINib nibWithNibName:NSStringFromClass([HTChatTableViewCell class]) bundle:nil] forCellReuseIdentifier:HTChatTableViewCellIdentifier];
    }
    return _chatListTable;
}
@end

