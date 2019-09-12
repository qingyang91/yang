//
//  LightingLoanViewController.m
//  LightningBorrow
//
//  Created by 光磊信息 on 2018/12/17.
//  Copyright © 2018年 光磊信息. All rights reserved.
//

#import "LightingLoanViewController.h"
#import "SJSlider.h"
#import "SJLabelSlider.h"
#import "SJButtonSlider.h"
#import "AlertView.h"

@interface LightingLoanViewController () <SJSliderDelegate, UITextFieldDelegate>

@property (nonatomic, strong) UITextField *moneyTF;
@property (nonatomic, strong) SJSlider *slider;
@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *rightBtn;


@end

@implementation LightingLoanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"闪现贷";
    
    
    
    [self initUI];
}

- (void)initUI
{
    UIView *backView = [[UIView alloc] init];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(16);
        make.right.equalTo(self.view).with.offset(-16);
        make.top.equalTo(self.view).with.offset(AutoHeight(87));
        make.height.offset(AutoHeight(337));
    }];
    
    backView.layer.cornerRadius = 5;
    backView.layer.shadowOffset = CGSizeMake(2, 2);
    backView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    backView.layer.shadowOpacity = 1;
    
    UILabel *borrowLabel = [[UILabel alloc] init];
    borrowLabel.text = @"借多少(元)";
    borrowLabel.textAlignment = NSTextAlignmentCenter;
    borrowLabel.font = kSystemMainFont(15, UIFontWeightRegular);
    borrowLabel.textColor = [UIColor colorWithHexString:@"#222222"];
    [backView addSubview:borrowLabel];
    
    [borrowLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(backView);
        make.top.equalTo(backView).with.offset(AutoHeight(27));
        make.height.offset(AutoHeight(21));
    }];
    
    self.moneyTF = [[UITextField alloc] init];
    _moneyTF.text = @"00.00";
    _moneyTF.keyboardType = UIKeyboardTypeNumberPad;
    _moneyTF.textAlignment = NSTextAlignmentCenter;
    _moneyTF.borderStyle = UITextBorderStyleNone;
    _moneyTF.font = kSystemMainFont(48, UIFontWeightRegular);
    _moneyTF.delegate = self;
    [_moneyTF addTarget:self action:@selector(textChange:) forControlEvents:(UIControlEventEditingChanged)];
    [backView addSubview:_moneyTF];
    
    [_moneyTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(backView);
        make.top.equalTo(borrowLabel.mas_bottom).with.offset(AutoHeight(19));
        make.height.offset(AutoHeight(48));
    }];
    
    UILabel *messageLabel = [[UILabel alloc] init];
    messageLabel.text = @"可借余额 10,0000.00元";
    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.font = kSystemMainFont(12, UIFontWeightRegular);
    messageLabel.textColor = [UIColor colorWithHexString:@"#FF8F00"];
    [backView addSubview:messageLabel];
    
    [messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(backView);
        make.top.equalTo(self.moneyTF.mas_bottom).with.offset(AutoHeight(13));
        make.height.offset(17);
    }];
    
    self.slider = ({
        SJSlider *slider = [SJSlider new];
        
        [self.view addSubview:slider];
        
        slider.value = 0.00;
        slider.trackHeight = 4;
        
        slider.trackImageView.image = [UIImage imageNamed:@"Rectangle 14-1"];
        slider.traceImageView.backgroundColor = [UIColor clearColor];
        slider.thumbImageView.image = [UIImage imageNamed:@"Artboard 8"];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            slider.round = NO;
        });
        
        slider;
    });

    _slider.delegate = self;
    [backView addSubview:_slider];
    [_slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView).with.offset(16);
        make.right.equalTo(backView).with.offset(-16);
        make.top.equalTo(messageLabel.mas_bottom).with.offset(AutoHeight(32));
        make.height.offset(AutoHeight(14));
    }];
    
    UILabel *label0 = [[UILabel alloc] init];
    label0.text = @"0";
    label0.textAlignment = NSTextAlignmentLeft;
    label0.font = kSystemMainFont(15, UIFontWeightRegular);
    label0.textColor = [UIColor colorWithHexString:@"#222222"];
    [backView addSubview:label0];
    
    [label0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.slider);
        make.top.equalTo(self.slider.mas_bottom).with.offset(10);
        make.height.offset(AutoHeight(21));
    }];
    
    UILabel *label1 = [[UILabel alloc] init];
    label1.text = @"50000";
    label1.textAlignment = NSTextAlignmentCenter;
    label1.font = kSystemMainFont(15, UIFontWeightRegular);
    label1.textColor = [UIColor colorWithHexString:@"#222222"];
    [backView addSubview:label1];
    
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.slider);
        make.top.equalTo(self.slider.mas_bottom).with.offset(10);
        make.height.offset(AutoHeight(21));
    }];
    
    UILabel *label2 = [[UILabel alloc] init];
    label2.text = @"100000";
    label2.textAlignment = NSTextAlignmentRight;
    label2.font = kSystemMainFont(15, UIFontWeightRegular);
    label2.textColor = [UIColor colorWithHexString:@"#222222"];
    [backView addSubview:label2];
    
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.slider);
        make.top.equalTo(self.slider.mas_bottom).with.offset(10);
        make.height.offset(AutoHeight(21));
    }];
    
    UILabel *limitLabel = [[UILabel alloc] init];
    limitLabel.text = @"借款期限";
    limitLabel.textAlignment = NSTextAlignmentCenter;
    limitLabel.font = kSystemMainFont(15, UIFontWeightRegular);
    limitLabel.textColor = [UIColor colorWithHexString:@"#222222"];
    [backView addSubview:limitLabel];
    
    [limitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(backView);
        make.bottom.equalTo(backView).with.offset(-AutoHeight(81));
        make.height.offset(AutoHeight(21));
    }];
    
    self.leftBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_leftBtn setBackgroundImage:[UIImage imageNamed:@"Artboard 9"] forState:(UIControlStateNormal)];
    [_leftBtn setTitle:@"7天" forState:(UIControlStateNormal)];
    [_leftBtn setTitleColor:[UIColor colorWithHexString:@"#FF4D5F"] forState:(UIControlStateNormal)];
    _leftBtn.adjustsImageWhenHighlighted = NO;
    _leftBtn.titleLabel.font = kSystemMainFont(16, UIFontWeightRegular);
    [_leftBtn addTarget:self action:@selector(leftAction) forControlEvents:(UIControlEventTouchUpInside)];
    [backView addSubview:_leftBtn];
    
    [_leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView).with.offset(AutoWidth(70));
        make.bottom.equalTo(backView).with.offset(-AutoHeight(24));
        make.height.offset(34);
        make.width.offset(70);
    }];
    
    self.rightBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_rightBtn setBackgroundImage:[UIImage imageNamed:@"Artboard 9 Copy"] forState:(UIControlStateNormal)];
    [_rightBtn setTitle:@"14天" forState:(UIControlStateNormal)];
    [_rightBtn setTitleColor:[UIColor colorWithHexString:@"#FF4D5F"] forState:(UIControlStateNormal)];
    _rightBtn.adjustsImageWhenHighlighted = NO;
    _rightBtn.titleLabel.font = kSystemMainFont(16, UIFontWeightRegular);
    [_rightBtn addTarget:self action:@selector(rightAction) forControlEvents:(UIControlEventTouchUpInside)];
    [backView addSubview:_rightBtn];
    
    [_rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(backView).with.offset(-AutoWidth(70));
        make.bottom.equalTo(backView).with.offset(-AutoHeight(24));
        make.height.offset(34);
        make.width.offset(70);
    }];
    
    
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    
    [btn setBackgroundImage:[UIImage imageNamed:@"Rectangle Copy"] forState:(UIControlStateNormal)];
    [btn setTitle:@"立即借款" forState:(UIControlStateNormal)];
    btn.titleLabel.font = kSystemMainFont(20, UIFontWeightRegular);
    [btn addTarget:self action:@selector(btnClick) forControlEvents:(UIControlEventTouchUpInside)];
    
    btn.layer.cornerRadius = AutoHeight(27);
    btn.layer.masksToBounds = YES;
    
    UIView *shadowView = [[UIView alloc]initWithFrame:CGRectMake(AutoWidth(57), AutoHeight(474), AutoWidth(262), AutoHeight(54))];
    [self.view addSubview:shadowView];
    shadowView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    shadowView.layer.shadowOffset = CGSizeMake(2, 2);
    shadowView.layer.shadowOpacity = 1;
    shadowView.layer.cornerRadius = AutoHeight(27);
    shadowView.clipsToBounds = NO;
    btn.frame = CGRectMake(0, 0, AutoWidth(262), AutoHeight(54));
    [shadowView addSubview:btn];
}

