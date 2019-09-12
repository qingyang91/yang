//
//  FeedViewController.m
//  LightningBorrow
//
//  Created by Qingyang Xu on 2018/12/26.
//  Copyright © 2018年 光磊信息. All rights reserved.
//

#import "FeedViewController.h"
#import "LoginViewController.h"

@interface FeedViewController ()<UITextViewDelegate>
{
    UIButton *selectBtn;
}
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, retain) UILabel *placeHolderLabel;
@property (nonatomic, retain) UILabel *textLimit;
@property (nonatomic, retain) UIButton *button;

@end

@implementation FeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我要反馈";
    self.view.backgroundColor = UIColorWhite;
    
    [self creatTextView];
}

- (void)creatTextView{
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideAllKeyBoards)];
    [self.view addGestureRecognizer:tap1];
    
    UILabel *label = [[UILabel alloc]init];
    label.text = @"意见或建议";
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = [UIColor colorWithHexString:@"#222222"];
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(16);
        make.top.equalTo(self.view).with.offset(20+kNavBarHAbove7);
    }];
    
    UIView *backView = [[UIView alloc]init];
    backView.backgroundColor = [UIColor colorWithHexString:@"#F7F7F7"];
    [self.view addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(16);
        make.right.equalTo(self.view).with.offset(-16);
        make.top.equalTo(label.mas_bottom).with.offset(10);
        make.height.mas_equalTo(AutoHeight(180));
    }];
    
    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(10, 10,kScreenW - 52, AutoHeight(180)-42)];
    self.textView.delegate = self;
    self.textView.backgroundColor = [UIColor colorWithHexString:@"#F7F7F7"];
    self.textView.font = [UIFont systemFontOfSize:14];
    self.textView.textColor = UIColorBlack;
    self.textView.returnKeyType = UIReturnKeyDone;
    [backView addSubview:self.textView];
    
    _placeHolderLabel = [[UILabel alloc] init];
    _placeHolderLabel.font = [UIFont systemFontOfSize:10];
    _placeHolderLabel.textColor = [UIColor colorWithHexString:@"#BFBFBF"];
    _placeHolderLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _placeHolderLabel.text = @"请输入您要咨询的问题，24小时内我们会给您进行回复!";
    _placeHolderLabel.numberOfLines = 0;
    [self.textView addSubview:self.placeHolderLabel];
    
    [_placeHolderLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.right.top.mas_equalTo(@0);
    }];
    
    _textLimit = [[UILabel alloc] init];
    _textLimit.font = [UIFont systemFontOfSize:14];
    _textLimit.textColor = [UIColor colorWithHexString:@"#919191"];
    _textLimit.translatesAutoresizingMaskIntoConstraints = NO;
    _textLimit.text = @"0/200";
    [backView addSubview:_textLimit];
    
    [_textLimit mas_makeConstraints:^(MASConstraintMaker *make){
        make.right.equalTo(backView).with.offset(-6);
        make.bottom.equalTo(backView).offset(-14);
    }];
    
    _button = [[UIButton alloc]init];
    [_button setTitle:@"提交" forState:UIControlStateNormal];
    [_button setTitleColor:UIColorBlack forState:UIControlStateNormal];
    _button.backgroundColor = [UIColor colorWithHexString:@"#E5E5E5"];
    _button.layer.cornerRadius = 22;
    _button.layer.masksToBounds = YES;
    [_button addTarget:self action:@selector(confirmClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_button];
    
    [_button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(16);
        make.right.equalTo(self.view).with.offset(-16);
        make.top.equalTo(backView.mas_bottom).with.offset(AutoHeight(190));
        make.height.mas_equalTo(44);
    }];
    
    UILabel *label1 = [[UILabel alloc]init];
    label1.text = @"请选择问题类型";
    label1.font = [UIFont systemFontOfSize:15];
    label1.textColor = [UIColor colorWithHexString:@"#222222"];
    [self.view addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(16);
        make.top.equalTo(backView.mas_bottom).with.offset(15);
    }];
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = UIColorWhite;
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(label1.mas_bottom).with.offset(11);
        make.height.mas_equalTo(AutoHeight(85));
    }];
    CGFloat space = (kScreenW-32-300)/2;
    NSArray *array = @[@"页面展示",@"实名认证",@"联系人",@"运营商",@"芝麻分",@"银行卡"];
    for (NSInteger i = 0; i<3; i++) {
        for (NSInteger j =0 ; j<2; j++) {
            UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(16+(100+space)*i, (30+AutoHeight(25))*j, 100, 30)];
            if (j == 0) {
                btn.tag = 100+i;
                [btn setTitle:array[i] forState:UIControlStateNormal];
            }if (j == 1) {
                btn.tag = 103+i;
                [btn setTitle:array[i+3] forState:UIControlStateNormal];
            }
            
            [btn setTitleColor:[UIColor colorWithHexString:@"#222222"] forState:UIControlStateNormal];
            btn.backgroundColor = [UIColor colorWithHexString:@"#F7F7F7"];
            if (btn.tag == 100) {
                [btn setTitleColor:UIColorWhite forState:UIControlStateNormal];
                btn.backgroundColor = kAppNavColor;
                selectBtn = btn;
            }else{
                [btn setTitleColor:[UIColor colorWithHexString:@"#222222"] forState:UIControlStateNormal];
                btn.backgroundColor = [UIColor colorWithHexString:@"#F7F7F7"];
            }
            [btn addTarget:self action:@selector(selectClick:) forControlEvents:UIControlEventTouchUpInside];
            btn.titleLabel.font = [UIFont systemFontOfSize:12];
            btn.titleLabel.textAlignment = 1;
            btn.layer.cornerRadius = 15;
            btn.layer.masksToBounds = YES;
            [view addSubview:btn];
        }
    }
}

