//
//  AnswerViewController.m
//  Shoeslogo
//
//  Created by 潘昊亮 on 2018/12/13.
//  Copyright © 2018 潘昊亮. All rights reserved.
//

#import "AnswerViewController.h"

@interface AnswerViewController ()<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate>

@property (nonatomic,strong)UITableView * tableView;

@property (nonatomic,strong)UITextView * myTextfield;

@property (nonatomic,strong)UILabel * countLabel;

@property (nonatomic,strong)UILabel *textViewplaceholder;

@property (nonatomic,strong)UILabel * btnlb;

@property (nonatomic,strong)UIImageView * arrowView;

@property (nonatomic ,strong)UIView * selectview;

@property (nonatomic,strong)NSArray * selectArr;

@property (nonatomic,strong)NSString * sign;

@property (nonatomic,strong)UIImageView * imgV;


@end

@implementation AnswerViewController

- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"问题反馈";
    
    _selectArr = @[@"页面展示",@"实名认证",@"联系人",@"运营商",@"芝麻分",@"银行卡"];
    _sign = @"0";
    self.title = @"问题反馈";
    [super viewDidLoad];
   
    _tableView = [[UITableView alloc]init];
    [self.view addSubview: _tableView];
//    _tableView.backgroundColor = [UIColor whiteColor];
    [_tableView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(kScreenH - kNavBarHAbove7 - KHeight_TabBar + 49);
        make.top.equalTo(self.view).with.offset(kNavBarHAbove7);
    }];
    _tableView.dataSource = self;
    _tableView.delegate   = self;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"defualtCell"];
    

    if (@available(iOS 11.0, *)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
}

