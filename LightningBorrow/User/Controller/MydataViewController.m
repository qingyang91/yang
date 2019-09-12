//
//  MydataViewController.m
//  LightningBorrow
//
//  Created by 光磊信息 on 2018/12/13.
//  Copyright © 2018年 光磊信息. All rights reserved.
//

#import "MydataViewController.h"
#import "MydataView.h"
#import "TrueNameViewController.h"
#import "RelationViewController.h"
#import "OperatorViewController.h"
#import "BankViewController.h"

@interface MydataViewController ()

@end

@implementation MydataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"我的资料";
    
    [self initUI];
}

- (void)initUI
{
    NSArray *array = @[@"实名认证", @"常用联系家属\n(务必家属)", @"运营商信息", @"银行卡绑定"];
    UserInfoModel *info = [Utils GetUserInfo];
    float a = (kScreenW - 86 - 180) / 2;
    for (int i = 0; i < array.count; i++) {
        NSString *imageName;
        if (i == 1) {
            imageName = @"常用联系家属";
        } else {
            imageName = array[i];
        }
        MyDataView *view = [[MyDataView alloc] initWithFrame:CGRectMake((i % 3) * (60 + a) + 43, (i / 3) * (88 + 53) + kIs_iPhoneXSeries(122, 98), 60, 93) ImageName:imageName title:array[i]];
        if (i == 0) {
            if ([info.isTrueName isEqualToString:@"1"]) {
                view.attestationLabel.text = @"已认证";
            } else {
                view.attestationLabel.text = @"未认证";
            }
        }
        if (i == 1) {
            if ([info.isRelation isEqualToString:@"1"]) {
                view.attestationLabel.text = @"已认证";
            } else {
                view.attestationLabel.text = @"未认证";
            }
        }
        if (i == 2) {
            if ([info.isOperator isEqualToString:@"1"]) {
                view.attestationLabel.text = @"已认证";
            } else {
                view.attestationLabel.text = @"未认证";
            }
        }
        if (i == 3) {
            if ([info.isCard isEqualToString:@"1"]) {
                view.attestationLabel.text = @"已认证";
            } else {
                view.attestationLabel.text = @"未认证";
            }
        }
        view.tag = i + 10;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [view addGestureRecognizer:tap];
        [self.view addSubview:view];
    }
}

- (void)tapAction:(UIGestureRecognizer *)gesture
{
    NSInteger tag = gesture.view.tag;
    
    if (tag == 10) {
        TrueNameViewController *vc = [[TrueNameViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (tag == 11) {
        RelationViewController *vc = [[RelationViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (tag == 12) {
        OperatorViewController *vc = [[OperatorViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        BankViewController *vc = [[BankViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
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
