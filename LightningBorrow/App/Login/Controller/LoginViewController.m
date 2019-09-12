//
//  LoginViewController.m
//  BorrowingMoney
//
//  Created by Qingyang Xu on 2018/8/24.
//  Copyright © 2018年 puxu. All rights reserved.
//

#import "LoginViewController.h"
#import "PXTabBarViewController.h"
#import "WebViewController.h"
#import "AppDelegate.h"

#define _codeBtn [JKCountDownButton sharedInstance]

@interface LoginViewController ()<UITextFieldDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) UILabel     *titleLabel;
@property (nonatomic, strong) UILabel     *subhLabel;
@property (nonatomic, strong) UITextField *phoneTF;
@property (nonatomic, strong) UITextField *codeTF;
@property (nonatomic, strong) UIButton *loginBtn;
@property (nonatomic, strong) UIButton *close;
@property (nonatomic, strong) UIButton *choose;
@property (nonatomic, copy)   NSString *mesStr;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColorWhite;
    self.navigationController.delegate = self;
    [QMUIConfiguration sharedInstance].statusbarStyleLightInitially = YES;
    [self creatUI];
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];
}

- (void)creatUI{
    
    UIImageView *backIma = [[UIImageView alloc]initWithFrame:self.view.frame];
    backIma.image = [UIImage imageNamed:@"Group 3"];
    [self.view addSubview:backIma];
    
    _close = [[UIButton alloc]init];
    [_close setBackgroundImage:[UIImage imageNamed:@"关闭"] forState:UIControlStateNormal];
    [_close addTarget:self action:@selector(closeClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_close];
    [_close mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(25);
        make.top.equalTo(self.view).with.offset(AutoHeight(35));
        make.width.height.mas_equalTo(24);
    }];
    
    UIImageView *icon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"闪现贷icon"]];
    [self.view addSubview:icon];
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.close);
        make.top.equalTo(self.close.mas_bottom).with.offset(30);
        make.width.mas_equalTo(86);
        make.height.mas_equalTo(22);
    }];
   
    UIButton *btn = [[UIButton alloc]init];
    [btn addTarget:self action:@selector(closeClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(5);
        make.top.equalTo(self.view).with.offset(AutoHeight(5));
        make.width.height.mas_equalTo(110);
    }];
    
    UIView *backView = [[UIView alloc]init];
    backView.backgroundColor = UIColorWhite;
    backView.layer.cornerRadius = 8;
    backView.layer.masksToBounds = YES;
    [self.view addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(16);
        make.right.equalTo(self.view).with.offset(-16);
        make.top.equalTo(icon.mas_bottom).with.offset(12);
        make.height.mas_equalTo(438);
    }];
    
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.text = @"手机快捷登录";
    _titleLabel.textColor = kAppNavColor;
    _titleLabel.font = [UIFont systemFontOfSize:25 weight:UIFontWeightSemibold];
    [backView addSubview:_titleLabel];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView).with.offset(25);
        make.top.equalTo(backView).with.offset(50);
    }];
    
    _subhLabel = [[UILabel alloc]init];
    _subhLabel.text = @"未注册过的手机号将自动创建账号";
    _subhLabel.font = [UIFont systemFontOfSize:13];
    _subhLabel.textColor = kAppNavColor;
    [backView addSubview:_subhLabel];
    
    [_subhLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.top.equalTo(self.titleLabel.mas_bottom).with.offset(3);
    }];
    
    self.phoneTF = [[UITextField alloc] init];
    _phoneTF.borderStyle = UITextBorderStyleNone;
    _phoneTF.placeholder = @"请输入手机号";
    _phoneTF.font = [UIFont systemFontOfSize:15];
    _phoneTF.keyboardType = UIKeyboardTypePhonePad;
    self.phoneTF.delegate = self;
    [_phoneTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:(UIControlEventEditingChanged)];
    [backView addSubview:_phoneTF];
    
    [_phoneTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.subhLabel);
        make.right.equalTo(backView).with.offset(-AutoWidth(94));
        make.height.offset(20);
        make.top.equalTo(self.subhLabel).with.offset(40);
    }];
    
    UIView *lineView1 = [[UIView alloc] init];
    lineView1.backgroundColor = [UIColor colorWithHexString:@"#D0D0D0"];
    [backView addSubview:lineView1];
    
    [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneTF.mas_bottom).with.offset(15);
        make.left.equalTo(self.phoneTF);
        make.right.equalTo(backView).with.offset(-25);
        make.height.offset(1);
    }];
    
    self.codeTF = [[UITextField alloc] init];
    _codeTF.borderStyle = UITextBorderStyleNone;
    _codeTF.placeholder = @"请输入验证码";
    _codeTF.font = [UIFont systemFontOfSize:14];
    _codeTF.keyboardType = UIKeyboardTypeNumberPad;
    self.codeTF.delegate = self;
    [_codeTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:(UIControlEventEditingChanged)];
    [backView addSubview:_codeTF];
    
    [self.codeTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.subhLabel);
        make.right.equalTo(lineView1);
        make.height.offset(20);
        make.top.equalTo(lineView1.mas_bottom).with.offset(20);
    }];
    
    UIView *lineView2 = [[UIView alloc] init];
    lineView2.backgroundColor = [UIColor colorWithHexString:@"#D0D0D0"];
    [backView addSubview:lineView2];
    
    [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.codeTF.mas_bottom).with.offset(15);
        make.left.equalTo(self.codeTF);
        make.right.equalTo(lineView1);
        make.height.offset(1);
    }];
    
    _codeBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    [_codeBtn setTitle:@"获取验证码" forState:(UIControlStateNormal)];
    [_codeBtn setTitleColor:GrayTextColor forState:UIControlStateNormal];
    _codeBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    _codeBtn.userInteractionEnabled = NO;
    [backView addSubview:_codeBtn];
    
    [_codeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(lineView1);
        make.centerY.equalTo(self.phoneTF);
        make.width.offset(80);
        make.height.offset(15);
    }];
    
    [_codeBtn countDownButtonHandler:^(JKCountDownButton *countDownButton, NSInteger tag) {
        
        NSMutableDictionary  *parmers = [NSMutableDictionary dictionary];
        NSString *deviceUUID = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
        [parmers setObject:self.phoneTF.text forKey:@"mobile"];
        [parmers setObject:deviceUUID forKey:@"regcode"];
        
                [HMHttpTool GET:[NSString stringWithFormat:@"%@%@",Base_URL,GetCode] params:parmers success:^(NSURLSessionDataTask *task, id responseObject) {
                    self.mesStr = [NSString stringWithFormat:@"%@",responseObject[@"status"]];
                    if ([self.mesStr isEqualToString:@"200"]) {
                        [countDownButton startCountDownWithSecond:60.0];
                        [countDownButton setTitleColor:UIColorBlack forState:UIControlStateNormal];
                        [countDownButton countDownChanging:^NSString *(JKCountDownButton *countDownButton, NSUInteger second) {
                            countDownButton.enabled = NO;
                            NSString *title = [NSString stringWithFormat:@"剩余%lu秒",(unsigned long)second];
                             [countDownButton setTitleColor:GrayTextColor forState:UIControlStateNormal];
                            return title;
                        }];
        
                        [countDownButton countDownFinished:^NSString *(JKCountDownButton *countDownButton, NSUInteger second) {
        
                            countDownButton.enabled = YES;
                            [countDownButton setTitleColor:UIColorBlack forState:UIControlStateNormal];
                            return @"重新获取";
        
                        }];
                    }
        
                    [SVProgressHUD showWithStatus:responseObject[@"message"]];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)),
                        dispatch_get_main_queue(), ^{
                            [SVProgressHUD dismiss];
                });
                } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
                }];
