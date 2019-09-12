//
//  AppDelegate.m
//  LightningBorrow
//
//  Created by 光磊信息 on 2018/12/12.
//  Copyright © 2018年 光磊信息. All rights reserved.
//

#import "AppDelegate.h"
#import "LightningTabbarController.h"
#import "PlusWebViewController.h"
#import "WelcomeViewController.h"
#import "PXTabBarViewController.h"
#import "PXWebViewController.h"
#import "HomeViewController.h"
#import "PXNaviViewController.h"
#import <AdSupport/AdSupport.h>
#import "RootViewController.h"
// 引入 JPush 功能所需头文件
#import "JPUSHService.h"
// iOS10 注册 APNs 所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
#define appkey   @"823ec3dd01992fff227c3f72"
#define BOOLFORKEY @"dhGuidePage"
@interface AppDelegate ()<JPUSHRegisterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    self.tabBarVC = [[LightningTabbarController alloc] init];
    self.tabVC = [[PXTabBarViewController alloc]init];
    UIViewController *vc = [[UIViewController alloc]init];
    vc.view.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = vc;
    
    NSString *appVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    NSUserDefaults *usrDefault = [NSUserDefaults standardUserDefaults];
    NSString *lastVersion = [usrDefault objectForKey:BOOLFORKEY];
    if (![appVersion isEqualToString:lastVersion]) {
        
        WelcomeViewController *vc = [[WelcomeViewController alloc]init];
        self.window.rootViewController = vc;
        [self.window makeKeyAndVisible];
    }else{
        [self goToVersionB];
//        [self judgeVersion];
    }
    
    
    
    
    
    [[UITabBar appearance] setTranslucent:NO];
    [[UINavigationBar appearance] setTranslucent:YES];
    application.statusBarStyle = UIStatusBarStyleLightContent;
    application.statusBarHidden = NO;

   
    if (launchOptions) {
        NSDictionary * remoteNotification = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
        
        //这个判断是在程序没有运行的情况下收到通知，点击通知跳转页面
        if (remoteNotification) {
            NSLog(@"推送消息==== %@",remoteNotification);
            [self goToMssageViewControllerWith:remoteNotification];
        }
    }

    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    if (@available(iOS 12.0, *)) {
        entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound|JPAuthorizationOptionProvidesAppNotificationSettings;
    } else {
        entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    }
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        //    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
        //      NSSet<UNNotificationCategory *> *categories;
        //      entity.categories = categories;
        //    }
        //    else {
        //      NSSet<UIUserNotificationCategory *> *categories;
        //      entity.categories = categories;
        //    }
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];

    //如不需要使用IDFA，advertisingIdentifier 可为nil
    [JPUSHService setupWithOption:launchOptions appKey:appkey
                          channel:@"IOS"
                 apsForProduction:0
            advertisingIdentifier:nil];
    
    //2.1.9版本新增获取registration id block接口。
    [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
        if(resCode == 0){
            NSLog(@"registrationID获取成功：%@",registrationID);
            
        }
        else{
            NSLog(@"registrationID获取失败，code：%d",resCode);
        }
    }];

    [UMConfigure setEncryptEnabled:YES];
    [UMConfigure setLogEnabled:YES];
    [UMConfigure initWithAppkey:UMKEY channel:@"App Store"];
   
    return YES;
}

- (void)goToMssageViewControllerWith:(NSDictionary*)msgDic{
    //将字段存入本地，因为要在你要跳转的页面用它来判断,这里我只介绍跳转一个页面，
    NSUserDefaults*pushJudge = [NSUserDefaults standardUserDefaults];
    [pushJudge setObject:@"push"forKey:@"push"];
    [pushJudge synchronize];

    NSString *urlString = [self logDic:msgDic];
    if (!kStringIsEmpty(urlString)) {
        NSUserDefaults *pushJudge = [NSUserDefaults standardUserDefaults];
        [pushJudge setObject:@"push"forKey:@"push"];
        [pushJudge synchronize];
        PXWebViewController *vc = [[PXWebViewController alloc]init];
        vc.urlStr = urlString;
        vc.title = @"产品详情";
        
        if ([UIApplication sharedApplication].applicationState == UIApplicationStateInactive){
            [self getCurNavController];
            UINavigationController * Nav = [[UINavigationController alloc]initWithRootViewController:vc];
            [self.window.rootViewController presentViewController:Nav animated:YES completion:nil];
        }else{
            PXTabBarViewController *tabVC = [[PXTabBarViewController alloc]init];
            HomeViewController * ctrl = ((PXNaviViewController *)tabVC.viewControllers[0]).viewControllers[0];
            tabVC.selectedIndex = 0;
            UINavigationController * Nav = [[UINavigationController alloc]initWithRootViewController:vc];//这里加导航栏是因为我跳转的页面带导航栏，如果跳转的页面不带导航，那这句话请省去。
            [ctrl presentViewController:Nav animated:YES completion:nil];
        }
        NSLog(@"urlString======%@",urlString);
    }else{
        
    }
}
- (UINavigationController *)getCurNavController{
    PXTabBarViewController *vc = [[PXTabBarViewController alloc]init];
    UINavigationController* navController = (UINavigationController*)vc.selectedViewController; // tabbarVC为当前的根控制器
    
    return navController;
    
}


- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#pragma mark- JPUSHRegisterDelegate
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    NSDictionary * userInfo = notification.request.content.userInfo;
    
    UNNotificationRequest *request = notification.request; // 收到推送的请求
    UNNotificationContent *content = request.content; // 收到推送的消息内容
    
    NSNumber *badge = content.badge;  // 推送消息的角标
    NSString *body = content.body;    // 推送消息体
    UNNotificationSound *sound = content.sound;  // 推送消息的声音
    NSString *subtitle = content.subtitle;  // 推送消息的副标题
    NSString *title = content.title;  // 推送消息的标题
    
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        NSLog(@"iOS10 前台收到远程通知:%@", [self logDic:userInfo]);
        
//        [rootViewController addNotificationCount];
        
    }
    else {
        // 判断为本地通知
        NSLog(@"iOS10 前台收到本地通知:{\nbody:%@，\ntitle:%@,\nsubtitle:%@,\nbadge：%@，\nsound：%@，\nuserInfo：%@\n}",body,title,subtitle,badge,sound,userInfo);
    }
    completionHandler(UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以设置
}

- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    UNNotificationRequest *request = response.notification.request; // 收到推送的请求
    UNNotificationContent *content = request.content; // 收到推送的消息内容
    
    NSNumber *badge = content.badge;  // 推送消息的角标
    NSString *body = content.body;    // 推送消息体
    UNNotificationSound *sound = content.sound;  // 推送消息的声音
    NSString *subtitle = content.subtitle;  // 推送消息的副标题
    NSString *title = content.title;  // 推送消息的标题
    
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        NSLog(@"iOS10 收到远程通知:%@", [self logDic:userInfo]);
//        [rootViewController addNotificationCount];
        NSUserDefaults*pushJudge = [NSUserDefaults standardUserDefaults];
        [pushJudge setObject:@"push"forKey:@"push"];
        [pushJudge synchronize];
        
        NSString *urlString = [self logDic:userInfo];
        if (!kStringIsEmpty(urlString)) {
            NSUserDefaults *pushJudge = [NSUserDefaults standardUserDefaults];
            [pushJudge setObject:@"push"forKey:@"push"];
            [pushJudge synchronize];
            PXTabBarViewController *tabVC = [[PXTabBarViewController alloc]init];
            PXWebViewController *vc = [[PXWebViewController alloc]init];
            vc.urlStr = urlString;
            vc.title = @"产品详情";
            self.window.rootViewController = tabVC;
            UINavigationController * Nav = [[UINavigationController alloc]initWithRootViewController:vc];
            tabVC.selectedIndex = 0;
            [tabVC presentViewController:Nav animated:YES completion:nil];
            NSLog(@"urlString======%@",urlString);
        }else{
            
        }
    }
    else {
        // 判断为本地通知
        NSLog(@"iOS10 收到本地通知:{\nbody:%@，\ntitle:%@,\nsubtitle:%@,\nbadge：%@，\nsound：%@，\nuserInfo：%@\n}",body,title,subtitle,badge,sound,userInfo);
    }
    
    completionHandler();  // 系统要求执行这个方法
}

#endif

#ifdef __IPHONE_12_0
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center openSettingsForNotification:(UNNotification *)notification{
    NSString *title = nil;
    if (notification) {
        title = @"从通知界面直接进入应用";
        NSDictionary * userInfo = notification.request.content.userInfo;

        NSString *urlString = [self logDic:userInfo];
        if (!kStringIsEmpty(urlString)) {
            NSUserDefaults *pushJudge = [NSUserDefaults standardUserDefaults];
            [pushJudge setObject:@"push"forKey:@"push"];
            [pushJudge synchronize];
            PXWebViewController *vc = [[PXWebViewController alloc]init];
            vc.urlStr = urlString;
            vc.title = @"产品详情";
            UINavigationController * Nav = [[UINavigationController alloc]initWithRootViewController:vc];//这里加导航栏是因为我跳转的页面带导航栏，如果跳转的页面不带导航，那这句话请省去。
            [self.window.rootViewController presentViewController:Nav animated:YES completion:nil];
        }else{

        }
        
    }else{
        title = @"从系统设置界面进入应用";
    }

    
}
#endif


- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo
fetchCompletionHandler:
(void (^)(UIBackgroundFetchResult))completionHandler {
    [JPUSHService handleRemoteNotification:userInfo];
    NSLog(@"iOS7及以上系统，收到通知:%@", [self logDic:userInfo]);
    
    if ([[UIDevice currentDevice].systemVersion floatValue]<10.0 || application.applicationState>0) {
//        [rootViewController addNotificationCount];
    }
    
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    NSDictionary *aps = [userInfo valueForKey:@"aps"];
    NSString *content = [aps valueForKey:@"alert"]; //推送显示的内容
    NSInteger badge = [[aps valueForKey:@"badge"] integerValue]; //badge 数量
    NSString *sound = [aps valueForKey:@"sound"]; //播放的声音
    
    // 取得 Extras 字段内容
    NSString *customizeField1 = [userInfo valueForKey:@"extras"]; //服务端中 Extras 字段，key 是自己定义的
    NSLog(@"content =[%@], badge=[%d], sound=[%@], customize field  =[%@]",content,badge,sound,customizeField1);
    [JPUSHService handleRemoteNotification:userInfo];
    application.applicationIconBadgeNumber = 0;
    [self goToMssageViewControllerWith:userInfo];
   
   
    // Required, For systems with less than or equal to iOS 6
}
- (NSString *)logDic:(NSDictionary *)dic {
    if (![dic count]) {
        return nil;
    }
    NSString *tempStr1 =
    [[dic description] stringByReplacingOccurrencesOfString:@"\\u"
                                                 withString:@"\\U"];
    NSString *tempStr2 =
    [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 =
    [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString *str =
    [NSPropertyListSerialization propertyListFromData:tempData
                                     mutabilityOption:NSPropertyListImmutable
                                               format:NULL
                                     errorDescription:NULL];
    NSDictionary *apsDic = dic[@"aps"];
    NSString *string = apsDic[@"category"];
    return string;
}
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
    
}
- (void)judgeVersion {
 
    NSMutableDictionary  *parmers = [NSMutableDictionary dictionary];
    [parmers setObject:@"2" forKey:@"vson"];
    [parmers setObject:@"ios" forKey:@"from"];
    
    [HMHttpTool GET:[NSString stringWithFormat:@"%@%@",Base_URL,@"/share/upmostees"] params:parmers success:^(NSURLSessionDataTask *task, id responseObject) {
        NSString *status = [NSString stringWithFormat:@"%@", responseObject[@"status"]];
        if ([status isEqualToString:@"200"]) {
            NSDictionary *dic = responseObject[@"data"];
            if ([dic[@"onss"] isEqualToString:@"6"]) {
                
                [self goToVersionB];
                return;
            }if ([dic[@"onss"] isEqualToString:@"7"]) {
                PlusWebViewController *vc = [[PlusWebViewController alloc] init];
                vc.urlStr = dic[@"url"];
                self.window.rootViewController = vc;
                
                [self.window makeKeyAndVisible];
                return;
            }else{
                [self goToVersionA];
            }
            
        }else{
            [self goToVersionA];
        }
        
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        [self goToVersionA];
    }];
//
//    [HMHttpTool post:[NSString stringWithFormat:@"%@%@",Base_URL,@"/share/upmostees"] params:parmers success:^(NSDictionary *JSONDic) {
//        NSString *status = [NSString stringWithFormat:@"%@", JSONDic[@"status"]];
//        if ([status isEqualToString:@"200"]) {
//            NSDictionary *dic = JSONDic[@"data"];
//            if ([dic[@"status"] isEqualToString:@"0"]) {
//
//                [self goToVersionB];
//            }else{
//                [self goToVersionA];
//            }
//        }else{
//            [self goToVersionA];
//        }
//
//    } failure:^(NSError *error) {
//        NSLog(@"%@",error);
//        [self goToVersionA];
//    }];
}

- (void)goToVersionA
{
    self.window.rootViewController = self.tabBarVC;
    
    
    [self.window makeKeyAndVisible];
    
//    [UINavigationBar appearance].translucent = NO;
//    [UINavigationBar appearance].barTintColor = [UIColor colorWithHexString:@"#262A2E"];
}

- (void)goToVersionB {
    UserInfoModel *info = [Utils GetUserInfo];
    if (kStringIsEmpty(info.phone)) {
        RootViewController *vc = [[RootViewController alloc]init];
        self.window.rootViewController = vc;
    }else{
        self.window.backgroundColor = [UIColor clearColor];
        
        self.window.rootViewController = self.tabVC;
    }
    
    
   
    [self.window makeKeyAndVisible];
}

-(NSString *)getWANIP
{
    //通过淘宝的服务来定位WAN的IP，否则获取路由IP没什么用
    NSURL *ipURL = [NSURL URLWithString:@"http://ip.taobao.com/service/getIpInfo.php?ip=myip"];
    NSData *data = [NSData dataWithContentsOfURL:ipURL];
    if (data) {
        NSDictionary *ipDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil]; 
        NSString *ipStr = nil;
        if (ipDic && [ipDic[@"code"] integerValue] == 0) { //获取成功
            ipStr = ipDic[@"data"][@"country"];
        }
        return (ipStr ? ipStr : @"");
    }else{
        return @"";
    }
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
    [application setApplicationIconBadgeNumber:0];   //清除角标
    [application cancelAllLocalNotifications];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
