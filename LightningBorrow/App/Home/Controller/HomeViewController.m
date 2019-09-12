//
//  HomeViewController.m
//  LightningBorrow
//
//  Created by Qingyang Xu on 2018/12/25.
//  Copyright © 2018年 光磊信息. All rights reserved.
//

#import "HomeViewController.h"
#import "LoanViewController.h"
#import "PXWebViewController.h"
#import "SDCycleScrollView.h"
#import "SpeedView.h"
#import "CCPScrollView.h"
#import "ProductModel.h"
#import "BestView.h"
#import "PrductTableViewCell.h"
#import "LoginViewController.h"
#import "EmptyTableViewCell.h"
#import "HomeTableViewCell.h"
#import "AppDelegate.h"
#import "PXNaviViewController.h"
#import "CustomAlertView.h"
#import "CustomView.h"

@interface HomeViewController ()<UINavigationControllerDelegate,SDCycleScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UITableView *tableView;
@property (strong, nonatomic) CCPScrollView  *descLabel;
@property (nonatomic, weak)   SDCycleScrollView *cycleScrollView;
@property (nonatomic, strong) NSMutableArray * imageArray;
@property (nonatomic, strong) NSMutableArray *pidArray;
@property (nonatomic, strong) NSMutableArray *todaysArray;
@property (nonatomic, strong) NSMutableArray *productArray;
@property (nonatomic, strong) NSMutableArray *bestArray;
@property (nonatomic, strong) NSMutableArray *speedArray;
@property (nonatomic, strong) NSMutableArray *idArray;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) UIButton *btn;
@property (nonatomic, strong) UIView *bestView;
@property (nonatomic, strong) UIView *speedView;
@property (nonatomic, strong) UIView *scrollView;

@property (nonatomic, assign)BOOL isCanUseSideBack;

@end

@implementation HomeViewController

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self cancelSideBack];
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self startSideBack];
}

/**
 * 关闭ios右滑返回
 */
- (void)cancelSideBack{
    self.isCanUseSideBack = NO;
    
    if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
    }
}