//        [HMHttpTool post:[NSString stringWithFormat:@"%@%@",Base_URL,GetCode] params:parmers success:^(NSDictionary *JSONDic) {
//            self.mesStr = [NSString stringWithFormat:@"%@",JSONDic[@"status"]];
//            if ([self.mesStr isEqualToString:@"200"]) {
//                [countDownButton startCountDownWithSecond:60.0];
//                [countDownButton setTitleColor:UIColorBlack forState:UIControlStateNormal];
//                [countDownButton countDownChanging:^NSString *(JKCountDownButton *countDownButton, NSUInteger second) {
//                    countDownButton.enabled = NO;
//                    NSString *title = [NSString stringWithFormat:@"剩余%lu秒",(unsigned long)second];
//                    [countDownButton setTitleColor:GrayTextColor forState:UIControlStateNormal];
//                    return title;
//                }];
//
//                [countDownButton countDownFinished:^NSString *(JKCountDownButton *countDownButton, NSUInteger second) {
//
//                    countDownButton.enabled = YES;
//                    [countDownButton setTitleColor:UIColorBlack forState:UIControlStateNormal];
//                    return @"重新获取";
//
//                }];
//            }
//
//            [SVProgressHUD showWithStatus:JSONDic[@"message"]];
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)),
//                           dispatch_get_main_queue(), ^{
//                               [SVProgressHUD dismiss];
//                           });
//        } failure:^(NSError *error) {
//
//        }];
        
    }];
    
    _choose = [[UIButton alloc]init];
    _choose.selected = YES;
    [_choose setImage:[UIImage imageNamed:@"未选择"] forState:UIControlStateNormal];
    [_choose setImage:[UIImage imageNamed:@"同意"] forState:UIControlStateSelected];
    [_choose addTarget:self action:@selector(chooseClcik:) forControlEvents:UIControlEventTouchUpInside];
    
    [backView addSubview:_choose];
    [_choose mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.codeTF);
        make.top.equalTo(lineView2.mas_bottom).with.offset(20);
        make.width.height.mas_equalTo(20);
    }];
    
    UILabel *read = [[UILabel alloc]init];
    read.userInteractionEnabled = YES;
    read.text = @"注册/登陆即代表同意《用户协议》";
    read.font = [UIFont systemFontOfSize:12];
    read.textColor = UIColorBlack;
    
    [backView addSubview:read];
    [read mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.choose.mas_centerY);
        make.left.equalTo(self.choose.mas_right).with.offset(5);
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [read addGestureRecognizer:tap];
    
    self.loginBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_loginBtn setTitle:@"登录" forState:(UIControlStateNormal)];
    _loginBtn.backgroundColor = RGBA(91, 129, 244, 0.5);
    
    _loginBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    _loginBtn.userInteractionEnabled = NO;
    [_loginBtn addTarget:self action:@selector(loginAction) forControlEvents:(UIControlEventTouchUpInside)];
    [backView addSubview:_loginBtn];
    
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.choose.mas_bottom).with.offset(38);
        make.left.equalTo(lineView2);
        make.right.equalTo(lineView2);
        make.height.offset(50);
    }];
    _loginBtn.layer.cornerRadius = 8;
    _loginBtn.layer.masksToBounds = YES;
    
}

