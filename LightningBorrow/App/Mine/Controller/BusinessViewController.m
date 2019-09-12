//
//  BusinessViewController.m
//  NewBorrowingMoney
//
//  Created by Qingyang Xu on 2018/12/21.
//  Copyright © 2018年 puxu. All rights reserved.
//

#import "BusinessViewController.h"
#import "LoginViewController.h"
#import "CustomAlertView.h"
#import "AbousModel.h"

@interface BusinessViewController ()

@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation BusinessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"商务合作";
    [self loadData];
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}

- (void)creatUI{
    [self.view addSubview:self.topView];
    AbousModel *model = self.dataArray[0];
    CGFloat height;
    if (kStringIsEmpty(model.wx_id)) {
        height = 130;
    }else{
        height = 195;
    }
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(16);
        make.right.equalTo(self.view).with.offset(-16);
        make.top.equalTo(self.view).with.offset(12+kNavBarHAbove7);
        make.height.mas_equalTo(height);
    }];
    
    [self.view addSubview:self.bottomView];
    AbousModel *model1 = self.dataArray[1];
    CGFloat height1;
    if (kStringIsEmpty(model1.wx_id)) {
        height1 = 130;
    }else{
        height1 = 195;
    }
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(16);
        make.right.equalTo(self.view).with.offset(-16);
        make.top.equalTo(self.topView.mas_bottom).with.offset(10);
        make.height.mas_equalTo(height1);
    }];
}
- (void)loadData{
    [HMHttpTool GET:[Base_URL stringByAppendingString:@"/news/sysmb"] params:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSString *status = [NSString stringWithFormat:@"%@", responseObject[@"status"]];
        if ([status isEqualToString:@"200"]) {
            NSArray *array = responseObject[@"data"];
            for (NSDictionary *dict in array) {
                AbousModel *model = [[AbousModel alloc] init];
                [model setValuesForKeysWithDictionary:dict];
                [self.dataArray addObject:model];
            }
            [self creatUI];
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
    }];
}
- (void)appClick{
    AbousModel *model = self.dataArray[0];
    UserInfoModel *info = [Utils GetUserInfo];
    if (kStringIsEmpty(info.phone)) {
        LoginViewController *vc = [[LoginViewController alloc]init];
        [self presentViewController:vc animated:YES completion:nil];
        return;
    }
   
    CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:[NSString stringWithFormat:@"微信ID：%@已复制成功，打开微信立享一对一贴心服务",model.wx_id] Rirht:@"打开微信" CancelBlock:^{
        
    } ConfirmBlock:^{
        
        UIPasteboard*pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = model.wx_id;
        NSURL * myURL_APP_A = [NSURL URLWithString:@"weixin://"];
        NSURL *muURL = [NSURL URLWithString:@"wechat://"];
        if (![[UIApplication sharedApplication] canOpenURL:myURL_APP_A] || ![[UIApplication sharedApplication] canOpenURL:muURL]) {
            
            [SVProgressHUD showInfoWithStatus:@"请安装微信"];
            return;
        }else{
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"weixin://"]];
        }
    }];
    
    [alert show];
}
- (void)gongzhouClick{
    AbousModel *model = self.dataArray[1];
    UserInfoModel *info = [Utils GetUserInfo];
    if (kStringIsEmpty(info.phone)) {
        LoginViewController *vc = [[LoginViewController alloc]init];
        [self presentViewController:vc animated:YES completion:nil];
        return;
    }
    CustomAlertView *alert = [[CustomAlertView alloc]initWithTitle:[NSString stringWithFormat:@"微信ID：%@已复制成功，打开微信立享一对一贴心服务",model.wx_id] Rirht:@"打开微信" CancelBlock:^{
        
    } ConfirmBlock:^{
        
        UIPasteboard*pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = model.wx_id;
        NSURL * myURL_APP_A = [NSURL URLWithString:@"weixin://"];
        NSURL *muURL = [NSURL URLWithString:@"wechat://"];
        if (![[UIApplication sharedApplication] canOpenURL:myURL_APP_A] || ![[UIApplication sharedApplication] canOpenURL:muURL]) {
            
            [SVProgressHUD showInfoWithStatus:@"请安装微信"];
            return;
        }else{
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"weixin://"]];
        }
    }];
    
    [alert show];
}

