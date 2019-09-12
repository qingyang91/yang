//
//  PlusWebViewController.m
//  shell9Plus
//
//  Created by 光磊信息 on 2018/11/14.
//  Copyright © 2018年 puxu. All rights reserved.
//

#import "PlusWebViewController.h"

@interface PlusWebViewController ()

@end

@implementation PlusWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
   
    
    self.view.backgroundColor = [UIColor whiteColor];
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    
    NSURL *url = [NSURL URLWithString:self.urlStr];
    
   
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    

    [webView loadRequest:request];
    
    [self.view addSubview:webView];
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