-(void)setConfigure:( UITableViewCell  * )cell{
    
    UILabel * typeLabel = [[UILabel alloc]init];
    
    [cell addSubview:typeLabel];
    typeLabel.text = @"意见反馈";
    typeLabel.textAlignment = NSTextAlignmentLeft;
    typeLabel.textColor = [UIColor blackColor];
    typeLabel.font = kSystemMainFont(15, UIFontWeightRegular);
    [typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cell.mas_left).offset(16);
        make.top.equalTo(cell.mas_top).offset(10);
        make.width.equalTo(@150);
        make.height.equalTo(@21);
    }];
    
    
    _myTextfield = [[UITextView alloc]init];
    [cell  addSubview:_myTextfield];
    [_myTextfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(typeLabel.mas_bottom).offset(10);
        make.left.equalTo(cell.mas_left).offset(10);
        make.right.equalTo(cell.mas_right).offset(-10);
        make.height.equalTo(@180);
        
    }];
    _myTextfield.textAlignment = NSTextAlignmentLeft;
    _myTextfield.delegate = self;

    
    _myTextfield.font = kSystemMainFont(10, UIFontWeightRegular);
    _myTextfield.backgroundColor = [UIColor colorWithHexString:@"#F7F7F7"];
    _myTextfield.textColor = [UIColor blackColor];
    
    _textViewplaceholder  = [[UILabel alloc]init];
    _textViewplaceholder.text = @"请输入您的问题,24小时会给您答复";
    _textViewplaceholder.textAlignment = NSTextAlignmentLeft;
    _textViewplaceholder.font = kSystemMainFont(10, UIFontWeightRegular);
    _textViewplaceholder.textColor = [UIColor colorWithHexString:@"#BFBFBF"];
    _textViewplaceholder.backgroundColor = [UIColor clearColor];
    [_myTextfield addSubview:_textViewplaceholder];
    [_textViewplaceholder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.myTextfield.mas_top).offset(7);
        make.height.equalTo(@(14));
        make.left.equalTo(self.myTextfield.mas_left).offset(13);
        make.right.equalTo(self.myTextfield.mas_right).offset(-5);
    }];
    
    
    
    
    UIView *bottomView = [[UIView alloc]init];
    bottomView.backgroundColor = [UIColor colorWithHexString:@"#F7F7F7"];
    [cell addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.myTextfield.mas_bottom);
        make.height.equalTo(@20);
        make.left.equalTo(self.myTextfield.mas_left);
        make.right.equalTo(self.myTextfield.mas_right);
        
    }];
    
    _countLabel = [[UILabel alloc]init];
    _countLabel.font = kSystemMainFont(14, UIFontWeightRegular);
    _countLabel.textAlignment = NSTextAlignmentRight;
    [bottomView addSubview:_countLabel];
    [_countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bottomView.mas_right).offset(-5);
        make.bottom.equalTo(bottomView.mas_bottom).offset(-5);
        make.height.equalTo(@15);
    }];
    
    _countLabel.text = [NSString stringWithFormat:@"%d/200",0];
    
    //意见或者建议
    
    UILabel * adviselabel = [[UILabel alloc]init];
    [cell addSubview:adviselabel];
    adviselabel.text = @"请选择问题类型";
    adviselabel.textAlignment = NSTextAlignmentLeft;
    adviselabel.textColor = [UIColor blackColor];
    adviselabel.font = kSystemMainFont(15, UIFontWeightRegular);
    [adviselabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cell.mas_left).offset(16);
        make.top.equalTo(bottomView.mas_bottom).offset(15);
        make.width.equalTo(@150);
        make.height.equalTo(@21);
    }];
    
    UIView * grayview = [[UIView alloc]init];
    [cell addSubview:grayview];
    [grayview  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(adviselabel.mas_bottom).offset(8);
        make.left.equalTo(cell.mas_left).offset(16);
        make.right.equalTo(cell.mas_right).offset(-16);
        make.height.equalTo(@37);
        
    }];
    grayview.userInteractionEnabled =YES;
    grayview.backgroundColor = [UIColor colorWithHexString:@"F7F7F7"];
    _btnlb   = [[UILabel alloc]init];
    _btnlb.textAlignment = NSTextAlignmentLeft;
    _btnlb.text = @"页面展示";
    _btnlb.textColor = [UIColor blackColor];
    _btnlb.font = kSystemMainFont(15, UIFontWeightRegular);
    [grayview  addSubview:_btnlb ];
    [_btnlb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(grayview.mas_centerY);
        make.height.equalTo(@25);
        make.width.equalTo(@100);
        make.left.equalTo(grayview.mas_left).offset(13);
     }];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showSelect)];
    [grayview addGestureRecognizer:tap];
    
    self.imgV = [[UIImageView alloc] init];
    _imgV.image = [UIImage imageNamed:@"Artboard 2 Copy 8"];
    [grayview addSubview:_imgV];
    
    [_imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(grayview);
        make.right.equalTo(grayview).with.offset(-13);
//        make.width.offset(16);
//        make.height.offset(16);
    }];
    
    UIButton *sureBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [sureBtn setTitle:@"提交" forState:(UIControlStateNormal)];
    [sureBtn setBackgroundColor:[UIColor colorWithHexString:@"#6B8CBB"]];
    sureBtn.titleLabel.font = kSystemMainFont(20, UIFontWeightRegular);
    [cell addSubview:sureBtn];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cell.mas_left).with.offset(16);
        make.right.equalTo(cell.mas_right).with.offset(-16);
        make.top.equalTo(grayview.mas_bottom).with.offset(44);
        make.height.offset(44);
    }];
    sureBtn.layer.cornerRadius = 22;
    [sureBtn addTarget:self action:@selector(sureAction) forControlEvents:(UIControlEventTouchUpInside)];
    
    _selectview  = [[UIView alloc]init];
    _selectview.userInteractionEnabled = YES;
    [cell addSubview:_selectview];
    _selectview.backgroundColor = [UIColor whiteColor];
    [_selectview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(grayview.mas_bottom).offset(9);
        make.left.equalTo(cell.mas_left).offset(16);
        make.right.equalTo(cell.mas_right).offset(-16);
        make.bottom.equalTo(cell.mas_bottom).offset(-10);
    }];
    
    _selectview.hidden = YES;
  
}

- (void)sureAction
{
    if (kStringIsEmpty(_myTextfield.text)) {
        [SVProgressHUD showErrorWithStatus:@"意见反馈不能为空"];

    } else {
        [SVProgressHUD showSuccessWithStatus:@"您的反馈已提交成功，请等待答复"];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
    }
}

