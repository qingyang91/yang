//
//  BindBankViewController.m
//  LightningBorrow
//
//  Created by 光磊信息 on 2018/12/14.
//  Copyright © 2018年 光磊信息. All rights reserved.
//

#import "BindBankViewController.h"
#import "InputViewController.h"
#import "TrueNameTableViewCell.h"
#import "CodeTableViewCell.h"

@interface BindBankViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSArray *subArray;
@property (nonatomic, strong) UIView *infoView;
@property (nonatomic, strong) UIView *codeView;
@property (nonatomic, copy)   NSString *mesStr;


@end

@implementation BindBankViewController

- (UIView *)infoView
{
    if (!_infoView) {
        _infoView = [[UIView alloc] initWithFrame:CGRectMake(0, 47, kScreenW, 17)];
        _infoView.backgroundColor = [UIColor whiteColor];
        
        
        UILabel *infoLabel = [[UILabel alloc] init];
        infoLabel.text = @"卡号输入有误，请重新输入";
        infoLabel.font = kSystemMainFont(12, UIFontWeightLight);
        infoLabel.textColor = [UIColor colorWithHexString:@"#CF1322"];
        infoLabel.textAlignment = NSTextAlignmentRight;
        [_infoView addSubview:infoLabel];
        [infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.infoView).with.offset(-16);
            make.top.bottom.equalTo(self.infoView);
        }];
        
        UIImageView *imgV = [[UIImageView alloc] init];
        imgV.image = [UIImage imageNamed:@"Artboard 5"];
        [_infoView addSubview:imgV];
        
        [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(infoLabel.mas_left).with.offset(-3);
            make.centerY.equalTo(self.infoView);
            make.width.height.offset(11);
        }];
    }
    return _infoView;
}

- (UIView *)codeView
{
    if (!_codeView) {
        _codeView = [[UIView alloc] initWithFrame:CGRectMake(0, 226, kScreenW, 17)];
        _codeView.backgroundColor = [UIColor whiteColor];
        
        
        UILabel *infoLabel = [[UILabel alloc] init];
        infoLabel.text = @"验证码输入有误,请重新输入";
        infoLabel.font = kSystemMainFont(12, UIFontWeightLight);
        infoLabel.textColor = [UIColor colorWithHexString:@"#CF1322"];
        infoLabel.textAlignment = NSTextAlignmentRight;
        [_codeView addSubview:infoLabel];
        [infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.infoView).with.offset(-16);
            make.top.bottom.equalTo(self.infoView);
        }];
        
        UIImageView *imgV = [[UIImageView alloc] init];
        imgV.image = [UIImage imageNamed:@"Artboard 5"];
        [_codeView addSubview:imgV];
        
        [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(infoLabel.mas_left).with.offset(-3);
            make.centerY.equalTo(self.infoView);
            make.width.height.offset(11);
        }];
    }
    return _codeView;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.scrollEnabled = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerNib:[UINib nibWithNibName:@"TrueNameTableViewCell" bundle:nil] forCellReuseIdentifier:@"trueCell"];
        
        [_tableView registerNib:[UINib nibWithNibName:@"CodeTableViewCell" bundle:nil] forCellReuseIdentifier:@"codeCell"];
    }
    return _tableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"实名认证";
    
    self.dataArray = @[@"银行卡号", @"持卡人", @"身份证", @"手机号", @"验证码"];
    self.subArray = @[@"请输入卡号", @"持卡人姓名", @"持卡人身份证", @"银行预留手机号", @"验证码"];
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
    self.tableView.frame = CGRectMake(0, kIs_iPhoneXSeries(78, 54), kScreenW, kScreenH - kIs_iPhoneXSeries(112, 54));
    [self.view addSubview:_tableView];
    
    UIButton *sureBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [sureBtn setTitle:@"提交" forState:(UIControlStateNormal)];
    [sureBtn setBackgroundColor:[UIColor colorWithHexString:@"#6B8CBB"]];
    sureBtn.titleLabel.font = kSystemMainFont(20, UIFontWeightRegular);
    [self.view addSubview:sureBtn];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(16);
        make.right.equalTo(self.view.mas_right).with.offset(-16);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(kIs_iPhoneXSeries(-AutoHeight(310), -AutoHeight(275)));
        make.height.offset(44);
    }];
    sureBtn.layer.cornerRadius = 22;
    [sureBtn addTarget:self action:@selector(sureAction) forControlEvents:(UIControlEventTouchUpInside)];
}

