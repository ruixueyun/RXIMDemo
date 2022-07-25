//
//  RXIMSessionInfo.h
//  RXIMSdk
//
//  Created by weiyongjian on 2022/7/19.
//

#import <Foundation/Foundation.h>
#import "RXIMSession.h"

NS_ASSUME_NONNULL_BEGIN

@interface RXIMSessionInfo : NSObject

/** 会话 */
@property (nonatomic,strong) RXIMSession *Conversation;

/** 会话id */
@property (nonatomic,copy) NSString *ConversationID;

/** 用户id */
@property (nonatomic, copy) NSString *UserID;

/** 用户加入会话时间 */
@property (nonatomic,assign) NSInteger JoinMilliTS;

/** 接受者编号 */
@property (nonatomic, assign) NSInteger ReceiverNum;

/** 用户在该会话属性，位运算 */
@property (nonatomic,assign) NSInteger attr;

/** 用户在该会话选项，位运算 */
@property (nonatomic,assign) NSInteger option;

/** 用户在该会话中状态 */
@property (nonatomic,assign) NSInteger status;

/** cp给用户在会话中设置的扩展数据*/
@property (nonatomic, strong) NSDictionary<NSString *,NSString *> *ext;

/** ims给用户在会话中设置的扩展数据 */
@property (nonatomic, strong) NSDictionary<NSString *,NSString *> *ims_ext;

@end

NS_ASSUME_NONNULL_END
