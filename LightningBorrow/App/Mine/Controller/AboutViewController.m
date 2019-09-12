//
//  AboutViewController.m
//  NewBorrowingMoney
//
//  Created by Qingyang Xu on 2018/12/24.
//  Copyright © 2018年 puxu. All rights reserved.
//

#import "AboutViewController.h"
#import "AboutModel.h"

@interface AboutViewController ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel     *titleLabel;
@property (nonatomic, strong) UILabel     *contentLabel;
@property (nonatomic, strong) AboutModel  *model;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"关于我们";
    [self creatImageView];
    [self creatTitleLabel];
    [self creatContentLabel];
    [self loadData];
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}
- (AboutModel *)model{
    if (!_model) {
        _model = [[AboutModel alloc]init];
    }
    return _model;
}

- (void)loadData{
    [HMHttpTool GET:[NSString stringWithFormat:@"%@%@",Base_URL,AboutUS] params:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *list = responseObject[@"data"];
        self.dataArray = [AboutModel mj_objectArrayWithKeyValuesArray:list];
        self.model = self.dataArray[0];
        if (kStringIsEmpty(self.model.title)) {
            self.titleLabel.text = @"--";
        }else{
            self.titleLabel.text = self.model.title;
        }
        if (kStringIsEmpty(self.model.content)) {
            self.contentLabel.text = @"--";
        }else{
            self.contentLabel.text = self.model.content;
        }
       
        NSLog(@"%@",self.model);
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

- (void)creatImageView{
    _imageView = [[UIImageView alloc]init];
    _imageView.image = [UIImage imageNamed:@"logo1"];
    [self.view addSubview:_imageView];
    CGFloat width = kScreenW-AutoWidth(140)*2;
    _imageView.layer.cornerRadius = 8;
    _imageView.layer.masksToBounds = YES;
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(AutoHeight(90)+kNavBarHAbove7);
        make.left.equalTo(self.view).with.offset(AutoWidth(140));
        make.right.equalTo(self.view).with.offset(-(AutoWidth(140)));
        make.height.mas_equalTo(@(width));
    }];
}
- (void)creatTitleLabel{
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.numberOfLines = 0;
    _titleLabel.font = [UIFont systemFontOfSize:19];
    [self.view addSubview:_titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(AutoWidth(20));
        make.right.equalTo(self.view).with.offset(-AutoWidth(20));
        make.top.equalTo(self.imageView.mas_bottom).with.offset(AutoHeight(6));
    }];
}

- (void)creatContentLabel{
    _contentLabel = [[UILabel alloc]init];
    _contentLabel.textAlignment = NSTextAlignmentLeft;
    _contentLabel.numberOfLines = 0;
    _contentLabel.font = [UIFont systemFontOfSize:15];
    _contentLabel.textColor = [UIColor colorWithHexString:@"#6C6C6C"];
    [self.view addSubview:_contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(AutoWidth(38));
        make.right.equalTo(self.view).with.offset(-AutoWidth(38));
        make.top.equalTo(self.titleLabel.mas_bottom).with.offset(AutoHeight(8));
    }];
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
