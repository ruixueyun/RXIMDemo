//
//  RXIMSession.h
//  RXIMSdk
//
//  Created by 陈汉 on 2021/9/16.
//

#import <Foundation/Foundation.h>
#import "RXIMMessage.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    /** 未知 */
    RXSessionType_unknown = 0,
    RXSessionType_single,
    RXSessionType_group,
} RXSessionType;

/** 会话模型 */
@interface RXIMSession : NSObject

/** Session ID */
@property(nonatomic, copy) NSString *conversation_id;

/** 会话属性，位运算 */
@property (nonatomic,assign) NSInteger attr;

/** 会话选项，位运算 */
@property (nonatomic,assign) NSInteger option;

/** 会话创建毫秒时间戳 */
@property (nonatomic,assign) NSInteger create_milli_ts;

/** 会话最后更新的毫秒时间戳 */
@property (nonatomic,assign) NSInteger update_milli_ts;

/** 会话创建者 */
@property (nonatomic,copy) NSString *creator;

/** 会话cp扩展字段 */
@property (nonatomic, strong) NSDictionary<NSString *,NSString *> *ext;

/** 会话ims扩展字段 */
@property (nonatomic, strong) NSDictionary<NSString *,NSString *> *ims_ext;

/** 会话成员列表 */
@property (nonatomic, strong) NSArray *members;

/** 会话类型 */
@property (nonatomic, assign) RXSessionType type;

/** 会话状态 */
@property (nonatomic, assign) NSInteger status;

/** 最后一条消息 */
@property (nonatomic, strong) RXIMMessage *lastMessage;

/** 用户cpid */
@property (nonatomic, assign) NSInteger cpid;

/** 用户加入时间啊 */
@property (nonatomic, assign) NSInteger join_milli_ts;

/** 会话属性，位运算 */
@property (nonatomic,assign) NSInteger user_attr;

/** 会话选项，位运算 */
@property (nonatomic,assign) NSInteger user_option;

/** 用户cp扩展字段 */
@property (nonatomic, strong) NSDictionary<NSString *,NSString *> *user_ext;

/** 用户ims扩展字段 */
@property (nonatomic, strong) NSDictionary<NSString *,NSString *> *user_ims_ext;

/** 未读消息数 */
@property (nonatomic, assign) NSInteger redPoint;
//
///** 是否有人@我 */
//@property (nonatomic,assign) BOOL isATMe;


@end

NS_ASSUME_NONNULL_END
