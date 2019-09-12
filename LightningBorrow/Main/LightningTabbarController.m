//
//  LightningViewController.m
//  LightningBorrow
//
//  Created by 光磊信息 on 2018/12/12.
//  Copyright © 2018年 光磊信息. All rights reserved.
//

#import "LightningTabbarController.h"
#import "LightningNavViewController.h"
#import "LightningHomeViewController.h"
#import "LightningNoticeViewController.h"
#import "LightningUserViewController.h"
#import "DHGuidePageHUD.h"

@interface LightningTabbarController ()

@end

@implementation LightningTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tabBar.barTintColor = [UIColor whiteColor];
    
    LightningHomeViewController *homeVC = [[LightningHomeViewController alloc] init];
    [self addUserChildVc:homeVC title:@"首页" image:@"首页 copy" selectedImage:@"首页"];
    LightningNoticeViewController *noticeVC = [[LightningNoticeViewController alloc]init];
    [self addUserChildVc:noticeVC title:@"公告" image:@"公告" selectedImage:@"公告 copy"];
    LightningUserViewController *userVC = [[LightningUserViewController alloc]init];
    [self addUserChildVc:userVC title:@"我的" image:@"我的" selectedImage:@"我的 copy 3"];
//    [self setupGuidePage];
}

- (void)addUserChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    // 设置子控制器的文字
    childVc.title = title;
    
    // 设置子控制器的图片
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 设置文字的样式
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor colorWithHexString:@"#B1B1B1"];
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:11];
    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
    selectTextAttrs[NSForegroundColorAttributeName] = [UIColor colorWithHexString:@"#314589"];
    selectTextAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:11];
    
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [childVc.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
    //文字上移
    [childVc.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -3)];
    childVc.view.backgroundColor = [UIColor whiteColor];
    LightningNavViewController *nav = [[LightningNavViewController alloc] initWithRootViewController:childVc];
    
    // 添加为子控制器
    [self addChildViewController:nav];
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
    
    if (isIPhoneXSeries()) {
        NSArray *imageNameArray = @[@"iPhone X",@"iPhone X Copy",@"iPhone X Copy 2"]; DHGuidePageHUD *guidePage = [[DHGuidePageHUD alloc] dh_initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH) imageNameArray:imageNameArray buttonIsHidden:NO];
        guidePage.slideInto = YES;
        [self.view addSubview:guidePage];
    } else {
        NSArray *imageNameArray = @[@"引导页1",@"引导页2",@"引导页3"];
        DHGuidePageHUD *guidePage = [[DHGuidePageHUD alloc] dh_initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH) imageNameArray:imageNameArray buttonIsHidden:NO];
        guidePage.slideInto = YES;
        [self.view addSubview:guidePage];
    }
   
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
