//
//  AppDelegate.m
//  RXIMSdkDemo
//
//  Created by 陈汉 on 2021/8/18.
//

#import "AppDelegate.h"
#import "ViewController.h"
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
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    ViewController *rootVC = [[ViewController alloc] init];

    UINavigationController *naVC = [[UINavigationController alloc] initWithRootViewController:rootVC];
    self.window.rootViewController = naVC;
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
