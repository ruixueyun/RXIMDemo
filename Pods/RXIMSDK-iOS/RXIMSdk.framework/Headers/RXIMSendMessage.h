//
//  RXIMSendMessage.h
//  RXIMSdk
//
//  Created by weiyongjian on 2021/11/19.
//

#import <Foundation/Foundation.h>
#import "RXIMMessage.h"

NS_ASSUME_NONNULL_BEGIN

@interface RXIMSendMessage : NSObject

/** 会话 ID，个人（UserIDA < UserIDB，字典序比较）：$1$UserIDA:UserIDB；群：$2$群ID */
@property(nonatomic, copy) NSString *conversationId;

/** 会话类型 */
@property (nonatomic, assign) RXIMSessionType covType;

/** 消息类型 */
@property(nonatomic, assign) RXIMMessageType type;

/** 消息选项 位运算 RXIMMsgOption组合 默认：7 */
@property (nonatomic, assign) NSInteger option;

/** 扩展信息 */
@property(nonatomic, copy) NSDictionary<NSString *,NSString *> *ext;

/** 消息内容 */
@property (nonatomic, strong) id content;

@end

NS_ASSUME_NONNULL_END
