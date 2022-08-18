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
 * @param productId 产品id
 * @param channelId 渠道id
 * @param cpId 产品cpid
 * @param baseUrl 服务器域名
 * @param ossUrl oss域名
 * @param ossEndpoint oss endpoint
 * @param ossBucketName oss bucketName
 */
- (void)initWithProductId:(NSString * _Nonnull)productId
                channelId:(NSString * _Nonnull)channelId
                     cpid:(NSInteger)cpId
                  baseUrl:(NSString * _Nonnull)baseUrl
                   ossUrl:(NSString * _Nullable)ossUrl
              ossEndpoint:(NSString * _Nullable)ossEndpoint
            ossBucketName:(NSString * _Nullable)ossBucketName;

/***/

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
 * 设置数据库的基地址(非必须)
 */
- (void)setDBBasePath:(NSString * _Nullable)path;

@end

NS_ASSUME_NONNULL_END
