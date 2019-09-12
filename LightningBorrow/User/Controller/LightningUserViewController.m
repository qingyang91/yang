//
//  LightningUserViewController.m
//  LightningBorrow
//
//  Created by 光磊信息 on 2018/12/12.
//  Copyright © 2018年 光磊信息. All rights reserved.
//

#import "LightningUserViewController.h"
#import "NYWaterWaveView.h"
#import "UserTableViewCell.h"
#import "MydataViewController.h"
#import "AnswerViewController.h"
#import "ProblemViewController.h"
#import "MyBillViewController.h"
#import "AboutUsViewController.h"

@interface LightningUserViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NYWaterWaveView *waterView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *titleArray;
@property (nonatomic, strong) UILabel *phoneLabel;
@property (nonatomic, strong) UIButton *btn;

@end

@implementation LightningUserViewController

- (NYWaterWaveView *)waterView
{
    if (!_waterView) {
        _waterView = [[NYWaterWaveView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 207)];
        
    }
    return _waterView;
}

- (NSMutableArray *)titleArray{
    if (!_titleArray) {
        _titleArray = [NSMutableArray new];
    }
    return _titleArray;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.scrollEnabled = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerNib:[UINib nibWithNibName:@"UserTableViewCell" bundle:nil] forCellReuseIdentifier:@"userCell"];
    }
    return _tableView;
}

- (void)loadData{
    
    _titleArray = [NSMutableArray arrayWithObjects:@"我的资料",@"我的账单",@"常见问题",@"我要反馈", @"关于我们", nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    UserInfoModel *info = [Utils GetUserInfo];
    
    if (kStringIsEmpty(info.phone)) {
        _phoneLabel.text = @"未登录";
    } else {
        _phoneLabel.text = [NSString stringWithFormat:@"%@****%@",[info.phone substringToIndex:3],[info.phone substringFromIndex:7]];
    }

    if ([info.isTrueName isEqualToString:@"1"]) {
        [_btn setTitle:@"已认证" forState:(UIControlStateNormal)];
    } else {
        [_btn setTitle:@"未认证" forState:(UIControlStateNormal)];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"";
    
    [self creatTopView];
    [self loadData];
    
    if (@available(iOS 11.0, *)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

- (void)creatTopView
{
    UIImageView *topImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 207)];
    topImg.image = [UIImage imageNamed:@"Oval 2 Copy 4"];
    [self.view addSubview:topImg];
    
    [topImg addSubview:self.waterView];
    [topImg sendSubviewToBack:self.waterView];
    
    UIImageView *headImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Bitmap"]];
    [self.view addSubview:headImg];
    
    [headImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(topImg);
        make.bottom.equalTo(topImg);
        make.width.offset(83);
        make.height.offset(83);
    }];
    
    self.phoneLabel = [[UILabel alloc] init];
    UserInfoModel *info = [Utils GetUserInfo];
    
    if (kStringIsEmpty(info.phone)) {
        _phoneLabel.text = @"未登录";
    } else {
        _phoneLabel.text = [NSString stringWithFormat:@"%@****%@",[info.phone substringToIndex:3],[info.phone substringFromIndex:7]];
    }
    _phoneLabel.font = kSystemMainFont(20, UIFontWeightRegular);
    _phoneLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_phoneLabel];
    
    [_phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topImg.mas_bottom).with.offset(2);
        make.centerX.equalTo(topImg);
        make.height.offset(28);
    }];
    
    
    self.btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    if ([info.isTrueName isEqualToString:@"1"]) {
        [_btn setTitle:@"已认证" forState:(UIControlStateNormal)];
    } else {
        [_btn setTitle:@"未认证" forState:(UIControlStateNormal)];
    }
    [_btn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    _btn.titleLabel.font = kSystemMainFont(12, UIFontWeightRegular);
    [self.view addSubview:_btn];
    
    [_btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(topImg);
        make.top.equalTo(self.phoneLabel.mas_bottom);
        make.height.offset(18);
        make.width.offset(65);
    }];
    _btn.layer.borderWidth = 1;
    _btn.layer.borderColor = [UIColor blackColor].CGColor;
    _btn.layer.cornerRadius = 9;
    
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(@270);
        make.top.equalTo(self.btn.mas_bottom).with.offset(11);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 54;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"userCell" forIndexPath:indexPath];
    cell.imgView.image = [UIImage imageNamed:self.titleArray[indexPath.row]];
    cell.nameLabel.text = self.titleArray[indexPath.row];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        UserInfoModel *info = [Utils GetUserInfo];
        if (kStringIsEmpty(info.phone)) {
            LightningLoginViewController *vc = [[LightningLoginViewController alloc]init];
            [self presentViewController:vc animated:YES completion:nil];
        } else {
            MydataViewController *vc = [[MydataViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
    } else if (indexPath.row == 1) {
        UserInfoModel *info = [Utils GetUserInfo];
        if (kStringIsEmpty(info.phone)) {
            LightningLoginViewController *vc = [[LightningLoginViewController alloc]init];
            [self presentViewController:vc animated:YES completion:nil];
        } else {
            MyBillViewController *vc = [[MyBillViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
    } else if (indexPath.row == 2) {
        ProblemViewController *vc = [[ProblemViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 3) {
        UserInfoModel *info = [Utils GetUserInfo];
        if (kStringIsEmpty(info.phone)) {
            LightningLoginViewController *vc = [[LightningLoginViewController alloc]init];
            [self presentViewController:vc animated:YES completion:nil];
        } else {
            AnswerViewController *vc = [[AnswerViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
    } else {
        AboutUsViewController *vc = [[AboutUsViewController alloc] init];
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
