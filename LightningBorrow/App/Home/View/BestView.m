//
//  BestView.m
//  LightningBorrow
//
//  Created by Qingyang Xu on 2018/12/26.
//  Copyright © 2018年 光磊信息. All rights reserved.
//

#import "BestView.h"

@implementation BestView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews{
    self.backgroundColor = [UIColor colorWithHexString:@"#F0F5FF"];
    
    _hotView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"hot"]];
    [self addSubview:self.hotView];
    [_hotView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self);
        make.width.height.mas_equalTo(20);
    }];
    
    self.productView = [[UIImageView alloc]init];
    self.productView.layer.cornerRadius = 10;
    self.productView.layer.masksToBounds = YES;
    [self addSubview:self.productView];
    [_productView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(18);
        make.top.equalTo(self).with.offset(20);
        make.width.height.mas_equalTo(20);
    }];
    
    self.productLabel = [[UILabel alloc]init];
    self.productLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:self.productLabel];
    [_productLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.productView.mas_right).with.offset(5);
        make.centerY.mas_equalTo(self.productView.mas_centerY);
        make.right.equalTo(self).with.offset(-2);
    }];
    
    self.moneyLabel = [[UILabel alloc]init];
    self.moneyLabel.textColor = kAppNavColor;
    self.moneyLabel.font = [UIFont fontWithName:@"DINCondensed-Bold" size:25];
    self.moneyLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.moneyLabel];
    [_moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.productLabel.mas_bottom).with.offset(16);
    }];
    
    self.tipLabel = [[UILabel alloc]init];
    self.tipLabel.text = @"最高可借(元)";
    self.tipLabel.font = [UIFont systemFontOfSize:12];
    self.tipLabel.textAlignment = NSTextAlignmentCenter;
    self.tipLabel.textColor = [UIColor colorWithHexString:@"#6C6C6C"];
    [self addSubview:self.tipLabel];
    [_tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.moneyLabel.mas_centerX);
        make.top.equalTo(self.moneyLabel.mas_bottom).with.offset(5);
    }];
}

@end
