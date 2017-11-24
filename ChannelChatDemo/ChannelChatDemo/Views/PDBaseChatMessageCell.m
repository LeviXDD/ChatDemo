//
//  PDBaseChatMessageCell.m
//  Chanel
//
//  Created by 海涛 黎 on 2017/6/22.
//  Copyright © 2017年 ruanxianxiang. All rights reserved.
//

#import "PDBaseChatMessageCell.h"
#import "PDBaseChatMessageTextCell.h"
#import "PDLocalMessageModel.h"
#import "PDChatInfoDefs.h"
//#import "PDMessageWCDBAPI.h"
#import "UIImage+Extension.h"
#import "UILabel+fastLab.h"
#define IColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

@interface PDBaseChatMessageCell()
@end

@implementation PDBaseChatMessageCell
//PDMenuController *menuController;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView removeAllSubviews];
        [self setupUI];
        [self.headImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showUserInfo:)]];
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
//        UILongPressGestureRecognizer *longRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressRecognizer:)];
//        longRecognizer.minimumPressDuration = 0.5;
//        [self addGestureRecognizer:longRecognizer];
        
        [self addGestureRecognizer: [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longTap:)]];
    }
    return self;
}


- (void)longTap:(UILongPressGestureRecognizer *)longRecognizer {
    if (longRecognizer.state==UIGestureRecognizerStateBegan) {
        [self becomeFirstResponder];
        UIMenuController *menuController =  [UIMenuController sharedMenuController];
        if ([self isKindOfClass:[PDBaseChatMessageTextCell class]]) {
            UIMenuItem *copyItem = [[UIMenuItem alloc] initWithTitle:@"复制" action:@selector(copyMethod)];
            UIMenuItem *delItem = [[UIMenuItem alloc] initWithTitle:@"删除" action:@selector(delMethod)];
            [menuController setMenuItems:[NSArray arrayWithObjects:copyItem,delItem,nil]];
        }else{
            UIMenuItem *delItem = [[UIMenuItem alloc] initWithTitle:@"删除" action:@selector(delMethod)];
            [menuController setMenuItems:[NSArray arrayWithObjects:delItem,nil]];
        }
        if (self.showMenuView) {
            [menuController setTargetRect:self.showMenuView.bounds inView:self.showMenuView];
            [menuController setMenuVisible:YES animated:YES];
        }
//        if (self.delegate && [self.delegate respondsToSelector:@selector(PDBaseChatMessageCellShowMenuController:andMenuController:)]) {
//            [self.delegate PDBaseChatMessageCellShowMenuController:self andMenuController:menuController];
//        }
    }
}


- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if (action == @selector(copyMethod)){
        return YES;
    }else if (action == @selector(delMethod)){
        return YES;
    }return [super canPerformAction:action withSender:sender];
}


-(void)delMethod{
    NSLog(@"%@",self.modelFrame.model.message.uuid);
//    [PDMessageWCDBAPI deleteLocalMSGWithUUID:self.modelFrame.model.message.uuid];
    if ([self.delegate respondsToSelector:@selector(PDBaseChatMessageCellDeleted:)] && self.delegate ) {
        [self.delegate PDBaseChatMessageCellDeleted:self];
    }
}

-(void)copyMethod{
    
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}



-(void)showUserInfo:(id)sender{
//    NewUserInfoViewController *nVc  = [[NewUserInfoViewController alloc]init];
//    nVc.title = self.modelFrame.model.message.senderName;
//    nVc.userId = self.modelFrame.model.message.userId;
//    [[Utils currentViewController].navigationController pushViewController:nVc animated:YES];
}

#pragma mark - UI
- (void)setupUI {
    [self.contentView addSubview:self.nickNameLabel];
    [self.contentView addSubview:self.bubbleView];
    [self.contentView addSubview:self.headImageView];
    [self.contentView addSubview:self.activityView];
    [self.contentView addSubview:self.retryButton];
    [self.contentView addSubview:self.timeLab];
}

#pragma mark - Getter and Setter

-(UILabel *)timeLab{
    if (!_timeLab) {
        _timeLab = [UILabel fastLabWithTitle:@"" andTitleFont:SenderNameFont andTitleColor:[UIColor whiteColor]];
        _timeLab.backgroundColor  = [UIColor hx_colorWithHexString:@"585858"];
        _timeLab.textAlignment = NSTextAlignmentCenter;
        _timeLab.layer.masksToBounds = YES;
        _timeLab.layer.cornerRadius = 2;
    }return _timeLab;
}

- (PDHeadImageView *)headImageView {
    if (_headImageView == nil) {
        _headImageView = [[PDHeadImageView alloc] init];
        [_headImageView setColor:IColor(219, 220, 220) bording:0.0];
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headClicked)];
        [_headImageView addGestureRecognizer:tapGes];
    }
    return _headImageView;
}

-(UILabel *)nickNameLabel{
    if (!_nickNameLabel) {
        _nickNameLabel = [[UILabel alloc] init];
        _nickNameLabel.font = SenderNameFont;
        _nickNameLabel.textColor = [UIColor hx_colorWithHexString:@"D6D6D6"];
    }
    return _nickNameLabel;
}

- (UIImageView *)bubbleView {
    if (_bubbleView == nil) {
        _bubbleView = [[UIImageView alloc] init];
        _bubbleView.userInteractionEnabled = YES;
//        [_bubbleView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(messageDidClicked:)]];
    }
    return _bubbleView;
}