- (void)sureAction
{
    [self.infoView removeFromSuperview];
    TrueNameTableViewCell *cell1 = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    if (![self IsBankCard:cell1.subLabel.text]) {
        [self.tableView addSubview:self.infoView];
    }
   
    TrueNameTableViewCell *cell2 = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    TrueNameTableViewCell *cell3 = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    TrueNameTableViewCell *cell4 = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    CodeTableViewCell *cell5 = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];
    if ([cell1.subLabel.text isEqualToString:@"请输入姓名"]) {
        [SVProgressHUD showErrorWithStatus:@"姓名不能为空"];
        return;
    }
    if (![self checkUserID:cell3.subLabel.text]) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的身份证号"];
        return;
    }
    if ([cell2.subLabel.text isEqualToString:@"持卡人姓名"]) {
        [SVProgressHUD showErrorWithStatus:@"持卡人姓名不能为空"];
        return;
    }
    if (cell4.subLabel.text.length != 11) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号"];
        return;
    }
    
    UserInfoModel *info = [Utils GetUserInfo];
    NSMutableDictionary  *parmers = [NSMutableDictionary dictionary];
    NSString *deviceUUID = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    [parmers setObject:info.phone forKey:@"mobile"];
    [parmers setObject:deviceUUID forKey:@"regcode"];
    [parmers setObject:cell5.codeTF.text forKey:@"code"];
    
    
    [HMHttpTool post:[NSString stringWithFormat:@"%@%@",Base_URL,LoginUrl] params:parmers success:^(NSDictionary *JSONDic) {
        NSString *status = [NSString stringWithFormat:@"%@", JSONDic[@"status"]];
        NSLog(@"%@",JSONDic);
        if ([status isEqualToString:@"200"]) {
            [SVProgressHUD showSuccessWithStatus:@"实名认证成功"];
            UserInfoModel *info = [Utils GetUserInfo];
            info.isCard = @"1";
            [Utils saveUserInfoToUserDefault:info];
        } else {
            [SVProgressHUD showWithStatus:@"验证码错误"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
        }
    } failure:^(NSError *error) {
        
    }];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 46;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.row < 4) {
        TrueNameTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"trueCell" forIndexPath:indexPath];
        
        cell.mainLabel.text = self.dataArray[indexPath.row];
        cell.subLabel.text = self.subArray[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else {
        CodeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"codeCell" forIndexPath:indexPath];
        [JKCountDownButton sharedInstance];
        [cell.codeBtn countDownButtonHandler:^(JKCountDownButton *countDownButton, NSInteger tag) {
            countDownButton.enabled = NO;
            [countDownButton startCountDownWithSecond:60.0];
            countDownButton.backgroundColor = [UIColor lightGrayColor];
            
            NSMutableDictionary  *parmers = [NSMutableDictionary dictionary];
            NSString *deviceUUID = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
            UserInfoModel *info = [Utils GetUserInfo];
            [parmers setObject:info.phone forKey:@"mobile"];
            [parmers setObject:deviceUUID forKey:@"regcode"];
            
            
            [HMHttpTool post:[NSString stringWithFormat:@"%@%@",Base_URL,GetCode] params:parmers success:^(NSDictionary *JSONDic) {
                self.mesStr = [NSString stringWithFormat:@"%@",JSONDic[@"status"]];
                if ([self.mesStr isEqualToString:@"200"]) {
                    [countDownButton startCountDownWithSecond:60.0];
                    [countDownButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                    [countDownButton countDownChanging:^NSString *(JKCountDownButton *countDownButton, NSUInteger second) {
                        countDownButton.enabled = NO;
                        NSString *title = [NSString stringWithFormat:@"剩余%lu秒",(unsigned long)second];
                        [countDownButton setTitleColor:GrayTextColor forState:UIControlStateNormal];
                        return title;
                    }];
                    
                    [countDownButton countDownFinished:^NSString *(JKCountDownButton *countDownButton, NSUInteger second) {
                        
                        countDownButton.enabled = YES;
                        [countDownButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                        return @"重新获取";
                        
                    }];
                }
                
                [SVProgressHUD showWithStatus:JSONDic[@"message"]];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)),
                               dispatch_get_main_queue(), ^{
                                   [SVProgressHUD dismiss];
                               });
            } failure:^(NSError *error) {
                
            }];
            
            
        }];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < 4) {
        TrueNameTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        InputViewController *vc = [[InputViewController alloc] init];
        vc.title = [NSString stringWithFormat:@"输入%@", self.dataArray[indexPath.row]];
        [vc returnText:^(NSString *showText) {//定义B视图后调用block
            cell.subLabel.text = showText;
        }];
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        CodeTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        [cell.codeTF becomeFirstResponder];
    }
}

