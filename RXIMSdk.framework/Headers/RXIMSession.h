//
//  RXIMSession.h
//  RXIMSdk
//
//  Created by 陈汉 on 2021/9/16.
//

#import <Foundation/Foundation.h>
#import "RXIMMessage.h"

NS_ASSUME_NONNULL_BEGIN

/** 会话模型 */
@interface RXIMSession : NSObject

/** Session ID */
@property(nonatomic, copy) NSString *sessionID;

/** 会话属性，位运算 */
@property (nonatomic,assign) NSInteger attr;

/** 会话选项，位运算 */
@property (nonatomic,assign) NSInteger option;

/** 会话创建毫秒时间戳 */
@property (nonatomic,assign) NSInteger createTimestamp;

/** 会话最后更新的毫秒时间戳 */
@property (nonatomic,assign) NSInteger updateTimestamp;

/** 会话创建者 */
@property (nonatomic,copy) NSString *creator;

/** 会话cp扩展字段 */
@property (nonatomic, strong) NSDictionary<NSString *,NSString *> *ext;

/** 会话成员列表 */
@property (nonatomic, strong) NSArray *members;

/** 会话类型 */
@property (nonatomic, assign) RXIMSessionType type;

/** 会话状态 */
@property (nonatomic, assign) NSInteger status;

/** 最后一条消息 */
@property (nonatomic, strong) RXIMMessage *lastMessage;

/** 用户cpid */
@property (nonatomic, assign) NSInteger cpid;

/** 用户加入时间啊 */
@property (nonatomic, assign) NSInteger joinTimestamp;

/** 会话属性，位运算 */
@property (nonatomic,assign) NSInteger userAttr;

/** 会话选项，位运算 */
@property (nonatomic,assign) NSInteger userOption;

/** 用户cp扩展字段 */
@property (nonatomic, strong) NSDictionary<NSString *,NSString *> *userExt;

/** 未读消息数 */
@property (nonatomic, assign) NSInteger unreadCount;

@end

NS_ASSUME_NONNULL_END