//-(void)messageDidClicked:(id)sender{
//    
//}

- (UIActivityIndicatorView *)activityView {
    if (_activityView == nil) {
        _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    }
    return _activityView;
}

- (UIButton *)retryButton {
    if (_retryButton == nil) {
        _retryButton = [[UIButton alloc] init];
        [_retryButton setImage:[UIImage imageNamed:@"resend"] forState:UIControlStateNormal];
        [_retryButton addTarget:self action:@selector(retryButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _retryButton;
}

#pragma mark - Respond Method

- (void)retryButtonClick:(UIButton *)btn {
    if (_delegate && [self.delegate respondsToSelector:@selector(PDBaseChatMessageCellResendMessage:)]) {
        self.modelFrame.model.message.deliveryState = PDMessageDeliveryState_Delivering;
        [self.delegate PDBaseChatMessageCellResendMessage:self];
    }
}

-(void)setChannelType:(PDChannelType)channelType{
    _channelType = channelType;
    if (_channelType == PDChannelTypeSameTopic || _channelType == PDChannelTypeSimCity) {
        self.activityView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
        _nickNameLabel.textColor = self.modelFrame.model.message.isSite?[UIColor redColor]:[UIColor hx_colorWithHexString:@"D6D6D6"];
    } else {
        self.activityView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        _timeLab.backgroundColor = [UIColor hx_colorWithHexString:@"#C6C6C6"];
        _nickNameLabel.textColor = self.modelFrame.model.message.isSite?[UIColor redColor]:[UIColor lightGrayColor];
        if (self.modelFrame.model.message.contentType == MES_CHATCONTENT_TYPE_REDPACK) {
            if (self.modelFrame.model.isSender) {
                self.bubbleView.image = [UIImage resizableImageWithName:@"redPacketMe"];
            } else {
                self.bubbleView.image = [UIImage resizableImageWithName:@"redPacketLeft"];
            }
        } else {
            if (self.modelFrame.model.isSender) {
                self.bubbleView.image = [UIImage resizableImageWithName:@"chat_send_nor"];
            } else {
                self.bubbleView.image = [UIImage resizableImageWithName:@"chat_recive_nor"];
            }
        }
    }
}

- (void)setModelFrame:(PDMessageFrame *)modelFrame
{
    _modelFrame = modelFrame;
    
    PDLocalMessageModel *messageModel = modelFrame.model;
    self.headImageView.frame     = modelFrame.headImageViewF;
    self.bubbleView.frame        = modelFrame.bubbleViewF;
    self.nickNameLabel.frame  = modelFrame.nameLabelF;
    self.nickNameLabel.text = modelFrame.model.message.from;
    
    if (STRING_ISNOTNIL(modelFrame.model.message.showTimeStr)) {
        self.timeLab.hidden = NO;
        self.timeLab.frame = modelFrame.timeLabelF;
        self.timeLab.text = modelFrame.model.message.showTimeStr;
    }else{
        self.timeLab.hidden = YES;
    }
    
    //如果是图片信息则隐藏气泡
    if (self.modelFrame.model.message.contentType == MES_CHATCONTENT_TYPE_PIC) {
        self.bubbleView.hidden = YES;
    } else {
        self.bubbleView.hidden = NO;
    }
    
    if (messageModel.isSender) {    // 发送者
        self.activityView.frame  = modelFrame.activityF;
        self.retryButton.frame   = modelFrame.retryButtonF;
        switch (modelFrame.model.message.deliveryState) { // 发送状态
            case PDMessageDeliveryState_Delivering:
            {
                [self.activityView setHidden:NO];
                [self.retryButton setHidden:YES];
                [self.activityView startAnimating];
            }
                break;
            case PDMessageDeliveryState_Delivered:
            {
                [self.activityView stopAnimating];
                [self.activityView setHidden:YES];
                [self.retryButton setHidden:YES];
                
            }
                break;
            case PDMessageDeliveryState_Failure:
            {
                [self.activityView stopAnimating];
                [self.activityView setHidden:YES];
                [self.retryButton setHidden:NO];
            }
                break;
            default:
                break;
        }
//        if ([modelFrame.model.message.type isEqualToString:TypeFile] ||[modelFrame.model.message.type isEqualToString:TypePicText]) {
//            self.bubbleView.image = [UIImage imageNamed:@"liaotianfile"];
//        } else {
            self.bubbleView.image = [UIImage resizableImageWithName:@"chat_send_nor"];
//        }
    } else {    // 接收者
        self.retryButton.hidden  = YES;
        self.bubbleView.image    = [UIImage resizableImageWithName:@"chat_recive_nor"];
    }
//    [self.headImageView.imageView setImageWithURL:[NSURL URLWithString:modelFrame.model.message.userIcon] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
}



- (void)headClicked
{
//    if ([self.longPressDelegate respondsToSelector:@selector(headImageClicked:)]) {
//        [self.longPressDelegate headImageClicked:_modelFrame.model.message.from];
//    }
}

#pragma mark - longPress delegate

- (void)longPressRecognizer:(UILongPressGestureRecognizer *)recognizer
{
//    if ([self.longPressDelegate respondsToSelector:@selector(longPress:)]) {
//        [self.longPressDelegate longPress:recognizer];
//    }
}


@end