/*
 开启ios右滑返回
 */
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
    for (NSString *fontfamilyname in [UIFont familyNames])
    {
        NSLog(@"family:'%@'",fontfamilyname);
        for(NSString *fontName in [UIFont fontNamesForFamilyName:fontfamilyname])
        {
            NSLog(@"\tfont:'%@'",fontName);
        }
        NSLog(@"-------------");
    }
    
    self.navigationController.delegate = self;
    self.page = 1;
    if (@available(iOS 11.0, *)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self creatTableView];
    [self creatTopView];
    [self creatFootView];
    [self getBoutiqueData];
    [self getSlideshowData];
    [self getBestData];
    [self getSpeedData];
    [self getVersionData];
    [self getRecommendData:[NSString stringWithFormat:@"%ld", (long)self.page]];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self getBoutiqueData];
        [self getSlideshowData];
        [self getBestData];
        [self getSpeedData];
        [self getRecommendData:[NSString stringWithFormat:@"%ld", (long)self.page]];

    }];
}
#pragma mark 创建tableview及头部尾部 
- (void)creatTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, -KHeight_StatusBar, kScreenW, kScreenH-KHeight_TabBar+KHeight_StatusBar) style:UITableViewStylePlain];
    _tableView.backgroundColor = UIColorWhite;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerNib:[UINib nibWithNibName:@"PrductTableViewCell" bundle:nil] forCellReuseIdentifier:@"PrductTableViewCell"];
    [_tableView registerNib:[UINib nibWithNibName:@"HomeTableViewCell" bundle:nil] forCellReuseIdentifier:@"HomeTableViewCell"];
    [self.view addSubview:self.tableView];
}
- (void)creatTopView{
    _topView = [[UIView alloc]init];
    _topView.frame = CGRectMake(0, -KHeight_StatusBar, kScreenW, AutoHeight(253));
    
    UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg"]];
    image.frame = CGRectMake(0, 0, kScreenW, AutoHeight(156));
    [_topView addSubview:image];
    
    UIImageView *icon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"闪现贷icon"]];
    [_topView addSubview:icon];
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.topView).with.offset(16);
        make.top.equalTo(self.topView).with.offset(AutoHeight(35));
        make.width.mas_equalTo(86);
        make.height.mas_equalTo(22);
    }];
    
    self.tableView.tableHeaderView = self.topView;
}
- (void)creatFootView{
    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 70)];
    footView.backgroundColor = UIColorWhite;
    
    _btn = [[UIButton alloc]initWithFrame:CGRectMake(16, 10, kScreenW-32, 50)];
     [_btn setTitle:@"点击加载更多" forState:UIControlStateNormal];
    
    [_btn setTitleColor:UIColorBlack forState:UIControlStateNormal];
    _btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_btn addShadow];
    _btn.backgroundColor = UIColorWhite;
    [footView addSubview:_btn];
    
    [_btn addTarget:self action:@selector(loadMore) forControlEvents:UIControlEventTouchUpInside];
    self.tableView.tableFooterView = footView;
}
#pragma mark 推荐
- (void)creatRecommend{
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(16, AutoHeight(66), kScreenW-32, AutoHeight(175))];
    view.backgroundColor = UIColorWhite;
    view.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(recmTap:)];
    [view addGestureRecognizer:tap];
    [view addShadow];
    
    UIImageView *tipIma = [[UIImageView alloc]init];
    tipIma.image = [UIImage imageNamed:@"精品推荐"];
    [view addSubview:tipIma];
    [tipIma mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view);
        make.top.equalTo(view).with.offset(AutoHeight(6));
    }];
    
    if (!kArrayIsEmpty(self.todaysArray)) {
        ProductModel *model = self.todaysArray[0];
        UIImageView *image = [[UIImageView alloc]init];
        [image sd_setImageWithURL:[NSURL URLWithString:model.upload]];
        image.layer.cornerRadius = AutoHeight(26)/2;
        image.layer.masksToBounds = YES;
        
        [view addSubview:image];
        [image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view).with.offset(22);
            make.top.equalTo(tipIma.mas_bottom).with.offset(AutoHeight(8));
            make.width.height.mas_equalTo(AutoHeight(26));
        }];
        
        UILabel *moneyLabel = [[UILabel alloc]init];
        moneyLabel.font = [UIFont fontWithName:@"DINCondensed-Bold" size:31];
        moneyLabel.textColor = kAppNavColor;
        moneyLabel.text = model.amount;
        moneyLabel.textAlignment = 2;
        [view addSubview:moneyLabel];
        [moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(view).with.offset(-25);
            make.centerY.equalTo(image.mas_centerY).with.offset(5);
            make.height.mas_equalTo(36);
        }];
        
        UILabel *name = [[UILabel alloc]init];
        name.text = model.loaname;
        name.font = [UIFont systemFontOfSize:18 weight:UIFontWeightSemibold];
        [view addSubview:name];
        [name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(image.mas_right).with.offset(6);
            make.centerY.equalTo(image.mas_centerY);
            make.right.equalTo(moneyLabel.mas_left).with.offset(1);
        }];
        
        UILabel *tipMLabel = [[UILabel alloc]init];
        tipMLabel.text = @"最高可借(元)";
        tipMLabel.textAlignment = 2;
        tipMLabel.font = [UIFont systemFontOfSize:12];
        [view addSubview:tipMLabel];
        [tipMLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(image.mas_bottom).with.offset(AutoHeight(5));
            make.right.equalTo(moneyLabel.mas_right);
            make.width.mas_equalTo(80);
        }];
        
        UILabel *subLabel = [[UILabel alloc]init];
        if (kStringIsEmpty(model.desci)) {
            subLabel.text = @"审核快";
        }else{
            subLabel.text = model.desci;
        }
        
        subLabel.font = [UIFont systemFontOfSize:14];
        subLabel.textColor = [UIColor colorWithHexString:@"#6C6C6C"];
        [view addSubview:subLabel];
        [subLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(image);
            make.top.equalTo(image.mas_bottom).with.offset(AutoHeight(5));
            make.right.equalTo(tipMLabel.mas_left);
        }];
        
        UILabel *takeMoney = [[UILabel alloc]init];
        takeMoney.textColor = UIColorWhite;
        takeMoney.text = @"一键拿钱";
        takeMoney.font = [UIFont systemFontOfSize:14];
        takeMoney.textAlignment = 1;
        takeMoney.backgroundColor = [UIColor colorWithHexString:@"#096DD9"];
        [view addSubview:takeMoney];
        [takeMoney mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(image);
            make.right.equalTo(moneyLabel);
            make.top.equalTo(subLabel.mas_bottom).with.offset(AutoHeight(12));
            make.height.mas_equalTo(AutoHeight(35));
        }];
    }
    UIView *topView = [[UIView alloc]init];
    topView.backgroundColor = [UIColor colorWithHexString:@"#F5F9FF"];
    [view addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(view);
        make.height.mas_equalTo(AutoHeight(35));
    }];
    
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
        make.top.equalTo(topView).with.offset(AutoHeight(10));
    }];
    
    [self.topView addSubview:view];
}
- (void)recmTap:(UITapGestureRecognizer *)tap{
    UserInfoModel *info = [Utils GetUserInfo];
    NSMutableDictionary  *parmers = [NSMutableDictionary dictionary];
    ProductModel *model = self.todaysArray[0];
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
#pragma mark 轮播
- (void)addCycleScrollView{
    _scrollView = [[UIView alloc]init];
    
    NSMutableArray  *groupArray = [NSMutableArray array];
    [_cycleScrollView removeFromSuperview];
    
    groupArray = self.imageArray;
    if (kArrayIsEmpty(self.imageArray)) {
        _scrollView.frame = CGRectMake(0, 0, kScreenW, 0);
    }else{
        _scrollView.frame = CGRectMake(0, 0, kScreenW, AutoHeight(90));
    }
    self.cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero imageURLStringsGroup:groupArray];
    if (kArrayIsEmpty(groupArray)) {
        self.cycleScrollView.frame = CGRectMake(16,0, kScreenW-32, AutoHeight(0));
    }else{
        self.cycleScrollView.frame = CGRectMake(16,0, kScreenW-32, AutoHeight(90));
    }
    
    self.cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolStyleAnimated;
    
    self.cycleScrollView.pageControlDotSize = CGSizeMake(0.2, 0.2);
    
    self.cycleScrollView.backgroundColor = [UIColor clearColor];
    self.cycleScrollView.pageControlDotSize = CGSizeMake(12, 3);
    _cycleScrollView.autoScrollTimeInterval = 3;
    _cycleScrollView.delegate = self;
    _cycleScrollView.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _cycleScrollView.autoScroll = YES;
    [self.scrollView addSubview:_cycleScrollView];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}
