//
//  RelationViewController.m
//  LightningBorrow
//
//  Created by 光磊信息 on 2018/12/14.
//  Copyright © 2018年 光磊信息. All rights reserved.
//

#import "RelationViewController.h"
#import "TrueNameTableViewCell.h"
#import "InputViewController.h"

@interface RelationViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation RelationViewController

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:(UITableViewStyleGrouped)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.scrollEnabled = NO;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerNib:[UINib nibWithNibName:@"TrueNameTableViewCell" bundle:nil] forCellReuseIdentifier:@"trueCell"];
        

    }
    return _tableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"常用联系家属";
    
    self.dataArray = @[@"姓名", @"联系方式", @"关系"];
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
    self.tableView.frame = CGRectMake(0, kIs_iPhoneXSeries(94, 70), kScreenW, kScreenH - kIs_iPhoneXSeries(128, 70));
    [self.view addSubview:_tableView];
    
    UIButton *sureBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [sureBtn setTitle:@"提交" forState:(UIControlStateNormal)];
    [sureBtn setBackgroundColor:[UIColor colorWithHexString:@"#6B8CBB"]];
    sureBtn.titleLabel.font = kSystemMainFont(20, UIFontWeightRegular);
    [self.view addSubview:sureBtn];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(16);
        make.right.equalTo(self.view.mas_right).with.offset(-16);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(kIs_iPhoneXSeries(-AutoHeight(214), -AutoHeight(160)));
        make.height.offset(44);
    }];
    sureBtn.layer.cornerRadius = 22;
    [sureBtn addTarget:self action:@selector(sureAction) forControlEvents:(UIControlEventTouchUpInside)];
}

- (void)sureAction
{
    TrueNameTableViewCell *cell1 = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    TrueNameTableViewCell *cell2 = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    TrueNameTableViewCell *cell3 = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];

    if ([cell1.subLabel.text isEqualToString:@"请输入姓名"] && cell2.subLabel.text.length < 11 && [cell3.subLabel.text isEqualToString:@"请输入与TA的关系"]) {
        [SVProgressHUD showErrorWithStatus:@"请正确输入家属"];
    } else {
        [SVProgressHUD showSuccessWithStatus:@"运营商绑定成功"];
        UserInfoModel *info = [Utils GetUserInfo];
        info.isRelation = @"1";
        [Utils saveUserInfoToUserDefault:info];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 36;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 31)];
    view.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(16, 0, 200, 17)];
    if (section == 0) {
        label.text = @"第一联系人";
    } else {
        label.text = @"第二联系人";
    }
    label.font = kSystemMainFont(12, UIFontWeightRegular);
    label.textColor = [UIColor colorWithHexString:@"#404040"];
    
    [view addSubview:label];
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 31;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TrueNameTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"trueCell" forIndexPath:indexPath];
    
    cell.mainLabel.text = self.dataArray[indexPath.row];
    if (indexPath.row == 2) {
        cell.subLabel.text = [NSString stringWithFormat:@"请输入与TA的%@", self.dataArray[indexPath.row]];
    } else {
        cell.subLabel.text = [NSString stringWithFormat:@"请输入%@", self.dataArray[indexPath.row]];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    TrueNameTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    InputViewController *vc = [[InputViewController alloc] init];
    vc.title = [NSString stringWithFormat:@"输入%@", self.dataArray[indexPath.row]];
    [vc returnText:^(NSString *showText) {//定义B视图后调用block
        cell.subLabel.text = showText;
    }];
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