- (UIView *)topView{
    if (!_topView) {
        _topView = [[UIView alloc]init];
        _topView.backgroundColor = UIColorWhite;
        [_topView addShadow];
        
        AbousModel *model = self.dataArray[0];
        UILabel *label = [[UILabel alloc]init];
        label.text = model.name;
        label.font = [UIFont systemFontOfSize:18 weight:UIFontWeightMedium];
        
        [_topView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.topView).with.offset(20);
            make.top.equalTo(self.topView).with.offset(18);
        }];
        
        UILabel *detail = [[UILabel alloc]init];
        detail.font = [UIFont systemFontOfSize:14];
        if (!kStringIsEmpty(model.tel)) {
            detail.text = [NSString stringWithFormat:@"联系人：%@\n电话：%@\n邮箱：%@",model.linkman,model.tel,model.email];
        }else{
            detail.text = [NSString stringWithFormat:@"联系人：%@\n邮箱：%@",model.linkman,model.email];
        }
        detail.numberOfLines = 0;
        detail.textAlignment = NSTextAlignmentLeft;
        
        [_topView addSubview:detail];
        [detail mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(label);
            make.top.equalTo(label.mas_bottom).with.offset(12);
        }];
        
        UIView *line = [[UIView alloc]init];
        line.backgroundColor = [UIColor colorWithHexString:@"#EBEBEB"];
        [_topView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.topView);
            make.top.equalTo(self.topView).with.offset(128);
            make.height.mas_equalTo(1);
        }];
        
        UIView *back = [[UIView alloc]init];
        back.backgroundColor = UIColorWhite;
        
        if (kStringIsEmpty(model.wx_id)) {
            back.hidden = YES;
            back.userInteractionEnabled = NO;
        }else{
            back.height = NO;
            back.userInteractionEnabled = YES;
        }
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(appClick)];
        [back addGestureRecognizer:tap];
        
        [_topView addSubview:back];
        [back mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.topView);
            make.top.equalTo(line.mas_bottom);
        }];
        
        UIImageView *image = [[UIImageView alloc]init];
        [image sd_setImageWithURL:[NSURL URLWithString:model.pic]];
        [back addSubview:image];
        [image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(back).with.offset(20);
            make.top.equalTo(back).with.offset(14);
            make.width.height.mas_equalTo(36);
        }];
        
        UILabel *labelID = [[UILabel alloc]init];
        if (!kStringIsEmpty(model.wx_id)) {
            labelID.text = [NSString stringWithFormat:@"微信ID ：%@",model.wx_id];
        }else{
            labelID.text = @"";
        }
        
        labelID.font = [UIFont systemFontOfSize:14];
        
        [back addSubview:labelID];
        [labelID mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(image.mas_right).with.offset(8);
            make.top.equalTo(image);
        }];
        
        UILabel *tipLabel = [[UILabel alloc]init];
        tipLabel.text = model.desc;
        tipLabel.textColor = [UIColor colorWithHexString:@"#979797"];
        tipLabel.font = [UIFont systemFontOfSize:12];
        
        [back addSubview:tipLabel];
        [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(labelID);
            make.bottom.equalTo(image);
        }];
    }
    return _topView;
}
- (UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc]init];
        _bottomView.backgroundColor = UIColorWhite;
        [_bottomView addShadow];
        
        AbousModel *model = self.dataArray[1];
        
        UILabel *label = [[UILabel alloc]init];
        label.text = model.name;
        label.font = [UIFont systemFontOfSize:18 weight:UIFontWeightMedium];
        
        [_bottomView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.bottomView).with.offset(20);
            make.top.equalTo(self.bottomView).with.offset(18);
        }];
        
        UILabel *detail = [[UILabel alloc]init];
        detail.font = [UIFont systemFontOfSize:14];
        if (!kStringIsEmpty(model.tel)) {
            detail.text = [NSString stringWithFormat:@"联系人：%@\n电话：%@\n邮箱：%@",model.linkman,model.tel,model.email];
        }else{
            detail.text = [NSString stringWithFormat:@"联系人：%@\n邮箱：%@",model.linkman,model.email];
        }
        detail.numberOfLines = 0;
        detail.textAlignment = NSTextAlignmentLeft;
        
        [_bottomView addSubview:detail];
        [detail mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(label);
            make.top.equalTo(label.mas_bottom).with.offset(12);
        }];
        
        UIView *line = [[UIView alloc]init];
        line.backgroundColor = [UIColor colorWithHexString:@"#EBEBEB"];
        [_bottomView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.bottomView);
            make.top.equalTo(self.bottomView).with.offset(128);
            make.height.mas_equalTo(1);
        }];
        
        UIView *back = [[UIView alloc]init];
        back.backgroundColor = UIColorWhite;
        
        if (kStringIsEmpty(model.wx_id)) {
            back.hidden = YES;
            back.userInteractionEnabled = NO;
        }else{
            back.hidden = NO;
            back.userInteractionEnabled = YES;
        }
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gongzhouClick)];
        [back addGestureRecognizer:tap];
        
        [_bottomView addSubview:back];
        [back mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.bottomView);
            make.top.equalTo(line.mas_bottom);
        }];
        
        UIImageView *image = [[UIImageView alloc]init];
        [image sd_setImageWithURL:[NSURL URLWithString:model.pic]];
        [back addSubview:image];
        [image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(back).with.offset(20);
            make.top.equalTo(back).with.offset(14);
            make.width.height.mas_equalTo(36);
        }];
        
        UILabel *labelID = [[UILabel alloc]init];
        if (!kStringIsEmpty(model.wx_id)) {
            labelID.text = [NSString stringWithFormat:@"微信ID ：%@",model.wx_id];
        }else{
            labelID.text = @"";
        }
        
        labelID.font = [UIFont systemFontOfSize:14];
        
        [back addSubview:labelID];
        [labelID mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(image.mas_right).with.offset(8);
            make.top.equalTo(image);
        }];
        
        UILabel *tipLabel = [[UILabel alloc]init];
        tipLabel.text = model.desc;
        tipLabel.textColor = [UIColor colorWithHexString:@"#979797"];
        tipLabel.font = [UIFont systemFontOfSize:12];
        
        [back addSubview:tipLabel];
        [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(labelID);
            make.bottom.equalTo(image);
        }];
    }
    return _bottomView;
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
