//
//  TestActivity.m
//  RXIMSdkDemo
//
//  Created by 陈汉 on 2021/9/23.
//

#import "TestActivity.h"

@implementation TestActivity

+ (UIActivityCategory)activityCategory
{
    return UIActivityCategoryShare;
}

- (UIImage *)activityImage
{
    return [UIImage imageNamed:@"wechat_login_image@3x"];
}

- (NSString *)activityTitle
{
    return @"微信";
}

- (NSString *)activityType
{
    return @"activity";
}
 
- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems
{
    // basically in your case: return YES if activity items are urls
    return YES;
}
 
- (void)prepareWithActivityItems:(NSArray *)activityItems
{
    //open safari with urls (activityItems)
}


@end