-(void)showSelect{
    
    if ([_sign isEqualToString:@"0"]) {
  
        _selectview.hidden = NO;
        _imgV.image = [UIImage imageNamed:@"Artboard 2 Copy 9"];
    for (int i = 0;  i < 6 ; i ++) {
        
        UIView * btn = [[UIView alloc]init];
        btn.tag = 1000 + i ;
        btn.userInteractionEnabled = YES;
        btn.backgroundColor = [UIColor colorWithHexString:@"F2F2F@"];
        [_selectview  addSubview:btn];
        
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.selectview.mas_left);
            make.top.equalTo(self.selectview.mas_top).offset(10 + i * 36 );
            make.right.equalTo(self.selectview.mas_right);
            make.height.equalTo(@36);
        }];
        btn.backgroundColor = [UIColor colorWithHexString:@"f2f2f2"];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickbtn:)];
        [btn addGestureRecognizer:tap];
        
        UILabel * label = [[UILabel alloc]init];
        
        [btn addSubview:label];

        label.textAlignment = NSTextAlignmentLeft;
        label.text = _selectArr[i];
        label.textColor = [UIColor blackColor];
        label.font = kSystemMainFont(15, UIFontWeightRegular);
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(btn.mas_centerY);
            make.height.equalTo(@25);
            make.width.equalTo(@100);
            make.left.equalTo(btn.mas_left).offset(13);
        }];
        
        
        UIView * view = [[UIView alloc]init];
        view.backgroundColor = [UIColor whiteColor];
        [btn addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@1);
            make.left.equalTo(btn.mas_left);
            make.right.equalTo(btn.mas_right);
            make.bottom.equalTo(btn.mas_bottom);
        }];
        
        
     }
        _sign = @"1";
        
    }
    else {
        _selectview.hidden = YES;
        _imgV.image = [UIImage imageNamed:@"Artboard 2 Copy 8"];
        for (UIView * view  in _selectview.subviews) {
            
            [view removeFromSuperview];
        }
       
         _sign = @"0";
        
        
    }
    
    
    
}


-(void)clickbtn:(id)sender{
    UITapGestureRecognizer *tap = (UITapGestureRecognizer *)sender;
    
    UIView *view = (UIView*) tap.view;
    
    switch (view.tag) {
        case 1000:
            _btnlb.text = @"页面展示";
            break;
        case 1001:
            _btnlb.text = @"实名认证";
            break;
        case 1002:
            _btnlb.text = @"联系人";
            break;
        case 1003:
            _btnlb.text = @"运营商";
            break;
        case 1004:
            _btnlb.text = @"芝麻分";
            break;
        case 1005:
            _btnlb.text = @"银行卡";
            break;
        default:
            break;
    }
    
    for (UIView * view  in _selectview.subviews) {

        [view removeFromSuperview];
        
   
    }

    _sign = @"0";
    _selectview.hidden = YES;
    _imgV.image = [UIImage imageNamed:@"Artboard 2 Copy 8"];
}



- (void)textViewDidBeginEditing:(UITextView *)textView{
    
    [_textViewplaceholder removeFromSuperview];
    
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    NSString *new = [textView.text stringByReplacingCharactersInRange:range withString:text];
    NSInteger res = 200-[new length];
    if(res >= 0){
        return YES;
    }
    else{
        NSRange rg = {0,[text length]+res};
        if (rg.length>0) {
            NSString *s = [text substringWithRange:rg];
            [textView setText:[textView.text stringByReplacingCharactersInRange:range withString:s]];
        }
        return NO;
     
        
}
}
    
- (void)textViewDidChange:(UITextView *)textView{

        NSUInteger textcount=self.myTextfield.text.length;
    
        _countLabel.text = [NSString stringWithFormat:@"%lu/200",(unsigned long)textcount];
    
}
    




#pragma mark -----代理



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell =[[ UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"defualtCell"];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.backgroundColor = [UIColor whiteColor];
  
    [self setConfigure:cell];
    
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return self.view.bounds.size.height + AutoHeight(120);
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    
}

@end
