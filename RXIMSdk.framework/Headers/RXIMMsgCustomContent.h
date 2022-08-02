//
//  RXIMMsgCustomContent.h
//  RXIMSdk
//
//  Created by 陈汉 on 2021/9/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RXIMMsgCustomContent : NSObject

/** 类型 type设置需大于100，100以下供sdk内部使用 */
@property (nonatomic,assign) NSInteger type;

/** 数据 */
@property (nonatomic, copy) NSDictionary * _Nullable data;

@end

NS_ASSUME_NONNULL_END
