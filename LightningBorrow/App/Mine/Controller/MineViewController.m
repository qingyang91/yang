//
//  MineViewController.m
//  LightningBorrow
//
//  Created by Qingyang Xu on 2018/12/25.
//  Copyright © 2018年 光磊信息. All rights reserved.
//

#import "MineViewController.h"
#import "LoginViewController.h"
#import "FeedViewController.h"
#import "QuestionViewController.h"
#import "BusinessViewController.h"
#import "AboutViewController.h"
#import "MineTableViewCell.h"
#import "CustomAlertView.h"

@interface MineViewController ()<UINavigationBarDelegate,UITableViewDelegate,UITableViewDataSource,UIWebViewDelegate>

@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIImageView *headImaView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *titleArray;
@property (nonatomic, strong) NSMutableArray *imageArray;

@end

@implementation MineViewController

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColorWhite;
    self.navigationController.delegate = self;
    [self creatTopView];
}

- (void)creatTopView{
    _topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, AutoHeight(210))];
    _topView.backgroundColor = UIColorWhite;
    
    UIImageView *backIma = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"个人中心bg"]];
    [_topView addSubview:backIma];
    [backIma mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.topView);
        make.height.mas_equalTo(160);
    }];
    
    UIView *headView = [[UIView alloc]init];
    headView.backgroundColor = UIColorWhite;
    [headView addShadow];
    
    [_topView addSubview:headView];
    [headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.topView).with.offset(16);
        make.right.equalTo(self.topView).with.offset(-16);
        make.top.equalTo(self.topView).with.offset(AutoHeight(110));
        make.height.mas_equalTo(AutoHeight(100));
    }];
    
    UserInfoModel *info = [Utils GetUserInfo];
    
    UIButton *btn = [[UIButton alloc]init];
    if (kStringIsEmpty(info.phone)) {
        btn.userInteractionEnabled = YES;
        [btn setTitle:@"未登录" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(loginClick) forControlEvents:UIControlEventTouchUpInside];
    }else{
        btn.userInteractionEnabled = NO;
        [btn setTitle:[NSString stringWithFormat:@"%@****%@",[info.phone substringToIndex:3],[info.phone substringFromIndex:7]] forState:UIControlStateNormal];
    }
    [btn setTitleColor:UIColorBlack forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:18];
    [headView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headView).with.offset(24);
        make.top.equalTo(headView).with.offset(20);
    }];
   
    UILabel *phone = [[UILabel alloc]init];
    phone.font = [UIFont systemFontOfSize:12];
    phone.textColor = [UIColor colorWithHexString:@"#919191"];
    phone.numberOfLines = 2;
    phone.text = @"给我一瓶酒，再给我一只烟，说走就走 \n我有的是时间～";
    [headView addSubview:phone];
    [phone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(btn);
        make.top.equalTo(btn.mas_bottom).with.offset(6);
    }];
    
   
    [self.view addSubview:self.topView];
    
    UIView *midView = [[UIView alloc]init];
    midView.backgroundColor = UIColorWhite;
    [midView addShadow];
    [self.view addSubview:midView];
    [midView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(16);
        make.right.equalTo(self.view).with.offset(-16);
        make.top.equalTo(self.topView.mas_bottom).with.offset(10);
        make.height.mas_equalTo(AutoHeight(82));
    }];
    
    UIView *left = [[UIView alloc]init];
    
    left.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(leftTap)];
    [left addGestureRecognizer:tap];
    
    [midView addSubview:left];
    [left mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(midView);
        make.width.mas_equalTo((kScreenW-32)/2);
    }];
    
    UIImageView *qqIma = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"QQ"]];
    [left addSubview:qqIma];
    [qqIma mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(left).with.offset(25);
        make.centerY.equalTo(left.mas_centerY);
        make.width.height.mas_equalTo(36);
    }];
    
    UILabel *qqLabel = [[UILabel alloc]init];
    qqLabel.text = @"QQ咨询";
    qqLabel.font = [UIFont systemFontOfSize:14];
    [left addSubview:qqLabel];
    [qqLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(qqIma.mas_right).with.offset(9);
        make.top.equalTo(qqIma);
    }];
    
    UILabel *qqTipLabel = [[UILabel alloc]init];
    qqTipLabel.text = @"一对一贴心解答";
    qqTipLabel.textColor = [UIColor colorWithHexString:@"#919191"];
    qqTipLabel.font = [UIFont systemFontOfSize:12];
    [left addSubview:qqTipLabel];
    [qqTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(qqLabel);
        make.bottom.equalTo(qqIma);
    }];
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = [UIColor colorWithHexString:@"#D5D5D5"];
    [midView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(midView.mas_centerX);
        make.centerY.equalTo(midView.mas_centerY);
        make.width.mas_equalTo(1);
        make.height.mas_equalTo(40);
    }];
    
    UIView *right = [[UIView alloc]init];
    
    right.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(rightTap)];
    [right addGestureRecognizer:tap1];
    
    [midView addSubview:right];
    [right mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(midView);
        make.width.mas_equalTo((kScreenW-32)/2);
    }];
    
    UILabel *rightLabel = [[UILabel alloc]init];
    rightLabel.text = @"商务合作";
    rightLabel.font = [UIFont systemFontOfSize:14];
    [right addSubview:rightLabel];
    [rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(right).with.offset(-25);
        make.centerY.equalTo(right.mas_centerY);
    }];
    
    UIImageView *rightIma = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"合作"]];
    [right addSubview:rightIma];
    [rightIma mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(rightLabel.mas_left).with.offset(-10);
        make.centerY.equalTo(right.mas_centerY);
        make.width.height.mas_equalTo(36);
    }];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.backgroundColor = UIColorWhite;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView addShadow];
    [_tableView registerNib:[UINib nibWithNibName:@"MineTableViewCell" bundle:nil] forCellReuseIdentifier:@"MineTableViewCell"];
    [self.view addSubview:self.tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(16);
        make.right.equalTo(self.view).with.offset(-16);
        make.top.equalTo(midView.mas_bottom).with.offset(10);
        make.height.mas_equalTo(AutoHeight(55)*4);
    }];
}

