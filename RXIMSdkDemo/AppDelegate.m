//
//  AppDelegate.m
//  RXIMSdkDemo
//
//  Created by 陈汉 on 2021/8/18.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import <RXIMSdk/RXIMSdk.h>
#ifdef DEBUG
#import <DoraemonKit/DoraemonManager.h>
#endif

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
#ifdef DEBUG
    [[DoraemonManager shareInstance] install];
#endif
    //IM初始化
//    [[RXIMSDKManager sharedSDK] initWithProductId:@"test_product" channelId:@"test_channel" cpid:1000000 clientType:262657 baseUrl:@"https://ruixue.weiletest.com" ossUrl:@"http://youle.jixiangtest.com" ossEndpoint:@"https://oss-cn-beijing.aliyuncs.com" ossBucketName:@"youleims"];
    [[RXIMSDKManager sharedSDK] initWithProductId:@"423" channelId:@"102" cpid:1000005 clientType:262657 baseUrl:@"https://rx-api.weilemks.com" ossUrl:@"http://youle.jixiangtest.com" ossEndpoint:@"https://oss-cn-beijing.aliyuncs.com" ossBucketName:@"youleims"];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    ViewController *rootVC = [[ViewController alloc] init];
    self.window.rootViewController = rootVC;
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
