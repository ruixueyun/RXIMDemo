//
//  RXIMSDK.h
//  RXIMSdk
//
//  Created by 陈汉 on 2021/8/19.
//

#import <Foundation/Foundation.h>
#import "RXIMError.h"

NS_ASSUME_NONNULL_BEGIN

@interface RXIMSDKManager : NSObject

/**
 * 获取SDK实例（单例）
 */
+ (instancetype)sharedSDK;

/**
 * 初始化SDK
 * @param appId 产品id
 * @param channelId 渠道id
 * @param cpId 产品cpid
 */
- (void)initWithAppId:(NSString * _Nonnull)appId
            channelId:(NSString * _Nonnull)channelId
                 cpid:(NSInteger)cpId;

/**
 * 登陆IM
 * @param userId 用户标识符，可以自定义或直接用瑞雪 OpenID
 * @param clientType 客户端类型
 */
- (void)loginRXIMSDKWithUserId:(NSString * _Nonnull)userId
                    clientType:(NSInteger)clientType
                     complete:(void(^)(RXIMError *error))complete;

/**
 * 退出登录IM
 */
- (void)logout;

/**
 * 设置数据库的基地址
 */
- (void)setDBBasePath:(NSString * _Nullable)path;

@end

NS_ASSUME_NONNULL_END
