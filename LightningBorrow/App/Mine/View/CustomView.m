//
//  CustomView.m
//  LightningBorrow
//
//  Created by Qingyang Xu on 2019/1/5.
//  Copyright © 2019年 光磊信息. All rights reserved.
//

#import "CustomView.h"

@interface CustomView()

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIButton *shadowView;
@property (nonatomic,   copy) void(^confirmBlock)();

@end

@implementation CustomView

- (instancetype)initWithTitle:(NSString *)text Rirht:(NSString *)rightText ConfirmBlock:(void (^)())confirmBlock{
    self = [super initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
    if (self) {
        _confirmBlock = confirmBlock;
        self.backgroundColor = [UIColor clearColor];
        self.shadowView = [[UIButton alloc] initWithFrame:self.frame];
        self.shadowView.backgroundColor = [UIColor blackColor];
        self.shadowView.alpha = 0.4;
        [self addSubview:self.shadowView];
        
        self.bgView = [[UIView alloc] init];
        self.bgView.backgroundColor = UIColorWhite;
        self.bgView.layer.cornerRadius = 8;
        self.bgView.layer.masksToBounds = YES;
        
        [self addSubview:self.bgView];
        [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).with.offset(58);
            make.right.equalTo(self).with.offset(-58);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.height.mas_equalTo(160);
        }];
        
        UILabel *label = [[UILabel alloc]init];
        label.text = @"温馨提示";
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:17 weight:UIFontWeightMedium];
        
        [_bgView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.bgView).with.offset(25);
            make.right.equalTo(self.bgView).with.offset(-25);
            make.top.equalTo(self.bgView).with.offset(25);
        }];
        
        UILabel *label1 = [[UILabel alloc]init];
        label1.text = text;
        label1.textAlignment = NSTextAlignmentCenter;
        label1.numberOfLines = 0;
        label1.font = [UIFont systemFontOfSize:13];
        
        [_bgView addSubview:label1];
        [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.bgView).with.offset(16);
            make.right.equalTo(self.bgView).with.offset(-16);
            make.top.equalTo(label.mas_bottom).with.offset(12);
        }];
        
        UIView *line = [[UIView alloc]init];
        line.backgroundColor = [UIColor colorWithHexString:@"#EDEDED"];
        [_bgView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.bgView);
            make.bottom.equalTo(self.bgView).with.offset(-40);
            make.height.mas_equalTo(1);
        }];
        
        UIButton *btn = [[UIButton alloc]init];
        [btn setTitle:rightText forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(confirmClick) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitleColor:kAppNavColor forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        
        [_bgView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.bgView);
            make.top.equalTo(line);
            make.height.mas_equalTo(40);
        }];
    }
    return self;
}

- (void)confirmClick{
    if (self.confirmBlock) {
        self.confirmBlock();
    }
}

- (void)show{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}
@end
