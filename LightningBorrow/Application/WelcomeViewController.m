//
//  WelcomeViewController.m
//  BorrowingMoney
//
//  Created by Qingyang Xu on 2018/12/11.
//  Copyright © 2018年 puxu. All rights reserved.
//

#import "WelcomeViewController.h"
#import "DHGuidePageHUD.h"
#import "PXTabBarViewController.h"
#import "AppDelegate.h"
#import "PlusWebViewController.h"
#import "RootViewController.h"
//#import "LightningTabbarController.h"

@interface WelcomeViewController ()

@end

@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupGuidePage];
}

//设置引导页
-(void)setupGuidePage{
    NSString *appVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    NSUserDefaults *usrDefault = [NSUserDefaults standardUserDefaults];
    NSString *lastVersion = [usrDefault objectForKey:BOOLFORKEY];
    if (![appVersion isEqualToString:lastVersion]) {
        
        [self setStaticGuidePage];
        
    }
    [usrDefault setObject:appVersion forKey:BOOLFORKEY];
    [usrDefault synchronize];
}
#pragma mark - 设置APP静态图片引导页
- (void)setStaticGuidePage {
    NSArray *imageNameArray;
    if (isIPhoneXSeries()) {
        imageNameArray = @[@"iPhone X"];
    }else{
        imageNameArray = @[@"引导页1"];
    }
   
    DHGuidePageHUD *guidePage = [[DHGuidePageHUD alloc] dh_initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH) imageNameArray:imageNameArray buttonIsHidden:NO];
    guidePage.slideInto = YES;
    [guidePage.startButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:guidePage];
}
- (void)buttonClick:(UIButton *)button {
    [UIView animateWithDuration:1.0 animations:^{
        self.view.alpha = 0;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self performSelector:@selector(removeGuidePageHUD) withObject:nil afterDelay:1];
            [self goToVersionB];
//            NSMutableDictionary  *parmers = [NSMutableDictionary dictionary];
//            [parmers setObject:@"2" forKey:@"vson"];
//            [parmers setObject:@"ios" forKey:@"from"];
//
//            [HMHttpTool GET:[NSString stringWithFormat:@"%@%@",Base_URL,@"/share/upmostees"] params:parmers success:^(NSURLSessionDataTask *task, id responseObject) {
//                NSString *status = [NSString stringWithFormat:@"%@", responseObject[@"status"]];
//                if ([status isEqualToString:@"200"]) {
//                    NSDictionary *dic = responseObject[@"data"];
//                    if ([dic[@"onss"] isEqualToString:@"6"]) {
//
//                        [self goToVersionB];
//                        return;
//                    }if ([dic[@"onss"] isEqualToString:@"7"]) {
//                        PlusWebViewController *vc = [[PlusWebViewController alloc] init];
//                        vc.urlStr = dic[@"url"];
//                        AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//                        delegate.window.rootViewController = vc;
//                        return;
//                    }else{
//                        [self goToVersionA];
//                    }
//
//                }else{
//                    [self goToVersionA];
//                }
//
//            } fail:^(NSURLSessionDataTask *task, NSError *error) {
//                [self goToVersionA];
//            }];
//            [HMHttpTool post:[NSString stringWithFormat:@"%@%@",Base_URL,@"/share/upmostees"] params:parmers success:^(NSDictionary *JSONDic) {
//                NSString *status = [NSString stringWithFormat:@"%@", JSONDic[@"status"]];
//                if ([status isEqualToString:@"200"]) {
//                    NSDictionary *dic = JSONDic[@"data"];
//                    if ([dic[@"status"] isEqualToString:@"0"]) {
//
//                        [self goToVersionB];
//                    }else{
//                        [self goToVersionA];
//                    }
//                }else{
//                    [self goToVersionA];
//                }
//
//            } failure:^(NSError *error) {
//                NSLog(@"%@",error);
//                [self goToVersionA];
//            }];
        });
    }];
}
- (void)goToVersionA
{
    LightningTabbarController *vc = [[LightningTabbarController alloc]init];
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    delegate.window.rootViewController = vc;


}

- (void)goToVersionB {
    
    UserInfoModel *info = [Utils GetUserInfo];
    if (kStringIsEmpty(info.phone)) {
        AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        RootViewController *vc = [[RootViewController alloc]init];
        delegate.window.rootViewController = vc;
    }else{
        PXTabBarViewController *tabVC = [[PXTabBarViewController alloc]init];
        AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        delegate.window.rootViewController = tabVC;
        
    }
    
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

- (void)removeGuidePageHUD {
    [self.view removeFromSuperview];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