#pragma mark 最新口子
- (void)creatBestView{
    _bestView = [[UIView alloc]init];
    if (kArrayIsEmpty(self.bestArray)) {
        _bestView.frame = CGRectMake(0, 0, kScreenW, 0);
    }else{
        _bestView.frame = CGRectMake(0, 0, kScreenW, 165);
    }
   
    UILabel *label = [[UILabel alloc]init];
    label.text = @"最新口子";
    label.font = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
    
    [self.bestView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bestView).with.offset(26);
        make.top.equalTo(self.bestView).with.offset(15);
    }];
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = [UIColor colorWithHexString:@"#096DD9"];
    [self.bestView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bestView).with.offset(16);
        make.centerY.equalTo(label.mas_centerY);
        make.width.mas_equalTo(4);
        make.height.mas_equalTo(18);
    }];
    
    if (!kArrayIsEmpty(self.bestArray)) {
        NSInteger count = (self.bestArray.count>3?3:self.bestArray.count);
        CGFloat space;
        if (count == 1) {
            space = 110;
        }else{
            space = (kScreenW-32-8*(count-1))/count;
        }
       
        for (NSInteger i = 0; i<count; i++) {
            ProductModel *model = self.bestArray[i];
            BestView *bestView = [[BestView alloc]initWithFrame:CGRectMake(16+(space+8)*i, 40, space, 120)];
            bestView.productLabel.text = model.loaname;
            bestView.moneyLabel.text = model.amount;
            [bestView.productView sd_setImageWithURL:[NSURL URLWithString:model.upload]];
            bestView.userInteractionEnabled = YES;
            bestView.tag = 100+i;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bestPush:)];
            [bestView addGestureRecognizer:tap];
            [self.bestView addSubview:bestView];
        }
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}
- (void)bestPush:(UITapGestureRecognizer *)tap{
    BestView *view = (BestView *)tap.view;
    UserInfoModel *info = [Utils GetUserInfo];
    NSMutableDictionary  *parmers = [NSMutableDictionary dictionary];
    ProductModel *model = self.bestArray[view.tag-100];
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
- (void)performBlock:(void(^)(void))block afterDelay:(NSTimeInterval)delay {
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), block);
}
#pragma mark 极速下款
- (void)creatSpeedView{
    _speedView = [[UIView alloc]init];
    if (kArrayIsEmpty(self.speedArray)) {
        _speedView.frame = CGRectMake(0, 0, kScreenW, 0);
    }else{
        NSInteger count = (self.speedArray.count>4?4:self.speedArray.count);
        if (count<=2) {
            _speedView.frame = CGRectMake(0, 0, kScreenW, 160);
        }else{
            _speedView.frame = CGRectMake(0, 0, kScreenW, 290);
        }
    }
    UILabel *label = [[UILabel alloc]init];
    label.text = @"极速下款";
    label.font = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
    
    [self.speedView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.speedView).with.offset(26);
        make.top.equalTo(self.speedView).with.offset(15);
    }];
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = [UIColor colorWithHexString:@"#096DD9"];
    [self.speedView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.speedView).with.offset(16);
        make.centerY.equalTo(label.mas_centerY);
        make.width.mas_equalTo(4);
        make.height.mas_equalTo(18);
    }];
    if (!kArrayIsEmpty(self.speedArray)) {
        NSInteger count = (self.speedArray.count>4?4:self.speedArray.count);
        CGFloat space = (kScreenW-32-8)/2;
        ProductModel *mode;
        if (count<=2) {
            for (NSInteger i = 0; i<count; i++) {
                SpeedView *speedView = [[SpeedView alloc]init];
                mode = self.speedArray[i];
                speedView.tag = 200+i;
                speedView.frame = CGRectMake(16+(space+8)*i, 40, space, 120);
                [speedView.productView sd_setImageWithURL:[NSURL URLWithString:mode.upload]];
                speedView.productLabel.text = mode.loaname;
                speedView.moneyLabel.text = mode.amount;
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(speedTap:)];
                [speedView addGestureRecognizer:tap];
                [self.speedView addSubview:speedView];
            }
        }else{
            if (count == 3) {
                for (NSInteger i = 0; i<2; i++) {
                    for (NSInteger j = 0; j<2; j++) {
                        SpeedView *speedView = [[SpeedView alloc]init];
                        if (j == 0) {
                            speedView.tag = 200+i;
                            mode = self.speedArray[i];
                            speedView.frame = CGRectMake(16+(space+8)*i, 40+(120+8)*j, space, 120);
                        }else{
                            speedView.tag = 202;
                            mode = self.speedArray[2];
                            speedView.frame = CGRectMake(16, 40+(120+8)*j, space, 120);
                        }
                        [speedView.productView sd_setImageWithURL:[NSURL URLWithString:mode.upload]];
                        speedView.productLabel.text = mode.loaname;
                        speedView.moneyLabel.text = mode.amount;
                        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(speedTap:)];
                        [speedView addGestureRecognizer:tap];
                        [self.speedView addSubview:speedView];
                    }
                }
            }
            if (count == 4) {
                for (NSInteger i = 0; i<2; i++) {
                    for (NSInteger j = 0; j<2; j++) {
                        SpeedView *speedView = [[SpeedView alloc]init];
                        
                        if (j == 0) {
                            speedView.tag = 200+i;
                            mode = self.speedArray[i];
                            speedView.frame = CGRectMake(16+(space+8)*i, 40+(120+8)*j, space, 120);
                        }else{
                            speedView.tag = 202+i;
                            mode = self.speedArray[2+i];
                            speedView.frame = CGRectMake(16+(space+8)*i, 40+(120+8)*j, space, 120);
                        }
                        [speedView.productView sd_setImageWithURL:[NSURL URLWithString:mode.upload]];
                        speedView.productLabel.text = mode.loaname;
                        speedView.moneyLabel.text = mode.amount;
                        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(speedTap:)];
                        [speedView addGestureRecognizer:tap];
                        [self.speedView addSubview:speedView];
                    }
                    
                }
            }
        }
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}
- (void)speedTap:(UITapGestureRecognizer *)tap{
    SpeedView *view = (SpeedView *)tap.view;
    UserInfoModel *info = [Utils GetUserInfo];
    NSMutableDictionary  *parmers = [NSMutableDictionary dictionary];
    ProductModel *model = self.speedArray[view.tag-200];
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
#pragma mark scrollView代理
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    UIPanGestureRecognizer *pan = scrollView.panGestureRecognizer;
    
    CGFloat velocity = [pan velocityInView:scrollView].y;
    
    if (scrollView.contentOffset.y < 78-KHeight_StatusBar) {
        
        [self.navigationController setNavigationBarHidden:YES animated:YES];
        [QMUIConfiguration sharedInstance].statusbarStyleLightInitially = YES;
        
    }else if (scrollView.contentOffset.y > 78-KHeight_StatusBar){
        
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"闪现贷icon"]];
        self.navigationItem.titleView = imageView;
        
        CGFloat alpha = scrollView.contentOffset.y /kNavBarHAbove7 >1.0f ? 1:scrollView.contentOffset.y/kNavBarHAbove7;
        if (alpha >= 1) {
            alpha = 0.99;
        }
    }else if(velocity == 0){
        
        //停止拖拽
    }
}

