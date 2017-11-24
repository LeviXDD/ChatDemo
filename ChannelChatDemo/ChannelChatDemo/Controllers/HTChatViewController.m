//
//  HTChatListViewController.m
//  ChannelChatDemo
//
//  Created by 海涛 黎 on 2017/11/24.
//Copyright © 2017年 Levi. All rights reserved.
//

#import "HTChatViewController.h"
// Controllers

// Model
#import "PDMessageFrame.h"

// Views
#import "HTBaseTableView.h"
#import "InputView.h"
#import "PDBaseChatMessageTextCell.h"

//Tools
#import "PDSendMessageHelper.h"
#import "HTMesseageSender.h"
//Cell重用标识符
#define PD_CHATTYPE_TEXT  @"PD_CHATTYPE_TEXT"
#define PD_CHATTYPE_VOICE @"PD_CHATTYPE_VOICE"
#define PD_CHATTYPE_PIC     @"PD_CHATTYPE_PIC"


@interface HTChatViewController ()<HTBaseTableViewDelegate,InputViewDelegate>{
    NSString *_userId;   //
}
#pragma mark - Class Variables
@property(nonatomic, strong) HTBaseTableView *chatTableView;
@property(nonatomic, strong) InputView *chatPutView;

/*数据类*/
@property(nonatomic, strong) NSMutableArray *chatSourceArr;
@end

#pragma mark - Class Definition
@implementation HTChatViewController
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
    _userId = @"xxxx";
}

// 创建页面内控件的地方。
- (void)createViews{
    [self.view addSubview:self.chatTableView];
    [self.view addSubview:self.chatPutView];
}

//页面控件约束
- (void)layoutSettings{
    [self.chatPutView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view.mas_bottom);
        make.height.mas_equalTo(44);
    }];
    
    [self.chatTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.equalTo(self.view);
        make.bottom.equalTo(self.chatPutView.mas_top);
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
/**
 刷新列表
 
 @param isNewMessage 是否为发送消息
 */
-(void)reloadDataWithNewMessage:(BOOL)isNewMessage{// receiveNewMsg:(BOOL){
    for (int i = 0; i < self.chatSourceArr.count ; i ++) {
        PDMessageFrame *frameModel = self.chatSourceArr[i];
        PDLocalMessageModel *msgModel =  frameModel.model;
//        msgModel.message.showTimeStr = self.chatTimeArr[i];
        frameModel.model = msgModel;
        self.chatSourceArr[i] = frameModel;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if (isNewMessage) { //如果是发送新消息则滚动到列表底部
            [self.chatTableView reloadData];
            [self scrollToBottom];
        } else {
            CGSize oldSize = self.chatTableView.contentSize;
//            CGPoint oldOffset = self.chatTableView.contentOffset;
            [self.chatTableView reloadData];
            CGSize newSize = self.chatTableView.contentSize;
            CGPoint newPoint = CGPointMake(0,  + newSize.height - oldSize.height - 40);
            self.chatTableView.contentOffset = newPoint;
        }
    });
}

/*滚动到底部*/
- (void)scrollToBottom
{
    CGFloat yOffset = 0; //设置要滚动的位置 0最顶部 CGFLOAT_MAX最底部
    if (self.chatTableView.contentSize.height > self.chatTableView.bounds.size.height) {
        yOffset = self.chatTableView.contentSize.height - self.chatTableView.bounds.size.height;
    }
    [self.chatTableView setContentOffset:CGPointMake(0, yOffset) animated:YES];
}

#pragma mark - Notification Methods

#pragma mark - Overridden Methods

#pragma mark - KVO Methods

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.chatSourceArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    PDMessageFrame *messageF = [self.chatSourceArr objectAtIndex:indexPath.row];
    return messageF.cellHight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id obj                            = self.chatSourceArr[indexPath.row];
    PDMessageFrame *modelFrame     = (PDMessageFrame *)obj;
    NSString *resuseIdentifier                   = [NSString string];
    switch (modelFrame.model.message.contentType) {
        case MES_CHATCONTENT_TYPE_TEXT:
            resuseIdentifier = PD_CHATTYPE_TEXT;
            break;
            
        default:
            break;
    }
    PDBaseChatMessageCell *cell    = [tableView dequeueReusableCellWithIdentifier:resuseIdentifier];
//    cell.delegate = self;
    cell.modelFrame                = modelFrame;
