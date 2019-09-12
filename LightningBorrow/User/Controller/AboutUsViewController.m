//
//  AboutUsViewController.m
//  LightningBorrow
//
//  Created by 光磊信息 on 2018/12/17.
//  Copyright © 2018年 光磊信息. All rights reserved.
//

#import "AboutUsViewController.h"

@interface AboutUsViewController ()

@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"关于我们";
    
    UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, kNavBarHAbove7, kScreenW, kScreenH - kNavBarHAbove7 - KHeight_TabBar + 49)];
    imgV.image = [UIImage imageNamed:@"关于我们-1"];
    [self.view addSubview:imgV];
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
