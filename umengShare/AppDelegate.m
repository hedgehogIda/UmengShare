//
//  AppDelegate.m
//  umengShare
//
//  Created by 腾实信 on 2017/2/9.
//  Copyright © 2017年 ida. All rights reserved.
//

#import "AppDelegate.h"
#import <UMSocialCore/UMSocialCore.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
   
    [self configUSharePlatforms];
    
    return YES;
}

-(void)configUSharePlatforms{
    
    [[UMSocialManager defaultManager]openLog:YES];
    [[UMSocialManager defaultManager]accessibilityElementsHidden];
    
    [[UMSocialManager defaultManager]setUmSocialAppkey:@"589d1cc5717c1918f5002d0d"];
    
    
    [[UMSocialManager defaultManager]setPlaform:UMSocialPlatformType_Sina appKey:@"3032109644" appSecret:@"954d630851c0fe9c49898550fdc52b11" redirectURL:@"http://mobile.umeng.com/social"];
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wx324ddddc7be1064f" appSecret:@"ed6555275b472369803faf0efd557c35" redirectURL:@"http://mobile.umeng.com/social"];
    
    //去除微信中的收藏
    [[UMSocialManager defaultManager]removePlatformProviderWithPlatformType:UMSocialPlatformType_WechatFavorite];
    
}


- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
