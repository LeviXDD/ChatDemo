////
////  PDMessageProducerTool.m
////  Chanel
////
////  Created by 徐兆阳 on 17/6/22.
////  Copyright © 2017年 ruanxianxiang. All rights reserved.
////
//
//#import "PDMessageProducerTool.h"
//#import "XMPPMessageModel.h"
//#import "PDMessageChatModel.h"
//#import "OffLineRequestTool.h"
//
//@interface PDMessageProducerTool ()
//@property(nonatomic,retain)dispatch_queue_t msgSeriseQueue;
//@end
//@implementation PDMessageProducerTool
//WMSingletonM(PDMessageProducerTool)
//
//
//-(dispatch_queue_t)msgSeriseQueue{
//    if (!_msgSeriseQueue) {
//        _msgSeriseQueue =  dispatch_queue_create(QUEUE_CON_MSGPRODUCE, DISPATCH_QUEUE_CONCURRENT);
//    }return _msgSeriseQueue;
//}
////  逐条处理消息
//-(void)ProduceMessageWith:(id)originMSG{
//    dispatch_async(self.msgSeriseQueue, ^{
//        // 消息过滤
//        if (![originMSG isKindOfClass:[XMPPMessageModel class]]) {
//            return;
//        }
//        
//        XMPPMessageModel *produceXMPPModel = (XMPPMessageModel *)originMSG;
//        NSDictionary *chatContentDic = [self dictionaryWithJsonString:produceXMPPModel.chatContent];
//        
//        if ([[chatContentDic allKeys] containsObject:@"ImMessageList"]) { // 历史消息
//            __block NSString *returnChannelId = @"";
//            __block NSMutableArray *channelIdArr = [@[]mutableCopy];
//            for (NSString *contentJsonStr in [chatContentDic objectForKey:@"ImMessageList"]) {
//                PDMessageChatModel *chatProduceModel = [PDMessageChatModel mj_objectWithKeyValues:contentJsonStr];
//                // 消息保存
//                 [PDMessageWCDBAPI insertOneMSGToDB:contentJsonStr complete:^(NSString *channelId) {
//                     if (channelId.length) {
//                         [channelIdArr addObject:channelId];
//                     }
//                 }];
//            }
//            //消息入库 发通知
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    [[NSNotificationCenter defaultCenter]postNotificationName:NOTIFICATION_POST_NEW_MSG object:channelIdArr];
//                });
//
//        }else{ // 普通收发
//            PDMessageChatModel *chatProduceModel = [PDMessageChatModel mj_objectWithKeyValues:produceXMPPModel.chatContent];
//            // 消息保存
//                __block NSString *returnChannelId = @"";
//            __block NSMutableArray *channelIdArr = [@[]mutableCopy];
//                [PDMessageWCDBAPI insertOneMSGToDB:produceXMPPModel.chatContent complete:^(NSString *channelId) {
//                    if (channelId.length) {
//                        [channelIdArr addObject: channelId];
//                    }
//                    //消息入库 发通知
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                        [[NSNotificationCenter defaultCenter]postNotificationName:NOTIFICATION_POST_NEW_MSG object:channelIdArr];
//                    });
//                }];
//        }
//    });
//    dispatch_barrier_async(self.msgSeriseQueue, ^{
//    });
//}
//
//
//// 消息回执
//-(void)reciptMessageWithUUIDList:(NSMutableArray *)uuidList{
//    [OffLineRequestTool receiptMessageWithMessageIds:uuidList ];
//}
//
////  处理消息集合（离线消息）
//
//- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
//    if (jsonString == nil) {
//        return nil;
//    }
//    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
//    NSError *err;
//    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
//                                                        options:NSJSONReadingMutableContainers
//                                                          error:&err];
//    if(err) {
//        NSLog(@"json解析失败：%@",err);
//        return nil;
//    }
//    return dic;
//}
//
//
//@end

