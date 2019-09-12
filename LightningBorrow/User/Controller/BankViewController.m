//
//  BankViewController.m
//  LightningBorrow
//
//  Created by 光磊信息 on 2018/12/14.
//  Copyright © 2018年 光磊信息. All rights reserved.
//

#import "BankViewController.h"
#import "BankTableViewCell.h"
#import "BindBankViewController.h"

@interface BankViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation BankViewController

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.scrollEnabled = NO;
        self.tableView.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerNib:[UINib nibWithNibName:@"BankTableViewCell" bundle:nil] forCellReuseIdentifier:@"bankCell"];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"银行卡绑定";
    
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
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 126;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 88;
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 88)];
    
    UIButton *sureBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [sureBtn setTitle:@"添加银行卡" forState:(UIControlStateNormal)];
    [sureBtn setBackgroundColor:[UIColor colorWithHexString:@"#6B8CBB"]];
    sureBtn.titleLabel.font = kSystemMainFont(20, UIFontWeightRegular);
    [view addSubview:sureBtn];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).with.offset(16);
        make.right.equalTo(view).with.offset(-16);
        make.bottom.equalTo(view);
        make.height.offset(44);
    }];
    sureBtn.layer.cornerRadius = 22;
    [sureBtn addTarget:self action:@selector(sureAction) forControlEvents:(UIControlEventTouchUpInside)];
    [view addSubview:sureBtn];

    return view;
}

- (void)sureAction
{
    BindBankViewController *vc = [[BindBankViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BankTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"bankCell" forIndexPath:indexPath];
    cell.imgView.image = [UIImage imageNamed:@"招商银行"];
    cell.nameLabel.text = @"招商银行";
    cell.typeLabel.text = @"储蓄卡";
    cell.numLabel.text = @"****   ****   ****   8888";
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
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
