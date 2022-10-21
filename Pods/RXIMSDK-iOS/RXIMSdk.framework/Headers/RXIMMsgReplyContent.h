//
//  RXIMMsgReplyContent.h
//  RXIMSdk
//
//  Created by weiyongjian on 2021/12/7.
//

#import <Foundation/Foundation.h>
#import "RXIMMessage.h"

NS_ASSUME_NONNULL_BEGIN

@interface RXIMReferenceMsg : NSObject

/** 发送人id */
@property (nonatomic, copy) NSString *sender;
/** 消息内容 */
@property (nonatomic, strong) id content;
/** 服务端唯一消息号 */
@property (nonatomic, copy) NSString *msg_id;
/** 引用消息的毫秒时间戳 */
@property (nonatomic, assign) NSInteger milli_ts;
/** 引用消息类型 */
@property (nonatomic, assign) RXIMMessageType type;
/** 引用消息子类型 */
@property (nonatomic, assign) NSInteger sub_type;

@end

@interface RXIMReplyMsg : NSObject

/** 回复的消息类型 */
@property (nonatomic, assign) NSInteger type;
/** 回复的消息子类型 */
@property (nonatomic, assign) NSInteger sub_type;
/** 回复的消息内容 */
@property (nonatomic, strong) id content;

@end

@interface RXIMMsgReplyContent : NSObject

/** 引用的消息 */
@property(nonatomic, strong) RXIMReferenceMsg *reference;

/** 回复的消息 */
@property(nonatomic, strong) RXIMReplyMsg *reply;

@end

NS_ASSUME_NONNULL_END
