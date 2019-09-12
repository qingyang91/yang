//
//  AlertView.m
//  LightningBorrow
//
//  Created by 光磊信息 on 2018/12/17.
//  Copyright © 2018年 光磊信息. All rights reserved.
//

#import "AlertView.h"

@interface AlertView()

@property (nonatomic, strong) UIImageView *bgView;
@property (nonatomic, strong) UIButton *shadeView;
@property (nonatomic, strong) UIButton *cancelBtn;

@end

@implementation AlertView

- (instancetype)init
{
    self = [super initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
    if (self)
    {
        self.backgroundColor = [[UIColor clearColor] colorWithAlphaComponent:0];
        
        self.shadeView = [[UIButton alloc] initWithFrame:self.frame];
        self.shadeView.userInteractionEnabled = YES;
        self.shadeView.backgroundColor = [UIColor blackColor];
        self.shadeView.alpha = 0.4;
        [self addSubview:self.shadeView];
    
        self.bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 265, 315)];
        self.bgView.center = CGPointMake(kScreenW / 2, kScreenH / 2);
        self.bgView.image = [UIImage imageNamed:@"签到_弹窗"];
        self.bgView.userInteractionEnabled = YES;
        [self addSubview:self.bgView];
        
        self.cancelBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_cancelBtn setBackgroundImage:[UIImage imageNamed:@"Artboard 3"] forState:(UIControlStateNormal)];
        [_cancelBtn addTarget:self action:@selector(shadowViewClick) forControlEvents:(UIControlEventTouchUpInside)];
        _cancelBtn.userInteractionEnabled = YES;
        [self.bgView addSubview:_cancelBtn];
        
        [_cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.bgView).with.offset(-11);
            make.bottom.equalTo(self.bgView.mas_top).with.offset(5);
//            make.width.height.offset(19);
        }];
        
        UILabel *label1 = [[UILabel alloc] init];
        label1.text = @"火速审核中";
        label1.textAlignment = NSTextAlignmentCenter;
        label1.font = kSystemMainFont(36, UIFontWeightRegular);
        label1.textColor = [UIColor colorWithHexString:@"#FF5460"];
        [self.bgView addSubview:label1];
        
        [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.bgView);
            make.bottom.equalTo(self.bgView).with.offset(-97);
            make.height.offset(50);
        }];
        
        UILabel *label2 = [[UILabel alloc] init];
        label2.text = @"届时可以在银行卡或我的账单中查看";
        label2.textAlignment = NSTextAlignmentCenter;
        label2.font = kSystemMainFont(12, UIFontWeightRegular);
        label2.textColor = [UIColor colorWithHexString:@"#FFB561"];
        [self.bgView addSubview:label2];
        
        [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.bgView);
            make.top.equalTo(label1.mas_bottom).with.offset(2);
            make.height.offset(17);
        }];
        
        UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [btn setBackgroundImage:[UIImage imageNamed:@"Rectangle Copy"] forState:(UIControlStateNormal)];
        [btn setTitle:@"知道了" forState:(UIControlStateNormal)];
        btn.titleLabel.font = kSystemMainFont(20, UIFontWeightRegular);
        [btn addTarget:self action:@selector(shadowViewClick) forControlEvents:(UIControlEventTouchUpInside)];
        btn.userInteractionEnabled = YES;
        
        btn.layer.cornerRadius = 20;
        btn.layer.masksToBounds = YES;
        
        UIView *shadowView = [[UIView alloc]initWithFrame:CGRectMake(48, 251, 170, 40)];
        [self.bgView addSubview:shadowView];
        shadowView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
        shadowView.layer.shadowOffset = CGSizeMake(2, 2);
        shadowView.layer.shadowOpacity = 1;
        shadowView.layer.cornerRadius = 20;
        shadowView.clipsToBounds = NO;
        btn.frame = CGRectMake(0, 0, 170, 40);
        [shadowView addSubview:btn];
    }
    return self;
}


- (void)shadowViewClick {
    
    [self removeFromSuperview];
}

- (void)show {
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event

{
    
    UIView * view = [super hitTest:point withEvent:event];
    if (view != nil) {
        
        CGPoint newPoint = [_cancelBtn convertPoint:point fromView:self];
        // 判断触摸点是否在button上
        if (CGRectContainsPoint(_cancelBtn.bounds, newPoint)) {
               view = _cancelBtn;
            }
       }
    
    return view;
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
