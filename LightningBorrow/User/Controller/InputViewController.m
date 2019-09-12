//
//  InputViewController.m
//  LightningBorrow
//
//  Created by 光磊信息 on 2018/12/14.
//  Copyright © 2018年 光磊信息. All rights reserved.
//

#import "InputViewController.h"

@interface InputViewController ()

@property (nonatomic, strong) UITextField *tf;

@end

@implementation InputViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:(UIBarButtonItemStylePlain) target:self action:@selector(saveAction)];
    self.navigationItem.rightBarButtonItem = rightBtn;
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, kNavBarHAbove7 + 6, kScreenW, 40)];
    backView.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
    [self.view addSubview:backView];
    
    self.tf = [[UITextField alloc] initWithFrame:CGRectMake(16, 0, kScreenW - 32, 40)];
    _tf.font = kSystemMainFont(15, UIFontWeightRegular);
    _tf.placeholder = [NSString stringWithFormat:@"请输入%@", self.title];
    _tf.textAlignment = NSTextAlignmentRight;
    _tf.borderStyle = UITextBorderStyleNone;
    _tf.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
    if ([self.title containsString:@"卡号"] || [self.title  containsString:@"手机号"] || [self.title  containsString:@"身份证"]) {
        _tf.keyboardType = UIKeyboardTypeNumberPad;
    }
    [backView addSubview:_tf];
    
}

- (void)saveAction
{
    if (!kStringIsEmpty(self.tf.text)) {
        if (self.returnTextBlock != nil) {
            self.returnTextBlock(self.tf.text);
        }
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@不能为空", [self.title substringFromIndex:2]]];
    }
}

- (void)returnText:(ReturnTextBlock)block {
    self.returnTextBlock = block;
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
