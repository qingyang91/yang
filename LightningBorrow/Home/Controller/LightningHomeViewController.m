//
//  LightningHomeViewController.m
//  LightningBorrow
//
//  Created by 光磊信息 on 2018/12/12.
//  Copyright © 2018年 光磊信息. All rights reserved.
//

#import "LightningHomeViewController.h"
#import "LightingLoanViewController.h"
#import "TrueNameViewController.h"

@interface LightningHomeViewController ()

@end

@implementation LightningHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"闪现贷";
    
    [self initUI];
}

- (void)initUI
{
    UIImageView *topImg = [[UIImageView alloc] initWithFrame:CGRectMake(AutoWidth(16), kNavBarHAbove7 - 3, kScreenW - AutoWidth(32), AutoHeight(153))];
    topImg.image = [UIImage imageNamed:@"banner"];
    topImg.layer.cornerRadius = 5;
    topImg.layer.masksToBounds = YES;
    [self.view addSubview:topImg];
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(AutoWidth(16), topImg.endY + 18, kScreenW - AutoWidth(32), kScreenH - KHeight_TabBar - topImg.endY - 18 - 17)];
    backView.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
    backView.layer.cornerRadius = 5;
    [self.view addSubview:backView];
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(AutoWidth(11), AutoHeight(13), backView.width - AutoWidth(22), backView.height - AutoHeight(26))];
    bottomView.backgroundColor = [UIColor whiteColor];
    bottomView.layer.cornerRadius = 5;
    [backView addSubview:bottomView];
    
    UILabel *highLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, AutoWidth(100), AutoHeight(30))];
    highLabel.center = CGPointMake(bottomView.width / 2, AutoHeight(50));
    highLabel.text = @"最高可借";
    highLabel.textAlignment = NSTextAlignmentCenter;
    highLabel.font = kSystemMainFont(22, UIFontWeightRegular);
    [bottomView addSubview:highLabel];
    
    UIImageView *moneyImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, AutoWidth(203), AutoHeight(47))];
    moneyImg.center = CGPointMake(bottomView.width / 2, AutoHeight(101.5));
    moneyImg.image = [UIImage imageNamed:@"Group 2"];
    [bottomView addSubview:moneyImg];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(AutoWidth(33), AutoHeight(146), bottomView.width - AutoWidth(66), AutoHeight(1))];
    lineView.backgroundColor = [UIColor colorWithHexString:@"#EFEFEF"];
    [bottomView addSubview:lineView];
    
    UILabel *borrowLabel = [[UILabel alloc] initWithFrame:CGRectMake(AutoWidth(38), AutoHeight(173), AutoWidth(100), AutoHeight(21))];
    borrowLabel.text = @"借款金额(元)";
    borrowLabel.textAlignment = NSTextAlignmentLeft;
    borrowLabel.font = kSystemMainFont(15, UIFontWeightRegular);
    [bottomView addSubview:borrowLabel];
    
    UILabel *deadlineLabel = [[UILabel alloc] initWithFrame:CGRectMake(AutoWidth(212), AutoHeight(173), AutoWidth(70), AutoHeight(21))];
    deadlineLabel.text = @"借款期限";
    deadlineLabel.textAlignment = NSTextAlignmentLeft;
    deadlineLabel.font = kSystemMainFont(15, UIFontWeightRegular);
    [bottomView addSubview:deadlineLabel];
    
    UILabel *moneyLabel = [[UILabel alloc] init];
    moneyLabel.text = @"1000-10000";
    moneyLabel.textAlignment = NSTextAlignmentLeft;
    moneyLabel.textColor = [UIColor colorWithHexString:@"#FF8F00"];
    moneyLabel.font = kSystemMainFont(18, UIFontWeightRegular);
    [bottomView addSubview:moneyLabel];
    
    [moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomView).with.offset(AutoWidth(30));
        make.top.equalTo(borrowLabel.mas_bottom).with.offset(2);
        make.height.offset(AutoHeight(25));
    }];
    
    UILabel *dayLabel = [[UILabel alloc] init];
    dayLabel.text = @"7-14天";
    dayLabel.textAlignment = NSTextAlignmentRight;
    dayLabel.textColor = [UIColor colorWithHexString:@"#FF8F00"];
    dayLabel.font = kSystemMainFont(18, UIFontWeightRegular);
    [bottomView addSubview:dayLabel];
    
    [dayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bottomView).with.offset(-AutoWidth(51));
        make.top.equalTo(borrowLabel.mas_bottom).with.offset(2);
        make.height.offset(AutoHeight(25));
    }];
    
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    
    [btn setBackgroundImage:[UIImage imageNamed:@"Rectangle Copy"] forState:(UIControlStateNormal)];
    [btn setTitle:@"立即借款" forState:(UIControlStateNormal)];
    btn.titleLabel.font = kSystemMainFont(20, UIFontWeightRegular);
    [btn addTarget:self action:@selector(btnClick) forControlEvents:(UIControlEventTouchUpInside)];
    
    btn.layer.cornerRadius = AutoHeight(27);
    btn.layer.masksToBounds = YES;
    
    UIView *shadowView = [[UIView alloc]initWithFrame:CGRectMake(AutoWidth(34), AutoHeight(242), AutoWidth(262), AutoHeight(54))];
    [bottomView addSubview:shadowView];
    shadowView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    shadowView.layer.shadowOffset = CGSizeMake(2, 2);
    shadowView.layer.shadowOpacity = 1;
    shadowView.layer.cornerRadius = AutoHeight(27);
    shadowView.clipsToBounds = NO;
    btn.frame = CGRectMake(0, 0, AutoWidth(262), AutoHeight(54));
    [shadowView addSubview:btn];
    
    
    UIImageView *infoImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"关于我们"]];
    [bottomView addSubview:infoImg];
    
    [infoImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.offset(AutoHeight(14));
        make.top.equalTo(btn.mas_bottom).with.offset(14);
        make.left.equalTo(btn).with.offset(AutoWidth(68));
    }];
    
    UILabel *infoLabel = [[UILabel alloc] init];
    infoLabel.text = @"不向学生提供服务";
    infoLabel.font = kSystemMainFont(12, UIFontWeightRegular);
    infoLabel.textColor = [UIColor colorWithHexString:@"#919191"];
    [bottomView addSubview:infoLabel];
    
    [infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(infoImg.mas_right).with.offset(AutoWidth(8));
        make.centerY.equalTo(infoImg);
        make.height.offset(AutoHeight(17));
    }];
}

- (void)btnClick
{    UserInfoModel *info = [Utils GetUserInfo];
    if (kStringIsEmpty(info.phone)) {
        LightningLoginViewController *vc = [[LightningLoginViewController alloc]init];
        [self presentViewController:vc animated:YES completion:nil];
    } else {
        if (![info.isTrueName isEqualToString:@"1"]) {
            TrueNameViewController *vc = [[TrueNameViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        } else {
            LightingLoanViewController *vc = [[LightingLoanViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
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
