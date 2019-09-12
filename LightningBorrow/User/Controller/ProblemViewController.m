//
//  ProblemViewController.m
//  LightningBorrow
//
//  Created by 光磊信息 on 2018/12/14.
//  Copyright © 2018年 光磊信息. All rights reserved.
//

#import "ProblemViewController.h"
#import "ProblemTableViewCell.h"

@interface ProblemViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSArray *answerArray;

@end

@implementation ProblemViewController

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.scrollEnabled = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerNib:[UINib nibWithNibName:@"ProblemTableViewCell" bundle:nil] forCellReuseIdentifier:@"problemCell"];
        
        
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"常见问题";
    
    self.titleArray = @[@"系统审核时间？", @"申请条件？", @"首付到账时间？", @"如何修改手机号？", @"能否重新绑卡？", @"我的个人资料是否会泄露？ ", @"我的订单没有通过，能否再次申请？", @"如果我逾期了怎么办？"];
    self.answerArray = @[@"一般在5-15分钟，实际以您界面显示时间为准", @"年龄在18-35周岁，具有完全民事能力即可", @"2小时内，实际以银行卡到账时间为准", @"目前不支持修改手机号", @"可以，在银行卡认证页面，点击更换银行卡", @"您的个人资料，我们会严格保密", @"30天后可重新申请", @"请尽快处理，我们会追究逾期人员，会有专门人员对其进行 追踪，影响其个人信用"];
    
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
    self.tableView.frame = CGRectMake(0, kIs_iPhoneXSeries(79, 55), kScreenW, kScreenH - kIs_iPhoneXSeries(113, 55));
    [self.view addSubview:_tableView];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titleArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProblemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"problemCell" forIndexPath:indexPath];
    cell.titleLabel.text = self.titleArray[indexPath.row];
    cell.answerLabel.text = self.answerArray[indexPath.row];
    
    if (indexPath.row == 7) {
        cell.lineView.hidden = YES;
    }
    
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
