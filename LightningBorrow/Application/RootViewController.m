//
//  RootViewController.m
//  Redfish
//
//  Created by Qingyang Xu on 2019/1/7.
//  Copyright © 2019年 puxu. All rights reserved.
//

#import "RootViewController.h"
#import "LoginViewController.h"

@interface RootViewController ()<UINavigationControllerDelegate>

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.delegate = self;
    UIImageView *imageView = [[UIImageView alloc]init];
    if (isIPhoneXSeries()) {
        imageView.image = [UIImage imageNamed:@"iPhone X Copy1"];
    }else{
        imageView.image = [UIImage imageNamed:@"首页 copy 4"];
    }
    imageView.frame = CGRectMake(0, 0, kScreenW, kScreenH);
    
    imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapPush)];
    [imageView addGestureRecognizer:tap];
    [self.view addSubview:imageView];
}

- (void)tapPush{
    LoginViewController *vc = [[LoginViewController alloc]init];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];
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
