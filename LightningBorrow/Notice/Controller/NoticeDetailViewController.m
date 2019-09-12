//
//  NoticeDetailViewController.m
//  LightningBorrow
//
//  Created by 光磊信息 on 2018/12/17.
//  Copyright © 2018年 光磊信息. All rights reserved.
//

#import "NoticeDetailViewController.h"

@interface NoticeDetailViewController ()

@end

@implementation NoticeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"审核调整";
    
    UILabel *checkLabel = [[UILabel alloc] init];
    checkLabel.text = @"审核调整:";
    checkLabel.font = kSystemMainFont(20, UIFontWeightRegular);
    [self.view addSubview:checkLabel];
    
    [checkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(AutoWidth(16));
        make.top.equalTo(self.view).with.offset(kNavBarHAbove7 + AutoHeight(16));
        make.height.offset(AutoHeight(25));
    }];
    
    UILabel *infoLabel = [[UILabel alloc] init];
    infoLabel.text = @"审核调整：审核速度：10-30分钟下款\n下款时间：5-10分钟";
    infoLabel.font = kSystemMainFont(14, UIFontWeightRegular);
    infoLabel.numberOfLines = -1;
    [self.view addSubview:infoLabel];
    
    [infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).with.offset(-AutoHeight(16));
        make.left.equalTo(checkLabel);
        make.top.equalTo(checkLabel.mas_bottom).with.offset(AutoHeight(16));
    }];

    
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.text = @"2018/12/08";
    timeLabel.font = kSystemMainFont(12, UIFontWeightRegular);
    [self.view addSubview:timeLabel];
    
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).with.offset(-AutoWidth(16));
        make.top.equalTo(infoLabel).with.offset(AutoHeight(24));
        make.height.offset(AutoHeight(17));
    }];
    
    
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
