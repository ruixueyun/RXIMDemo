//
//  RXIMSessionService.h
//  RXIMSdk
//
//  Created by 陈汉 on 2021/9/16.
//

#import <Foundation/Foundation.h>
#import "RXIMSession.h"
#import "RXIMError.h"
#import "RXIMJoinSession.h"

NS_ASSUME_NONNULL_BEGIN


@protocol RXIMSessionServiceDelegate <NSObject>
@optional
/**
 * 会话最后一条消息变更
 * @param sessions 全量的会话结构
 */
- (void)onSessionLastMessageChanged:(NSArray<RXIMSession *> *)sessions;

/**
 * 会话未读消息数变更
 * @param sessions 全量的会话结构
 */
- (void)onSessionUnreadCountChanged:(NSArray<RXIMSession *> *)sessions;

@end

@interface RXIMSessionService : NSObject

@property (nonatomic, weak) id <RXIMSessionServiceDelegate> delegate;

/**
 * 获取SDK实例（单例）
 */
+ (instancetype)sharedSDK;

/** 服务器操作 */
/**
* 创建会话
* @param covId 会话id
* @param option 选项
* @param creatorOption 创建者选项
* @param members 成员
* @param ext 扩展字段
*/
- (void)creatConversation:(NSString * _Nonnull)covId
                          option:(NSInteger)option
                   creatorOption:(NSInteger)creatorOption
                         members:(NSArray * _Nullable)members
                            ext:(NSDictionary<NSString *,NSString *> * _Nullable)ext
               completionHandler:(void (^)(RXIMError *error))completionHandler;

/**
 * 更新会话数据
 * @param covId 会话id
 * @param option 选项
 * @param ext 扩展字段
 */
- (void)updateConversationInfo:(NSString * _Nonnull)covId
                        option:(NSInteger)option
                           ext:(NSDictionary<NSString *,NSString *> * _Nullable)ext
              completionHandler:(void (^)(RXIMError *error))completionHandler;

/**
 * 删除或解散会话
 * @param covId 会话id
 */
- (void)deleteConversation:(NSString * _Nonnull)covId
         completionHandler:(void (^)(RXIMError *error))completionHandler;

/**
 * 获取会话信息
 * @param covId 会话id
 */
- (void)getConversationInfo:(NSString * _Nonnull)covId
          completionHandler:(void (^)(RXIMSession *session,RXIMError *error))completionHandler;

/**
 * 加入会话
 * @param joinSessions 加入会话数组
 */
- (void)joinConversations:(NSArray<RXIMJoinSession *> * _Nonnull)joinSessions
        completionHandler:(void (^)(RXIMError *error))completionHandler;

/**
 * 离开会话
 * @param covIds 会话id数组
 */
- (void)leaveConversations:(NSArray * _Nonnull)covIds
         completionHandler:(void (^)(RXIMError *error))completionHandler;

/**
 * 更新用户在会话中信息
 * @param covId 会话id
 * @param option 选项
 * @param ext 扩展字段
 */
- (void)updateUserInfoToConversation:(NSString * _Nonnull)covId
                              option:(NSInteger)option
                                 ext:(NSDictionary<NSString *,NSString *> * _Nullable)ext
                    completionHandler:(void (^)(RXIMError *error))completionHandler;

/**
 * 获取服务器会话列表
 */
- (void)getConversationList:(void (^)(NSArray<RXIMSession *> *sessionInfoAry,RXIMError *error))completionHandler;

/** 本地数据库操作 */
/**
 * 获取本地所有会话列表
 */
-(NSArray *)getLocalConversationList;

/**
 * 根据会话id获取会话
 * @param covId 会话id
 */
- (RXIMSession *)getConversationWithCovId:(NSString * _Nonnull)covId;

/**
 * 清空会话的未读消息数
 * @param sessionId 会话id
 */
- (void)clearRedPoint:(NSString * _Nonnull)sessionId
             complete:(void(^)(RXIMError *error))complete;



@end

NS_ASSUME_NONNULL_END
