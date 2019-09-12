//
//  OperatorViewController.m
//  LightningBorrow
//
//  Created by 光磊信息 on 2018/12/14.
//  Copyright © 2018年 光磊信息. All rights reserved.
//

#import "OperatorViewController.h"
#import "UserTableViewCell.h"

@interface OperatorViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *titleArray;
@property (nonatomic, strong) NSIndexPath *selectIndexPath;

@end

@implementation OperatorViewController

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


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"运营商信息";
    
    _titleArray = [NSMutableArray arrayWithObjects:@"移动",@"联通",@"电信", nil];
    [self initUI];
    
    if (@available(iOS 11.0, *)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

- (void)initUI
{
    self.tableView.frame = CGRectMake(0, kIs_iPhoneXSeries(84, 60), kScreenW, kScreenH - kIs_iPhoneXSeries(118, 60));
    [self.view addSubview:_tableView];
    
    UIButton *sureBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [sureBtn setTitle:@"提交" forState:(UIControlStateNormal)];
    [sureBtn setBackgroundColor:[UIColor colorWithHexString:@"#6B8CBB"]];
    sureBtn.titleLabel.font = kSystemMainFont(20, UIFontWeightRegular);
    [self.view addSubview:sureBtn];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(16);
        make.right.equalTo(self.view.mas_right).with.offset(-16);
        make.top.equalTo(self.view).with.offset(AutoHeight(248));
        make.height.offset(44);
    }];
    sureBtn.layer.cornerRadius = 22;
    [sureBtn addTarget:self action:@selector(sureAction) forControlEvents:(UIControlEventTouchUpInside)];
}

- (void)sureAction
{
    [SVProgressHUD showSuccessWithStatus:@"运营商绑定成功"];
    UserInfoModel *info = [Utils GetUserInfo];
    info.isOperator = @"1";
    [Utils saveUserInfoToUserDefault:info];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 42;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"userCell" forIndexPath:indexPath];
    cell.imgView.image = [UIImage imageNamed:self.titleArray[indexPath.row]];
    cell.nameLabel.text = self.titleArray[indexPath.row];
    
    if (self.selectIndexPath) {
        if (self.selectIndexPath == indexPath) {
            cell.rightImg.image = [UIImage imageNamed:@"完成 copy 2"];
        } else {
            cell.rightImg.image = [UIImage imageNamed:@"完成 copy 3"];
        }
    } else {
        if (indexPath.row == 0) {
            cell.rightImg.image = [UIImage imageNamed:@"完成 copy 2"];
        } else {
            cell.rightImg.image = [UIImage imageNamed:@"完成 copy 3"];
        }
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectIndexPath = indexPath;
    [self.tableView reloadData];
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
