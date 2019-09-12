//
//  PXTabBarViewController.m
//  BorrowingMoney
//
//  Created by Qingyang Xu on 2018/8/24.
//  Copyright © 2018年 puxu. All rights reserved.
//

#import "PXTabBarViewController.h"
#import "PXNaviViewController.h"
#import "HomeViewController.h"
#import "LoanViewController.h"
#import "MineViewController.h"
#import "LoginViewController.h"
@interface PXTabBarViewController ()<UITabBarControllerDelegate>

@end

@implementation PXTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tabBar.barTintColor = [UIColor whiteColor];
    self.delegate = self;
    HomeViewController *homeTableC = [[HomeViewController alloc] init];
    [self addChildVc:homeTableC title:@"首页" image:@"首页 copy" selectedImage:@"首页click"];
    LoanViewController *loanTableC = [[LoanViewController alloc]init];
    [self addChildVc:loanTableC title:@"贷款" image:@"贷款1" selectedImage:@"贷款click"];
   
    MineViewController *userTableC = [[MineViewController alloc]init];
    [self addChildVc:userTableC title:@"我的" image:@"我的 copy" selectedImage:@"我的"];
}

- (void)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    // 设置子控制器的文字
    childVc.title = title;
    
    // 设置子控制器的图片
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 设置文字的样式
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor colorWithHexString:@"#565656"];
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:11];
    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
    selectTextAttrs[NSForegroundColorAttributeName] = kAppNavColor;
    selectTextAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:11];
    
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [childVc.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
    //文字上移
    [childVc.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -3)];
    
    PXNaviViewController *nav = [[PXNaviViewController alloc] initWithRootViewController:childVc];
    
    // 添加为子控制器
    [self addChildViewController:nav];
}

//- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
//    UserInfoModel *model = [Utils GetUserInfo];
//    UINavigationController *nav = (UINavigationController *)viewController;
//    if([nav.viewControllers[0] isKindOfClass:[MineViewController class]]){
//        if(kStringIsEmpty(model.uid)){
//            LoginViewController *vcLogin = [[LoginViewController alloc] init];
//            UINavigationController *vcNavigation = [[UINavigationController alloc] initWithRootViewController:vcLogin];
//            [viewController presentViewController:vcNavigation animated:YES completion:nil];
//            return NO;
//        }else{
//            return YES;
//        }
//    }
//    return YES;
//}

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
