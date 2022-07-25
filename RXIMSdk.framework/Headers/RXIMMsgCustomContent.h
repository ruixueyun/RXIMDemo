//
//  RXIMMsgCustomContent.h
//  RXIMSdk
//
//  Created by 陈汉 on 2021/9/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RXIMMsgCustomContent : NSObject

/** 类型 */
@property (nonatomic,assign) NSInteger type;

/** 数据 */
@property (nonatomic, copy) NSDictionary *data;

@end

NS_ASSUME_NONNULL_END
