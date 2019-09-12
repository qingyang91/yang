//
//  LightningNavViewController.m
//  LightningBorrow
//
//  Created by 光磊信息 on 2018/12/12.
//  Copyright © 2018年 光磊信息. All rights reserved.
//

#import "LightningNavViewController.h"

@interface LightningNavViewController ()

@end

@implementation LightningNavViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationBar setShadowImage:[UIImage new]];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //设置tab图片不渲染保持原始的
    self.tabBarItem.selectedImage = [self.tabBarItem.selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //设置导航栏背景
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"橙色"] forBarMetrics:UIBarMetricsDefault];
    // 修改标题颜色/字体/背影
    
    
    //,NSShadowAttributeName:[NSValue valueWithUIOffset:UIOffsetZero]
    
    self.interactivePopGestureRecognizer.delegate = nil;
}

// 修改状态栏格式
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0)
    { // 如果现在push的不是栈底控制器(最先push进来的那个控制器)
        viewController.hidesBottomBarWhenPushed = YES;
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageOriginalWithName:@"Artboard 2 Copy 7"] style:UIBarButtonItemStyleDone target:self action:@selector(backClick)];
        
    }
    [super pushViewController:viewController animated:animated];
}


- (void)backClick
{
    [self popViewControllerAnimated:YES];
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