- (void)loginClick{
    LoginViewController *vc = [[LoginViewController alloc]init];
    [self presentViewController:vc animated:YES completion:nil];
}
#pragma mark QQ咨询
- (void)leftTap{
    
    UserInfoModel *info = [Utils GetUserInfo];
    if (kStringIsEmpty(info.phone)) {
        LoginViewController *vc = [[LoginViewController alloc]init];
        [self presentViewController:vc animated:YES completion:nil];
        return;
    }[HMHttpTool GET:[Base_URL stringByAppendingString:@"/news/contactus"] params:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSString *status = [NSString stringWithFormat:@"%@", responseObject[@"status"]];
        if ([status isEqualToString:@"200"]) {
            NSDictionary *dic = responseObject[@"data"];
            CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:[NSString stringWithFormat:@"QQ服务号%@已复制成功，打开QQ立享一对一贴心服务",dic[@"QQ"]] Rirht:@"打开QQ" CancelBlock:^{
                
            } ConfirmBlock:^{
                UIPasteboard*pasteboard = [UIPasteboard generalPasteboard];
                pasteboard.string = dic[@"QQ"];
                if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqq://"]]) {
                    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectZero];
                    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"mqq://im/chat?chat_type=wpa&uin=%@&version=1&src_type=web",dic[@"QQ"]]];
                    
                    NSURLRequest *request = [NSURLRequest requestWithURL:url];
                    webView.delegate = self;
                    [webView loadRequest:request];
                    [self.view addSubview:webView];
                }else{
                    [SVProgressHUD showInfoWithStatus:@"您未安装QQ"];
                }
            }];
            [alert show];
            
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
    }];
}
//商务合作
- (void)rightTap{
    BusinessViewController *vc = [[BusinessViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return AutoHeight(55);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *array = @[@"问题百宝箱",@"我要反馈",@"删除缓存",@"关于我们"];
    MineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineTableViewCell" forIndexPath:indexPath];
    cell.titleLabel.text = array[indexPath.row];
    cell.headImage.image = [UIImage imageNamed:array[indexPath.row]];
    if (indexPath.row == 2) {
        cell.rightIma.hidden = YES;
        UILabel *label = [[UILabel alloc]init];
        label.textColor = [UIColor colorWithHexString:@"#6C6C6C"];
        label.font = [UIFont systemFontOfSize:14];
        label.text = @"0MB";
        [cell.contentView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(cell.contentView).with.offset(-16);
            make.centerY.equalTo(cell.contentView.mas_centerY);
        }];
    }
   
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        QuestionViewController *vc = [[QuestionViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }if (indexPath.row == 1) {
        FeedViewController *vc = [[FeedViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }if (indexPath.row == 3) {
        AboutViewController *vc = [[AboutViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
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
