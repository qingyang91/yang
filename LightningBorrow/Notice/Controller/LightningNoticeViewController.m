//
//  LightningNoticeViewController.m
//  LightningBorrow
//
//  Created by 光磊信息 on 2018/12/12.
//  Copyright © 2018年 光磊信息. All rights reserved.
//

#import "LightningNoticeViewController.h"
#import "NoticeDetailViewController.h"

@interface LightningNoticeViewController ()

@end

@implementation LightningNoticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initUI];
}

- (void)initUI
{
    UIImageView *topImg = [[UIImageView alloc] initWithFrame:CGRectMake(AutoWidth(16), kNavBarHAbove7 - 3, kScreenW - AutoWidth(32), AutoHeight(153))];
    topImg.image = [UIImage imageNamed:@"公告banner"];
    topImg.layer.cornerRadius = 5;
    topImg.layer.masksToBounds = YES;
    [self.view addSubview:topImg];

    UILabel *checkLabel = [[UILabel alloc] init];
    checkLabel.text = @"审核调整";
    checkLabel.font = kSystemMainFont(20, UIFontWeightRegular);
    [self.view addSubview:checkLabel];
    
    [checkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(AutoWidth(17));
        make.top.equalTo(topImg.mas_bottom).with.offset(AutoHeight(37));
        make.height.offset(AutoHeight(28));
    }];

    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.text = @"2018/12/08";
    timeLabel.font = kSystemMainFont(12, UIFontWeightRegular);
    [self.view addSubview:timeLabel];
    
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).with.offset(-AutoWidth(16));
        make.bottom.equalTo(checkLabel);
        make.height.offset(AutoHeight(17));
    }];
    
    UILabel *infoLabel = [[UILabel alloc] init];
    infoLabel.text = @"审核调整：审核速度：10-30分钟下款；下款时间：5-10分钟……";
    infoLabel.font = kSystemMainFont(14, UIFontWeightRegular);
    infoLabel.numberOfLines = -1;
    [self.view addSubview:infoLabel];
    
    [infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(timeLabel);
        make.left.equalTo(checkLabel);
        make.top.equalTo(checkLabel.mas_bottom).with.offset(AutoHeight(7));
    }];
    
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [btn setTitle:@"了解详情 >" forState:(UIControlStateNormal)];
    [btn setTitleColor:[UIColor colorWithHexString:@"#314589"] forState:(UIControlStateNormal)];
    btn.titleLabel.font = kSystemMainFont(14, UIFontWeightRegular);
    [btn addTarget:self action:@selector(btnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).with.offset(-AutoWidth(14));
        make.top.equalTo(infoLabel.mas_bottom).with.offset(AutoHeight(8));
        make.width.offset(107);
        make.height.offset(32);
    }];
    btn.layer.borderWidth = 1.f;
    btn.layer.borderColor = [UIColor colorWithHexString:@"#314589"].CGColor;
    btn.layer.cornerRadius = 5;
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor colorWithHexString:@"#ECECEC"];
    [self.view addSubview:lineView];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(btn.mas_bottom).with.offset(AutoHeight(10));
        make.height.offset(AutoHeight(1));
    }];
}

- (void)btnClick
{
    NoticeDetailViewController *vc = [[NoticeDetailViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
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
