//
//  LoanViewController.m
//  LightningBorrow
//
//  Created by Qingyang Xu on 2018/12/25.
//  Copyright © 2018年 光磊信息. All rights reserved.
//

#import "LoanViewController.h"
#import "PXWebViewController.h"
#import "LoginViewController.h"
#import "LoanTableViewCell.h"
#import "EmptyTableViewCell.h"
#import "CCPScrollView.h"
#import "ProductModel.h"

@interface LoanViewController ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,UIGestureRecognizerDelegate>

@property (strong, nonatomic) CCPScrollView  *descLabel;
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (strong, nonatomic) UITableView    *tableView;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign)BOOL isCanUseSideBack;

@end

@implementation LoanViewController
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self cancelSideBack];
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self startSideBack];
}


- (void)cancelSideBack{
    self.isCanUseSideBack = NO;
    
    if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
    }
}

- (void)startSideBack {
    self.isCanUseSideBack=YES;
    
    if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
}
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer*)gestureRecognizer {
    return self.isCanUseSideBack;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"贷款超市";
    self.tabBarItem.title = @"贷款";
    [self creatTopView];
    if (@available(iOS 11.0, *)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self.view addSubview:self.tableView];
    self.page = 1;
    [self getRecommendData:[NSString stringWithFormat:@"%ld",(long)self.page]];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page = 1;
        [self getRecommendData:[NSString stringWithFormat:@"%ld", (long)self.page]];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.page++;
        [self getRecommendData:[NSString stringWithFormat:@"%ld", (long)self.page]];
    }];
}

- (void)creatTopView{
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, kNavBarHAbove7, kScreenW, 36)];
    topView.backgroundColor = [UIColor colorWithHexString:@"#FFF2E8"];
    [self.view addSubview:topView];
    
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"fire"]];
    [topView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(topView.mas_centerY);
        make.left.equalTo(topView).with.offset(18);
        make.width.height.mas_equalTo(15);
    }];
    
    [topView addSubview:self.descLabel];
    [_descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topView).with.offset(38);
        make.right.equalTo(topView).with.offset(-20);
        make.top.equalTo(topView).with.offset(10);
    }];
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}
- (void)loadData{
    self.page = 1;
    [self getRecommendData:[NSString stringWithFormat:@"%ld",(long)self.page]];
}
- (void)getRecommendData:(NSString *)page{
    
    NSMutableDictionary  *parmers = [NSMutableDictionary dictionary];
    [parmers setObject:@"42" forKey:@"pid"];
    [parmers setObject:page forKey:@"page"];
    [HMHttpTool GET:[Base_URL stringByAppendingString:ProductList] params:parmers success:^(NSURLSessionDataTask *task, id responseObject) {
        NSString *status = [NSString stringWithFormat:@"%@", responseObject[@"status"]];
        [self.tableView.mj_header endRefreshing];
        if ([status isEqualToString:@"200"]) {
            if ([page isEqualToString:@"1"]) {
                [self.dataArray removeAllObjects];
            }
            NSArray *array = responseObject[@"data"];
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
            for (NSDictionary *dict in array) {
                ProductModel *model = [[ProductModel alloc] init];
                [model setValuesForKeysWithDictionary:dict];
                
                [self.dataArray addObject:model];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }else{
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (kArrayIsEmpty(self.dataArray)) {
        return 1;
    }else{
        return self.dataArray.count;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (kArrayIsEmpty(self.dataArray)) {
        return _tableView.height;
    }else{
        return 124;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (kArrayIsEmpty(self.dataArray)) {
        EmptyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell = [[EmptyTableViewCell alloc]initWithStyle:0 reuseIdentifier:@"cell"];
        }
        [cell.emptyBtn addTarget:self action:@selector(loadData) forControlEvents:UIControlEventTouchUpInside];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        LoanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LoanTableViewCell" forIndexPath:indexPath];
        ProductModel *model = self.dataArray[indexPath.row];
        [cell.productIma sd_setImageWithURL:[NSURL URLWithString:model.upload]];
        cell.productIma.layer.cornerRadius = 18;
        cell.productIma.layer.masksToBounds = YES;
        cell.nameLabel.text = model.loaname;
        cell.subtitleLabel.text = model.desci;
        cell.countLabel.text = model.amount;
        cell.countLabel.font = [UIFont fontWithName:@"DINCondensed-Bold" size:22];
        NSArray *array = [model.loanlimit componentsSeparatedByString:@"/"];
        NSArray *limit = [array[0]componentsSeparatedByString:@","];
        cell.dateLabel.text = [NSString stringWithFormat:@"%@%@",limit[limit.count-1],array[1]];
        cell.rateLabel.text = [model.loanrate componentsSeparatedByString:@"/"][0];
        cell.rateLabel.font = [UIFont fontWithName:@"DINCondensed-Bold" size:19];
        cell.tipRateLaebl.text = [NSString stringWithFormat:@"%@利率",[model.loanrate componentsSeparatedByString:@"/"][1]];
        cell.tipLabel.layer.cornerRadius = 13;
        cell.tipLabel.layer.masksToBounds = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (!kArrayIsEmpty(self.dataArray)) {
        UserInfoModel *info = [Utils GetUserInfo];
        NSMutableDictionary  *parmers = [NSMutableDictionary dictionary];
        ProductModel *model = self.dataArray[indexPath.row];
        
        if (info.uid) {
            [parmers setObject:model.ID forKey:@"pid"];
            [parmers setObject:info.uid forKey:@"uid"];
            [parmers setObject:info.phone forKey:@"mobile"];
            [parmers setObject:QIYEBAOKEY forKey:@"canel"];
            
            [HMHttpTool post:[NSString stringWithFormat:@"%@%@",Base_URL,@"/pro/apption"] params:parmers success:^(NSDictionary *JSONDic) {
                //        NSLog(@"%@", JSONDic);
            } failure:^(NSError *error) {
                
            }];
            
            PXWebViewController *vc = [[PXWebViewController alloc] init];
            vc.urlStr = model.url;
            vc.text = model.loaname;
            [self.navigationController pushViewController:vc animated:YES];
            
        } else {
            LoginViewController *vc = [[LoginViewController alloc] init];
            [self presentViewController:vc animated:YES completion:nil];
        }
    }
}

- (CCPScrollView *)descLabel{
    if(!_descLabel){
        _descLabel = [[CCPScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 60, 16)];
        _descLabel.textAlignment = NSTextAlignmentLeft;
        self.descLabel.titleArray = @[@"建议同时申请3～5款产品，通过率99%"];

        _descLabel.titleFont = 12;
        _descLabel.titleColor = UIColorBlack;
    }
    return _descLabel;
}
- (UITableView *)tableView{
    if (!_tableView) {
         _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavBarHAbove7+46, kScreenW, kScreenH-KHeight_TabBar-kNavBarHAbove7-46) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = VCBackgroundColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerNib:[UINib nibWithNibName:@"LoanTableViewCell" bundle:nil] forCellReuseIdentifier:@"LoanTableViewCell"];
    }
    return _tableView;
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
