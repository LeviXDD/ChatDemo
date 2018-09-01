//
//  PDBaseChatMessageTextCell.m
//  Chanel
//
//  Created by 海涛 黎 on 2017/6/22.
//  Copyright © 2017年 ruanxianxiang. All rights reserved.
//

#import "PDBaseChatMessageTextCell.h"
#import "PDChatInfoDefs.h"

@implementation PDBaseChatMessageTextCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.chatLabel];
        self.showMenuView = self.chatLabel;
        __weak typeof(self) weadSelf = self;
        _chatLabel.urlLinkTapHandler = ^(KILabel *label, NSString *string, NSRange range) {
            [weadSelf urlSkip:[NSURL URLWithString:string]];
        };
    }
    return self;
}

#pragma mark - 重写父类文本复制方法
-(void)copyMethod{
    if (self.chatLabel.text.length) {
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = self.chatLabel.text;
    }
}

#pragma mark - Private Method

- (void)setModelFrame:(PDMessageFrame *)modelFrame
{
    [super setModelFrame:modelFrame];
    self.chatLabel.frame = modelFrame.chatLabelF;
    if (modelFrame.model.message.attributContent) {
        self.chatLabel.attributedText = modelFrame.model.message.attributContent;
    }else{
        self.chatLabel.text = EMPTY_IF_NIL(modelFrame.model.message.content);
    }
}


- (void)attemptOpenURL:(NSURL *)url
{
    BOOL safariCompatible = [url.scheme isEqualToString:@"http"] || [url.scheme isEqualToString:@"https"];
    if (safariCompatible && [[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"警示" message:@"你的链接无效" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (void)urlSkip:(NSURL *)url{}

#pragma mark - Getter and Setter
- (KILabel *)chatLabel
{
    if (nil == _chatLabel) {
        _chatLabel = [[KILabel alloc] init];
        _chatLabel.numberOfLines = 0;
        _chatLabel.font = MessageFont;
        _chatLabel.textColor = XZRGB(0x282724);
    }
    return _chatLabel;
}
@end