- (void)selectClick:(UIButton *)btn{
    if (selectBtn) {
        [selectBtn setTitleColor:[UIColor colorWithHexString:@"#222222"] forState:UIControlStateNormal];
        selectBtn.backgroundColor = [UIColor colorWithHexString:@"#F7F7F7"];
    }
    selectBtn = btn;
    [selectBtn setTitleColor:UIColorWhite forState:UIControlStateNormal];
    selectBtn.backgroundColor = kAppNavColor;
}

- (void)performBlock:(void(^)(void))block afterDelay:(NSTimeInterval)delay {
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), block);
}
- (void)confirmClick{
    UserInfoModel *info = [Utils GetUserInfo];
    if (kStringIsEmpty(info.phone)) {
        LoginViewController *vc = [[LoginViewController alloc]init];
        [self presentViewController:vc animated:YES completion:nil];
    }else{
        if (kStringIsEmpty(self.textView.text)) {
            [SVProgressHUD showInfoWithStatus:@"请输入您的宝贵意见"];
            return;
        }
        else{
            [SVProgressHUD showInfoWithStatus:@"反馈成功"];
            [_textView resignFirstResponder];
            [self performBlock:^{
                [self.navigationController popViewControllerAnimated:YES];
            } afterDelay:1.0];
        }
    }
}

#pragma mark UITextViewDelegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    _placeHolderLabel.hidden = YES;
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView{
    if ([self.textView.text length] > 200) {
        [SVProgressHUD showInfoWithStatus:@"不能超过200个字"];
        self.textView.text = [self.textView.text substringToIndex:200];
        self.textLimit.text = @"200/200";
        return;
    }
    if ([self isBlankString:textView.textInputMode.primaryLanguage]) {
        return;
    }
    NSInteger a = [textView.text length];
    NSString *str = [NSString stringWithFormat:@"%ld/200",(long)a];
    self.textLimit.text = str;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([self isBlankString:textView.textInputMode.primaryLanguage]) {
        return NO;
    };if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView{
    if ([textView.text isEqualToString:@""]) {
        _placeHolderLabel.hidden = NO;
    }
    return YES;
}

- (BOOL) isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}
- (void) hideAllKeyBoards{
    [_textView resignFirstResponder];
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