#pragma mark tableview代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 3) {
        if (kArrayIsEmpty(self.productArray)) {
            return 0.1;
        }else{
            return 42;
        }
    }else{
        return 0.1;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 3) {
        if (kArrayIsEmpty(self.productArray)) {
            return nil;
        }else{
            UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 42)];
            view.backgroundColor = UIColorWhite;
            
            UIView *line = [[UIView alloc]init];
            line.backgroundColor = [UIColor colorWithHexString:@"#096DD9"];
            [view addSubview:line];
            [line mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(view).with.offset(16);
                make.top.equalTo(view).with.offset(16);
                make.width.mas_equalTo(4);
                make.height.mas_equalTo(18);
            }];
            
            UILabel *label = [[UILabel alloc]init];
            label.text = @"热门推荐";
            label.font = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
            
            [view addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(view).with.offset(26);
                make.centerY.equalTo(line.mas_centerY);
            }];
            
            UIView *line1 = [[UIView alloc]init];
            line1.backgroundColor = [UIColor colorWithHexString:@"#EDEDED"];
            [view addSubview:line1];
            [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(view).with.offset(16);
                make.right.equalTo(view).with.offset(-16);
                make.bottom.equalTo(view);
                make.height.mas_equalTo(1);
            }];
            
            return view;
        }
    }else{
        return nil;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 3) {
        if (kArrayIsEmpty(self.productArray)) {
            return 1;
        }else{
            return self.productArray.count;
        }
    }else{
        return 1;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        if (kArrayIsEmpty(self.bestArray)) {
           return 0.1;
        }else{
            return 165;
        }
    }if (indexPath.section == 2) {
        if (kArrayIsEmpty(self.speedArray)) {
            return 0.1;
        }else{
            NSInteger count = (self.speedArray.count>4?4:self.speedArray.count);
            if (count<=2) {
               return 160;
            }else{
               return 290;
            }
        }
    }if (indexPath.section == 0) {
        if (kArrayIsEmpty(self.imageArray)) {
            return 0.1;
        }else{
            return AutoHeight(90);
        }
    }
    else{
        if (kArrayIsEmpty(self.productArray)) {
            return _tableView.height;
        }else{
            return 80;
        }
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 3) {
        if (kArrayIsEmpty(self.productArray)) {
            EmptyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
            if (!cell) {
                cell = [[EmptyTableViewCell alloc]initWithStyle:0 reuseIdentifier:@"cell"];
            }
            [cell.emptyBtn addTarget:self action:@selector(loadData) forControlEvents:UIControlEventTouchUpInside];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else{
            PrductTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PrductTableViewCell" forIndexPath:indexPath];
            ProductModel *model = self.productArray[indexPath.row];
            [cell.productIma sd_setImageWithURL:[NSURL URLWithString:model.upload]];
            cell.productIma.layer.cornerRadius = 13;
            cell.productIma.layer.masksToBounds = YES;
            cell.productLabel.text = model.loaname;
            cell.moneyLabel.text = model.amount;
            cell.moneyLabel.font = [UIFont fontWithName:@"DINCondensed-Bold" size:27];
            cell.subLabel.text = model.desci;
            cell.subLabel.width = AutoWidth(134);
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }if (indexPath.section == 1) {
        HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeTableViewCell" forIndexPath:indexPath];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.contentView addSubview:self.bestView];
        return cell;
    }if (indexPath.section == 2) {
        HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeTableViewCell" forIndexPath:indexPath];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.contentView addSubview:self.speedView];
        return cell;
    }
    else{
        HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeTableViewCell" forIndexPath:indexPath];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.contentView addSubview:self.scrollView];
        return cell;
    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (!kArrayIsEmpty(self.productArray)) {
        UserInfoModel *info = [Utils GetUserInfo];
        NSMutableDictionary  *parmers = [NSMutableDictionary dictionary];
        ProductModel *model = self.productArray[indexPath.row];
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
#pragma mark 数据
- (instancetype)init{
    if (self = [super init]) {
        _imageArray = [NSMutableArray new];
        _pidArray = [NSMutableArray new];
        _todaysArray = [NSMutableArray new];
        _bestArray = [NSMutableArray new];
        _speedArray = [NSMutableArray new];
        _productArray = [NSMutableArray new];
        _idArray = [NSMutableArray new];
    }
    return self;
}
//精品
- (void)getBoutiqueData{
    [self.todaysArray removeAllObjects];
    NSMutableDictionary  *parmers = [NSMutableDictionary dictionary];
    [parmers setObject:@"20" forKey:@"pid"];
    [HMHttpTool GET:[Base_URL stringByAppendingString:ProductList] params:parmers success:^(NSURLSessionDataTask *task, id responseObject) {
        NSString *status = [NSString stringWithFormat:@"%@", responseObject[@"status"]];
        if ([status isEqualToString:@"200"]) {
            
            NSArray *array = responseObject[@"data"];
            for (NSDictionary *dict in array) {
                ProductModel *model = [[ProductModel alloc] init];
                [model setValuesForKeysWithDictionary:dict];
                [self.todaysArray addObject:model];
            }
            [self creatRecommend];
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
    }];
}
//轮播
- (void)getSlideshowData{
    [self.imageArray removeAllObjects];
    NSMutableDictionary  *parmers = [NSMutableDictionary dictionary];
   
    [HMHttpTool GET:[Base_URL stringByAppendingString:@"/slide/index"] params:parmers success:^(NSURLSessionDataTask *task, id responseObject) {
        NSString *status = [NSString stringWithFormat:@"%@", responseObject[@"status"]];
        if ([status isEqualToString:@"200"]) {
            NSArray *array = responseObject[@"data"];
            for (NSDictionary *dict in array) {
                [self.pidArray addObject:dict[@"url"]];
                [self.idArray addObject:dict[@"id"]];
                [self.imageArray addObject:[NSString stringWithFormat:@"http://%@", dict[@"path"]]];
            }
            [self addCycleScrollView];
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
    }];
}
//最新
- (void)getBestData{
    [self.bestArray removeAllObjects];
    NSMutableDictionary  *parmers = [NSMutableDictionary dictionary];
    [parmers setObject:@"18" forKey:@"pid"];
    [HMHttpTool GET:[Base_URL stringByAppendingString:ProductList] params:parmers success:^(NSURLSessionDataTask *task, id responseObject) {
        NSString *status = [NSString stringWithFormat:@"%@", responseObject[@"status"]];
        if ([status isEqualToString:@"200"]) {
            
            NSArray *array = responseObject[@"data"];
            for (NSDictionary *dict in array) {
                ProductModel *model = [[ProductModel alloc] init];
                [model setValuesForKeysWithDictionary:dict];
                [self.bestArray addObject:model];
            }
            [self creatBestView];
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
    }];
}
//极速下款
- (void)getSpeedData{
    [self.speedArray removeAllObjects];
    NSMutableDictionary  *parmers = [NSMutableDictionary dictionary];
    [parmers setObject:@"19" forKey:@"pid"];
    [HMHttpTool GET:[Base_URL stringByAppendingString:ProductList] params:parmers success:^(NSURLSessionDataTask *task, id responseObject) {
        NSString *status = [NSString stringWithFormat:@"%@", responseObject[@"status"]];
        if ([status isEqualToString:@"200"]) {
            
            NSArray *array = responseObject[@"data"];
            for (NSDictionary *dict in array) {
                ProductModel *model = [[ProductModel alloc] init];
                [model setValuesForKeysWithDictionary:dict];
                [self.speedArray addObject:model];
            }
            
            [self creatSpeedView];
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
    }];
}
//推荐
- (void)loadData{
    self.page = 1;
    [self getRecommendData:[NSString stringWithFormat:@"%ld",(long)self.page]];
}
- (void)getRecommendData:(NSString *)page{
   
    NSMutableDictionary  *parmers = [NSMutableDictionary dictionary];
    [parmers setObject:@"41" forKey:@"pid"];
    [parmers setObject:page forKey:@"page"];
    [HMHttpTool GET:[Base_URL stringByAppendingString:ProductList] params:parmers success:^(NSURLSessionDataTask *task, id responseObject) {
        NSString *status = [NSString stringWithFormat:@"%@", responseObject[@"status"]];
        [self.tableView.mj_header endRefreshing];
        if ([status isEqualToString:@"200"]) {
            if ([page isEqualToString:@"1"]) {
                [self.productArray removeAllObjects];
            }
            
            NSArray *array = responseObject[@"data"];
            
            for (NSDictionary *dict in array) {
                ProductModel *model = [[ProductModel alloc] init];
                [model setValuesForKeysWithDictionary:dict];
                
                [self.productArray addObject:model];
            }
            
            if ( self.productArray.count < 10 ) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
               
                if (kArrayIsEmpty(self.productArray)) {
                    self.tableView.tableFooterView.hidden = YES;
                    self.tableView.tableHeaderView.hidden = YES;
                }
                [self.tableView reloadData];
            });
            
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
    }];
}
- (void)loadMore{
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    delegate.tabVC.selectedIndex = 1;
    delegate.window.rootViewController = delegate.tabVC;
}
//版本
- (void)getVersionData{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:@"ios" forKey:@"from"];
    [dic setObject:@"1" forKey:@"vson"];
    [HMHttpTool post:[NSString stringWithFormat:@"%@%@",Base_URL,@"/share/upmoste"] params:dic success:^(NSDictionary *JSONDic) {
        NSString *status = [NSString stringWithFormat:@"%@", JSONDic[@"status"]];
        NSDictionary *dataDic = JSONDic[@"data"];
        if ([status isEqualToString:@"200"]) {
            NSString *string;
            if (kStringIsEmpty(dataDic[@"content"])) {
                string = @"当前版本需要更新";
            }else{
                string = dataDic[@"content"];
            }
            if ([dataDic[@"auth_key"] isEqualToString:@"1"]) {
                CustomView *alertView = [[CustomView alloc]initWithTitle:string Rirht:@"前往更新" ConfirmBlock:^{
                    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/id1447222299?mt=8"]];
                }];
                [alertView show];
            }else{
                CustomAlertView *alertView = [[CustomAlertView alloc]initWithTitle:string Rirht:@"前往更新" CancelBlock:^{
                    
                } ConfirmBlock:^{
                    
                    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/id1447222299?mt=8"]];
                }];
                [alertView show];
            }
            
        }
    } failure:^(NSError *error) {
        
    }];
}
#pragma mark 各类代理
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index
{
    //NSLog(@"didScrollToIndex----index:%ld",index);
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    if (!kArrayIsEmpty(self.pidArray)) {
        NSString * pidString = self.pidArray[index];
        NSString *idString = self.idArray[index];
        [self clickCycleScrollView:pidString WithID:idString];
    }
}

- (void)clickCycleScrollView:(NSString *)pidString WithID:(NSString *)idstring{
    UserInfoModel *info = [Utils GetUserInfo];
    NSMutableDictionary  *parmers = [NSMutableDictionary dictionary];
    
    if (info.uid) {
        [parmers setObject:idstring forKey:@"pid"];
        [parmers setObject:info.uid forKey:@"uid"];
        [parmers setObject:info.phone forKey:@"mobile"];
        [parmers setObject:QIYEBAOKEY forKey:@"canel"];
       
        [HMHttpTool post:[NSString stringWithFormat:@"%@%@",Base_URL,@"/pro/apption"] params:parmers success:^(NSDictionary *JSONDic) {
            //        NSLog(@"%@", JSONDic);
        } failure:^(NSError *error) {

        }];

        PXWebViewController *vc = [[PXWebViewController alloc] init];
        vc.urlStr = pidString;
        [self.navigationController pushViewController:vc animated:YES];

    } else {
        LoginViewController *vc = [[LoginViewController alloc] init];
        [self presentViewController:vc animated:YES completion:nil];
    }
}
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    if (isShowHomePage == YES) {
        if (self.tableView.contentOffset.y < 78-KHeight_StatusBar) {
            [self.navigationController setNavigationBarHidden:YES animated:YES];
        }else{
            [self.navigationController setNavigationBarHidden:NO animated:YES];
        }
    }else{
        [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
