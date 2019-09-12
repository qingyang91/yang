//
//  MyBillViewController.m
//  LightningBorrow
//
//  Created by 光磊信息 on 2018/12/17.
//  Copyright © 2018年 光磊信息. All rights reserved.
//

#import "MyBillViewController.h"
#import "SGPageTitleView.h"
#import "SGPageContentView.h"
#import "NoRepaymentViewController.h"
#import "RepaymentViewController.h"
#import "NoLoanViewController.h"

@interface MyBillViewController () <SGPageTitleViewDelegate, SGPageContentViewDelegare>

@property (nonatomic, strong) SGPageTitleView *pageTitleView;
@property (nonatomic, strong) SGPageContentView *pageContentView;

@end

@implementation MyBillViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"我的账单";
    
    [self createPageView];
    if (@available(iOS 11.0, *)) {
        
    } else {
        // Fallback on earlier versions
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

- (void)createPageView
{
    NSMutableArray *controllerArray = [NSMutableArray array];
    
    NoRepaymentViewController *vc1 = [[NoRepaymentViewController alloc] init];
    RepaymentViewController *vc2 = [[RepaymentViewController alloc] init];
    NoLoanViewController *vc3 = [[NoLoanViewController alloc] init];
    [controllerArray addObject:vc1];
    [controllerArray addObject:vc2];
    [controllerArray addObject:vc3];
    
    self.pageContentView = [[SGPageContentView alloc] initWithFrame:CGRectMake(0, kNavBarHAbove7 + 44, kScreenW, kScreenH - kNavBarHAbove7 -44 - KHeight_TabBar + 49) parentVC:self childVCs:controllerArray];
    _pageContentView.delegatePageContentView = self;
    [self.view addSubview:_pageContentView];
    
    NSArray *array = @[@"未还款", @"已还款", @"未放款"];
    self.pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(0, kNavBarHAbove7, self.view.frame.size.width, 44) delegate:self titleNames:array];
    [self.view addSubview:_pageTitleView];
    _pageTitleView.selectedIndex = 0;
    _pageTitleView.isShowBottomSeparator = NO;
    _pageTitleView.titleColorStateNormal = [UIColor colorWithHexString:@"#919191"];
    _pageTitleView.titleColorStateSelected = [UIColor colorWithHexString:@"#6B8CBB"];
    _pageTitleView.indicatorColor = [UIColor clearColor];
    
    _pageTitleView.backgroundColor=[UIColor whiteColor];
    _pageTitleView.indicatorLengthStyle = SGIndicatorLengthTypeEqual;
    
    UIView *lineView1 = [[UIView alloc] init];
    lineView1.backgroundColor = [UIColor colorWithHexString:@"#222222"];
    [_pageTitleView addSubview:lineView1];
    
    [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.pageTitleView).with.offset(kScreenW / 3);
        make.centerY.equalTo(self.pageTitleView);
        make.height.offset(6);
        make.width.offset(1);
    }];
    
    UIView *lineView2 = [[UIView alloc] init];
    lineView2.backgroundColor = [UIColor colorWithHexString:@"#222222"];
    [_pageTitleView addSubview:lineView2];
    
    [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.pageTitleView).with.offset(-kScreenW / 3);
        make.centerY.equalTo(self.pageTitleView);
        make.height.offset(6);
        make.width.offset(1);
    }];
}

- (void)SGPageTitleView:(SGPageTitleView *)SGPageTitleView selectedIndex:(NSInteger)selectedIndex {
    [self.pageContentView setPageCententViewCurrentIndex:selectedIndex];
}

- (void)SGPageContentView:(SGPageContentView *)SGPageContentView progress:(CGFloat)progress originalIndex:(NSInteger)originalIndex targetIndex:(NSInteger)targetIndex {
    [self.pageTitleView setPageTitleViewWithProgress:progress originalIndex:originalIndex targetIndex:targetIndex];
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