- (void)closeClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)chooseClcik:(UIButton *)btn{
    btn.selected = !btn.selected;
}

- (void)tapAction{
    WebViewController *vc = [[WebViewController alloc] init];
    vc.urlStr = [NSString stringWithFormat:@"%@%@",Base_URL,@"/share/deal"];
    vc.text = @"协议";
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)textFieldDidChange:(UITextField *)textField{
    if (self.phoneTF.text.length == 11) {
        [_codeBtn setTitleColor:UIColorBlack forState:UIControlStateNormal];
        _codeBtn.userInteractionEnabled = YES;
        if (self.codeTF.text.length > 0) {
            self.loginBtn.backgroundColor = RGBA(91, 129, 244, 1.0);
            _loginBtn.userInteractionEnabled = YES;
        } else {
            self.loginBtn.backgroundColor = RGBA(91, 129, 244, 0.5);
            _loginBtn.userInteractionEnabled = NO;
        }
    } else {
        [_codeBtn setTitleColor:GrayTextColor forState:UIControlStateNormal];
        _codeBtn.userInteractionEnabled = NO;
        self.loginBtn.backgroundColor = RGBA(91, 129, 244, 0.5);
        _loginBtn.userInteractionEnabled = NO;
    }
}

- (void)loginAction{
    if (_choose.selected == YES) {
        
        self.loginBtn.userInteractionEnabled = NO;
        [self performSelector:@selector(loginDelayed) withObject:nil afterDelay:2.0f];
        NSMutableDictionary  *parmers = [NSMutableDictionary dictionary];
        NSString *deviceUUID = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
        [parmers setObject:self.phoneTF.text forKey:@"mobile"];
        [parmers setObject:deviceUUID forKey:@"regcode"];
        [parmers setObject:self.codeTF.text forKey:@"code"];
        [parmers setObject:@"ios" forKey:@"ncode"];
        [parmers setObject:QIYEBAOKEY forKey:@"canel"];
     
        [HMHttpTool post:[NSString stringWithFormat:@"%@%@",Base_URL,LoginUrl] params:parmers success:^(NSDictionary *JSONDic) {
            NSString *status = [NSString stringWithFormat:@"%@", JSONDic[@"status"]];
            if ([status isEqualToString:@"200"]) {
                NSDictionary *dic = JSONDic[@"data"];
                
                UserInfoModel *model = [[UserInfoModel alloc] init];
                if (dic[@"uid"] != nil) {
                    model.uid = [NSString stringWithFormat:@"%@", dic[@"uid"]];
                }
                if (dic[@"status"] == nil) {
                    model.status = @"0";
                } else {
                    model.status = dic[@"status"];
                }
                model.phone = self.phoneTF.text;
                
                [Utils saveUserInfoToUserDefault:model];
                [self.phoneTF resignFirstResponder];
                [self.codeTF resignFirstResponder];
                
                AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
                delegate.window.rootViewController = delegate.tabVC;
            } else {
                [SVProgressHUD showWithStatus:JSONDic[@"message"]];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [SVProgressHUD dismiss];
                });
            }
        } failure:^(NSError *error) {
            
        }];
       
    }else{
        [SVProgressHUD showInfoWithStatus:@"选择同意用户注册协议"];
    }
}
- (void)loginDelayed
{
    self.loginBtn.userInteractionEnabled = YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField == self.phoneTF){
        if (string.length == 11 ) return YES;
        NSInteger existedLength = textField.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = string.length;
        if (existedLength - selectedLength + replaceLength > 11 ){
            return NO;
        }
        return YES;
    }
    return YES;
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
