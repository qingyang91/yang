//
//  WebViewController.m
//  NewBorrowingMoney
//
//  Created by Qingyang Xu on 2018/12/24.
//  Copyright © 2018年 puxu. All rights reserved.
//

#import "WebViewController.h"
#import <WebKit/WebKit.h>

@interface WebViewController ()

@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIButton   *backBtn;
@property (nonatomic, strong) UIWebView  *dusWeb;

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self creatDisUI];
    self.title = _text;
}

- (void)creatDisUI{
    _topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kNavBarHAbove7)];
    _topView.backgroundColor = kAppNavColor;
    [self.view addSubview:self.topView];
    
    _backBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, kNavBarHAbove7/2, 28, 28)];
    [_backBtn setImage:[UIImage imageNamed:@"arrow back"] forState:UIControlStateNormal];
    [_backBtn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.topView addSubview:self.backBtn];
    
    _dusWeb = [[UIWebView alloc] initWithFrame:CGRectMake(0, kNavBarHAbove7, kScreenW, kScreenH-kNavBarHAbove7)];
    NSURL *url = [NSURL URLWithString:_urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_dusWeb loadRequest:request];
    [self.view addSubview:self.dusWeb];
}
- (void)btnClick{
    [self dismissViewControllerAnimated:YES completion:nil];
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
