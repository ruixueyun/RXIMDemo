//
//  RXIMMessage.h
//  RXIMSdk
//
//  Created by 陈汉 on 2021/8/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

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
    /** 合并转发 */
    RXIMMessageType_MergeTransmit = 10,
    /** 自定义 */
    RXIMMessageType_Custom = 101,
} RXIMMessageType;

typedef enum : NSUInteger {
    /** 未知 */
    RXIMSessionType_UnknownTt = 0,
    /** 单聊 */
    RXIMSessionType_single,
    /** 群聊 */
    RXIMSessionType_group,
} RXIMSessionType;

typedef enum : NSUInteger {
    /** 发送失败 */
    RXIMMsgStatus_failed = 0,
    /** 发送成功 */
    RXIMMsgStatus_success = 1,
    /** 发送中 */
    RXIMMsgStatus_sending = 2,
} RXIMMsgStatus;

typedef enum : NSUInteger {
    /** 已读 */
    RXIMMsgAttr_read = 1,
    /** 回复 */
    RXIMMsgAttr_recall = 2,
    /** 删除 */
    RXIMMsgAttr_delete = 4,
} RXIMMsgAttr;

typedef enum : NSUInteger {
    /** 开启离线消息和多端同步 */
    RXIMMsgOption_enableSync = 1,
    /** 保存历史消息 */
    RXIMMsgOption_saveHistory = 2,
    /** 开启已读回执 */
    RXIMMsgOption_readReceipt = 4
} RXIMMsgOption;

typedef enum : NSUInteger {
    /** 群创建 */
    RXGroupOptioinType_create = 1,
} RXGroupOptioinType;

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

/** 当前消息的未读数。单聊时只会是0或1，0表示对方已读；群聊表示具体还有多少人未读*/
@property (nonatomic, assign) NSInteger unreadCount;

/** 用户在该消息中的接收者编号，只有大于 0 时才需要发送已读，且发送已读确认时需要发给服务器 */
@property (nonatomic, assign) NSInteger receiverNum;

@end

NS_ASSUME_NONNULL_END