- (BOOL) IsBankCard:(NSString *)cardNumber
{
    if(cardNumber.length==0)
    {
        return NO;
    }
    NSString *digitsOnly = @"";
    char c;
    for (int i = 0; i < cardNumber.length; i++)
    {
        c = [cardNumber characterAtIndex:i];
        if (isdigit(c))
        {
            digitsOnly =[digitsOnly stringByAppendingFormat:@"%c",c];
        }
    }
    int sum = 0;
    int digit = 0;
    int addend = 0;
    BOOL timesTwo = false;
    for (NSInteger i = digitsOnly.length - 1; i >= 0; i--)
    {
        digit = [digitsOnly characterAtIndex:i] - '0';
        if (timesTwo)
        {
            addend = digit * 2;
            if (addend > 9) {
                addend -= 9;
            }
        }
        else {
            addend = digit;
        }
        sum += addend;
        timesTwo = !timesTwo;
    }
    int modulus = sum % 10;
    return modulus == 0;
}

-(BOOL)checkUserID:(NSString *)userID
{
    //长度不为18的都排除掉
    if (userID.length!=18) {
        return NO;
    }
    
    //校验格式
    NSString *regex2 = @"^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    BOOL flag = [identityCardPredicate evaluateWithObject:userID];
    
    if (!flag) {
        return flag;    //格式错误
    }else {
        //格式正确在判断是否合法
        
        //将前17位加权因子保存在数组里
        NSArray * idCardWiArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
        
        //这是除以11后，可能产生的11位余数、验证码，也保存成数组
        NSArray * idCardYArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
        
        //用来保存前17位各自乖以加权因子后的总和
        NSInteger idCardWiSum = 0;
        for(int i = 0;i < 17;i++)
        {
            NSInteger subStrIndex = [[userID substringWithRange:NSMakeRange(i, 1)] integerValue];
            NSInteger idCardWiIndex = [[idCardWiArray objectAtIndex:i] integerValue];
            
            idCardWiSum+= subStrIndex * idCardWiIndex;
            
        }
        
        //计算出校验码所在数组的位置
        NSInteger idCardMod=idCardWiSum%11;
        
        //得到最后一位身份证号码
        NSString * idCardLast= [userID substringWithRange:NSMakeRange(17, 1)];
        
        //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
        if(idCardMod==2)
        {
            if([idCardLast isEqualToString:@"X"]||[idCardLast isEqualToString:@"x"])
            {
                return YES;
            }else
            {
                return NO;
            }
        }else{
            //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
            if([idCardLast isEqualToString: [idCardYArray objectAtIndex:idCardMod]])
            {
                return YES;
            }
            else
            {
                return NO;
            }
        }
    }
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
