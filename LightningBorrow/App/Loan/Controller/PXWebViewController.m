//
//  PXWebViewController.m
//  LightningBorrow
//
//  Created by Qingyang Xu on 2018/12/25.
//  Copyright © 2018年 光磊信息. All rights reserved.
//

#import "PXWebViewController.h"
#import <WebKit/WebKit.h>
@interface PXWebViewController ()

@end

@implementation PXWebViewController


- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [super viewWillAppear:YES];
    NSUserDefaults*pushJudge = [NSUserDefaults standardUserDefaults];
    if([[pushJudge objectForKey:@"push"]isEqualToString:@"push"]) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"arrow back"] style:UIBarButtonItemStylePlain target:self action:@selector(rebackToRootViewAction)];
        self.title = @"产品详情";
        self.navigationItem.leftBarButtonItem.tintColor = UIColorWhite;
    }else{
    
    }
}
- (void)rebackToRootViewAction {
    NSUserDefaults * pushJudge = [NSUserDefaults standardUserDefaults];
    [pushJudge setObject:@""forKey:@"push"];
    [pushJudge synchronize];//记得立即同步
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self creatPopUI];
    self.title = _text;
    [QMUIConfiguration sharedInstance].statusbarStyleLightInitially = YES;
}

- (void)creatPopUI{
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, kNavBarHAbove7, kScreenW,kScreenH-kNavBarHAbove7)];
    NSURL *url = [NSURL URLWithString:_urlStr];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    [self.view addSubview:webView];
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