//    cell.channelType = self.channelType;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - InputViewDelegate
-(void)sendMessage:(NSString *)content{
    if ([Utils removeAllSpaceCharacterInString:content].length == 0) {
        [MBProgressHUD showMessage:@"不能发送空白消息"];
        return;
    }
    NSString *localMsgId = [self creatLocalMessageId];
    PDMessageFrame *messageF = [PDSendMessageHelper createMessageFrameWithContentType:MES_CHATCONTENT_TYPE_TEXT locaMsgId:localMsgId content:content timeStamp:[self sendTimeStamp] from:@"我" to:@"另一个人" userIcon:@"先不填写吧" isSender:YES uuid:localMsgId sendingStatus:PDMessageDeliveryState_Delivering];
    [self.chatSourceArr addObject:messageF];
    [self reloadDataWithNewMessage:YES];
    /*将数据插入数据库中*/
//    PDMessageMSGModel *insertModel = [self insertVideoMessageToDB:messageF];
    [self sendMessageWithMessageModel:messageF];
}

#pragma mark - 一些本地标志生成（可以根据项目需求自己去定义规则）
-(NSString*)sendTimeStamp{
    if (self.chatSourceArr.count == 0) {
        return  [NSString stringWithFormat:@"%.0f",[[NSDate date] timeIntervalSince1970]*1000];
    }  else {
        PDMessageFrame *lastModelF = [self.chatSourceArr lastObject];
        NSInteger lastTimeStamp = [lastModelF.model.message.sendTimeStamp integerValue];
        return [NSString stringWithFormat:@"%ld",lastTimeStamp+1];
    }
}

-(NSString*)creatLocalMessageId{
    CFUUIDRef uuid_ref = CFUUIDCreate(NULL);
    CFStringRef uuid_string_ref= CFUUIDCreateString(NULL, uuid_ref);
    NSString *uuid = [NSString stringWithString:(__bridge NSString *)uuid_string_ref];
    CFRelease(uuid_ref);
    CFRelease(uuid_string_ref);
    NSString *uuidStr = [uuid lowercaseString];
    return uuidStr;
}
#pragma mark - Privater Methods
/*发送消息*/
-(void)sendMessageWithMessageModel:(PDMessageFrame*)model{
    PDLocalMessageModel *msgModel = model.model;
    [HTMesseageSender sendMsgWithUserId:_userId message:msgModel success:^(BOOL success, PDLocalMessageModel *message) {
        if (success) {
            msgModel.message.deliveryState = PDMessageDeliveryState_Delivered;
            [self reloadDataWithNewMessage:YES];
        }
    } failure:^(NSError *error, PDLocalMessageModel *message) {
        
    }];
}
#pragma mark - Setter Getter Methods
-(InputView *)chatPutView{
    if (!_chatPutView) {
        _chatPutView = [InputView inputView];
        _chatPutView.delegate = self;
    }
    return _chatPutView;
}

-(HTBaseTableView *)chatTableView{
    if (!_chatTableView) {
        _chatTableView = [[HTBaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _chatTableView.delegate = self;
        _chatTableView.dataSource = self;
        _chatTableView.canRefresh = YES;
        _chatTableView.baseDelegate = self;
//        [_chatTableView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tableViewDidTapped:)]];
        _chatTableView.backgroundColor = [UIColor whiteColor];
        [_chatTableView registerClass:[PDBaseChatMessageTextCell class] forCellReuseIdentifier:PD_CHATTYPE_TEXT];
//        [_chatTableView registerClass:[PDBaseChatMessageVoiceCell class] forCellReuseIdentifier:PD_CHATTYPE_VOICE];
//        [_chatTableView registerClass:[PDBaseChatMessagePictureCell class] forCellReuseIdentifier:PD_CHATTYPE_PIC];
//        [_chatTableView registerClass:[PDBaseChatMessageVideoCell class] forCellReuseIdentifier:PD_CHATTYPE_VIDEO];
//        [_chatTableView registerClass:[PDBaseChatMessageSystemCell class] forCellReuseIdentifier:PD_CHATTYPE_SYS];
//        [_chatTableView registerClass:[PDRedPacketMessageCell class] forCellReuseIdentifier:PD_CHATTYPE_REDPACK];
//        [_chatTableView registerClass:[PDNoticeBoardTableViewCell class] forCellReuseIdentifier:PDNoticeBoardTableViewCellIdentifier];
        //        [_chatTableView registerNib:[UINib nibWithNibName:NSStringFromClass([PDNoticeBoardTableViewCell class]) bundle:nil] forCellReuseIdentifier:PDNoticeBoardTableViewCellIdentifier];
        _chatTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _chatTableView.backgroundColor = [UIColor hx_colorWithHexString:@"#EEEEEE"];
    }
    return _chatTableView;
}

-(NSMutableArray *)chatSourceArr{
    if (!_chatSourceArr) {
        _chatSourceArr = [NSMutableArray array];
    }
    return _chatSourceArr;
}
@end
