//
//  RXIMMessage.h
//  RXIMSdk
//
//  Created by 陈汉 on 2021/8/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * 消息类型
 */
typedef enum : NSUInteger {
    /** 未知 */
    RXIMMessageType_UnknownMt = 0,
    /** 会话内提示消息 */
    RXIMMessageType_Tips = 1,
    /** 文字 */
    RXIMMessageType_Text = 2,
    /** 图片 */
    RXIMMessageType_Image = 3,
    /** 语音 */
    RXIMMessageType_Audio = 4,
    /** 视频 */
    RXIMMessageType_Video = 5,
    /** 文件 */
    RXIMMessageType_File = 6,
    /** 表情 */
    RXIMMessageType_Face = 7,
    /** 位置 */
    RXIMMessageType_Position = 8,
    /** 回复 */
    RXIMMessageType_Reply = 9,
    /** 自定义 */
    RXIMMessageType_Custom = 101,
    /** 已读 */
    RXIMMessageType_read = 201,
    /** 撤回 */
    RXIMMessageType_recall = 202,
} RXIMMessageType;

/** 会话类型 */
typedef enum : NSUInteger {
    /** 未知 */
    RXIMSessionType_UnknownTt = 0,
    /** 单聊 */
    RXIMSessionType_single,
    /** 群聊 */
    RXIMSessionType_group,
    /** 自定义单聊 */
    RXIMSessionType_custom,
    /** 频道聊天 */
    RXIMSessionType_channel
} RXIMSessionType;

/** 消息状态 */
typedef enum : NSUInteger {
    /** 发送失败 */
    RXIMMsgStatus_failed = 0,
    /** 发送成功 */
    RXIMMsgStatus_success = 1,
    /** 发送中 */
    RXIMMsgStatus_sending = 2,
} RXIMMsgStatus;

/** 消息选项 */
typedef enum : NSUInteger {
    /** 开启离线消息和多端同步 */
    RXIMMsgOption_enableSync = 1,
    /** 保存历史消息 */
    RXIMMsgOption_saveHistory = 2,
    /** 开启已读回执 */
    RXIMMsgOption_readReceipt = 4
} RXIMMsgOption;

/** 消息体定义 */
@interface RXIMMessage : NSObject

/** 发送人id */
@property(nonatomic, copy) NSString *sender;

/** 会话id */
@property(nonatomic, copy) NSString *conversationId;

/** 接收人列表。对于群聊标@列表*/
@property (nonatomic, copy) NSMutableArray *receiversArray;

/** 会话类型 */
@property (nonatomic, assign) RXIMSessionType covType;

/** 消息类型 */
@property(nonatomic, assign) RXIMMessageType type;

/** 消息状态 */
@property(nonatomic, assign) RXIMMsgStatus status;

/** 消息属性，位运算组合，只读*/
@property (nonatomic, assign) NSInteger attr;

/** 消息选项 RXIMMsgOption 位运算组合  */
@property (nonatomic, assign) NSInteger option;

/** 子消息类型 */
@property(nonatomic, assign) NSInteger subType;

/** 发送人客户端类型 */
@property(nonatomic, assign) NSInteger clientType;

/** 服务端唯一消息号 */
@property(nonatomic, copy) NSString *msgId;

/** 消息发送者本地消息序号, 仅在客户端发送消息时有值 */
@property(nonatomic, assign) NSInteger uuid;

/** 当前用户同步序列号 */
@property (nonatomic,assign) NSInteger inboxId;

/** 时间戳, 精确到毫秒 */
@property(nonatomic, assign) NSInteger milliTs;

/** 推送信息(json) */
@property(nonatomic, copy) NSString *pushBody;

/** 扩展信息 */
@property(nonatomic, copy) NSDictionary<NSString *,NSString *> *ext;

/** 消息内容 */
@property (nonatomic, strong) id content;

/** 用户在该消息中的接收者编号 */
@property (nonatomic, assign) NSInteger receiverNum;

/** 是否为撤回消息 */
@property (nonatomic, assign) BOOL isRecall;

/** 消息未读数 */
@property (nonatomic, assign) NSInteger unreadCount;

@end

NS_ASSUME_NONNULL_END
