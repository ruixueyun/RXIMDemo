//
//  RXIMChatService.h
//  RXIMSdk
//
//  Created by 陈汉 on 2021/8/24.
//

#import <Foundation/Foundation.h>
#import "RXIMSendMessage.h"
#import "RXIMHistoryMsgResp.h"
#import "RXIMError.h"

NS_ASSUME_NONNULL_BEGIN

@protocol RXIMMessageDelegate <NSObject>
@optional
/**
 * 消息接收
 */
- (void)receiveMessage:(NSArray<RXIMMessage *> *)msgs;
/**
 * 消息发送成功
 */
- (void)sendMessageSuccess:(RXIMMessage *)msgObj;
/**
 * 消息发送失败
 */
- (void)sendMessageFailure:(RXIMMessage *)msgObj error:(RXIMError *)error;
/**
 * 服务端历史消息回执
 */
- (void)historyMessage:(RXIMHistoryMsgResp *)msgObj;

@end

@interface RXIMChatService : NSObject

@property (nonatomic, weak) id <RXIMMessageDelegate> delegate;

/**
 * 获取SDK实例（单例）
 */
+ (instancetype)sharedSDK;

/** 服务器操作 */
/**
 * 发送消息
 * @param sendMessage 发送的消息对象
 * @param completionHandler 返回消息对象，处理本地逻辑用，发送成功以delegate方式回调。
 */
- (void)sendMessage:(RXIMSendMessage * _Nonnull)sendMessage
  completionHandler:(void (^)(RXIMMessage * message,RXIMError *error))completionHandler;

/**
 * 重发消息
 * @param message 发送的消息对象
 * @param completionHandler 返回消息对象，处理本地逻辑用，发送成功以delegate方式回调。
 */
- (void)resendMessage:(RXIMMessage * _Nonnull)message
  completionHandler:(void (^)(RXIMMessage * message,RXIMError *error))completionHandler;

/**
 * 转发消息
 * @param mids 消息id数组
 * @param receives 会话id数组
 * @Param exts 扩展数组
 * @param completionHandler 返回消息对象，处理本地逻辑用，发送成功以delegate方式回调。
 */
- (void)forwardMessage:(NSArray * _Nonnull)mids
              receives:(NSArray * _Nonnull)receives
                   ext:(NSArray *)exts
     completionHandler:(void (^)(NSArray<RXIMMessage *> *messages,RXIMError *error))completionHandler;

/**
 * 消息已读
 * @param message 已读的消息体
 * @param completionHandler 返回消息处理是否正常，发送成功以delegate方式回调。
 */
- (void)readMessage:(RXIMMessage * _Nonnull)message completionHandler:(void (^)(RXIMError *error))completionHandler;

/**
 * 消息撤回
 * @param message 撤回的消息体
 * @param completionHandler 返回消息处理是否正常，发送成功以delegate方式回调。
 */
- (void)revokeMessage:(RXIMMessage * _Nonnull)message completionHandler:(void (^)(RXIMError *error))completionHandler;

/**
 * 获取服务端历史消息
 * @param msgId 消息锚点
 * @param target 会话id
 * @param limit 查询数量，最多一次拉取50条
 */
- (void)getServerHistoryMessageWithMsgId:(NSString * _Nullable)msgId
                            target:(NSString * _Nonnull)target
                             limit:(NSInteger)limit;
/** 本地数据库操作 */
/**
 * 获取本地历史消息
 * @param msgId 消息锚点
 * @param target 会话id
 * @param sessionType 会话类型
 * @param limit 查询数量
 * @param completionHandler 返回的消息数组。
 */
- (void)getLocalHistoryMessageWithMsgId:(NSString * _Nullable)msgId
                                 target:(NSString * _Nonnull)target
                            sessionType:(RXIMSessionType)sessionType
                                  limit:(NSInteger)limit
                      completionHandler:(void (^)(NSArray<RXIMMessage *> *messages,RXIMError *error))completionHandler;

/**
 * 通过消息id获取消息体
 * @param msgId 消息id
 */
-(RXIMMessage *)getMsgWithMsgid:(NSString * _Nonnull)msgId;

/**
 * 设置语音消息已播放
 * @param msgId 消息id
 */
- (BOOL)setAudioMessagePlayed:(NSString *)msgId;


@end

NS_ASSUME_NONNULL_END
