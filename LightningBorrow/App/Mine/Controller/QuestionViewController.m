//
//  QuestionViewController.m
//  BorrowingMoney
//
//  Created by Qingyang Xu on 2018/8/27.
//  Copyright © 2018年 puxu. All rights reserved.
//

#import "QuestionViewController.h"
#import "ExpandTableViewCell.h"
#import "LsitFrameModel.h"
#import "QuestionModel.h"

@interface QuestionViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic,strong)  NSMutableArray *dataSource;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) NSInteger page;

@end

@implementation QuestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"问题百宝箱";
    self.view.backgroundColor = VCBackgroundColor;
   
    if (@available(iOS 11.0, *)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self createUI];
    self.page = 1;
    [self loadDataWithPage:[NSString stringWithFormat:@"%ld", (long)self.page]];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page = 1;
        [self loadDataWithPage:[NSString stringWithFormat:@"%ld", (long)self.page]];
    }];
  
}
- (void)createUI{
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 10+kNavBarHAbove7, kScreenW, kScreenH-10-kNavBarHAbove7)style:UITableViewStylePlain];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
}

#pragma mark 数据
- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray new];
    }
    return _dataSource;
}
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}
- (void)loadDataWithPage:(NSString *)page{
    NSMutableDictionary *params = [NSMutableDictionary new];
    [params setObject:page forKey:@"page"];
    [HMHttpTool GET:[NSString stringWithFormat:@"%@%@",Base_URL,@"/news/helps"] params:params success:^(NSURLSessionDataTask *task, id responseObject) {
        NSString *status = [NSString stringWithFormat:@"%@", responseObject[@"status"]];
        
        if ([status isEqualToString:@"200"]) {
            [self.tableView.mj_header endRefreshing];
            
            if ([page isEqualToString:@"1"]) {
                [self.dataArray removeAllObjects];
            }
           
            NSArray *list = responseObject[@"data"];
            [self.dataArray addObjectsFromArray:[QuestionModel mj_objectArrayWithKeyValuesArray:list]];
            for (int i=0; i<self.dataArray.count; i++) {
                QuestionModel *model = self.dataArray[i];
                model.isSelected = NO;
                LsitFrameModel *frameModel = [[LsitFrameModel alloc]init];
                frameModel.listModel = model;
                [self.dataSource addObject:frameModel];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }else{
            [self.tableView.mj_header endRefreshing];
            
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        [self.tableView.mj_header endRefreshing];
        
    }];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ID=@"cell";
    ExpandTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell=[[ExpandTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    LsitFrameModel  *frameModel = self.dataSource[indexPath.row];
    if (frameModel.listModel.isSelected) {
        cell.answerLB.hidden = NO;
        cell.line1.hidden    = NO;
        cell.line.hidden = YES;
    }else{
        cell.answerLB.hidden = YES;
        cell.line1.hidden    = YES;
        cell.line.hidden = NO;
    }
    cell.frameModel = frameModel;
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    LsitFrameModel  *frameModel = self.dataSource[indexPath.row];
    if (frameModel.listModel.isSelected) {
        return [self.dataSource[indexPath.row] expandCellHeight];
    }else{
        return [self.dataSource[indexPath.row] unExpandCellHeight];
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LsitFrameModel  *frameModel = self.dataSource[indexPath.row];
    frameModel.listModel.isSelected = !frameModel.listModel.isSelected;
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