- (void)btnClick
{
    AlertView *view = [[AlertView alloc] init];
    [view show];
}

- (void)leftAction
{
    [_leftBtn setBackgroundImage:[UIImage imageNamed:@"Artboard 9"] forState:(UIControlStateNormal)];
    [_rightBtn setBackgroundImage:[UIImage imageNamed:@"Artboard 9 Copy"] forState:(UIControlStateNormal)];
}

- (void)rightAction
{
    [_leftBtn setBackgroundImage:[UIImage imageNamed:@"Artboard 9 Copy"] forState:(UIControlStateNormal)];
    [_rightBtn setBackgroundImage:[UIImage imageNamed:@"Artboard 9"] forState:(UIControlStateNormal)];
}

- (void)textChange:(UITextField *)textField
{
    NSInteger i = [textField.text integerValue];
    if (i > 100000) {
        textField.text = @"100000";
        self.slider.value = 1;
    } else {
        self.slider.value = [textField.text floatValue] / 100000;
    }
}

- (void)sliderDidDrag:(SJSlider *)slider {
    CGFloat num = [self roundFloat:slider.value];
    self.moneyTF.text = [NSString stringWithFormat:@"%.02f", num * 100000];
}

-(float)roundFloat:(float)price{
    
    return (floorf(price*100 + 0.5))/100;
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    textField.text = @"";
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
