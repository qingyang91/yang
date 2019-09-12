//
//  MyDataView.m
//  LightningBorrow
//
//  Created by 光磊信息 on 2018/12/13.
//  Copyright © 2018年 光磊信息. All rights reserved.
//

#import "MyDataView.h"

@implementation MyDataView



- (instancetype)initWithFrame:(CGRect)frame ImageName:(NSString *)imageName title:(NSString *)title 
{
    self = [super initWithFrame:frame];
    if (self)
    {
        UIImageView *imgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
        imgV.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:imgV];
        
        [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self);
            make.height.offset(45);
        }];
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.text = title;
        titleLabel.numberOfLines = -1;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = kSystemMainFont(12, UIFontWeightRegular);
        [self addSubview:titleLabel];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(imgV.mas_bottom).with.offset(5);
        }];
        
        self.attestationLabel = [[UILabel alloc] init];
        _attestationLabel.textAlignment = NSTextAlignmentCenter;
        _attestationLabel.font = [UIFont systemFontOfSize:10];
        _attestationLabel.textColor = [UIColor colorWithHexString:@"#1414FF"];
        [self addSubview:_attestationLabel];
        
        [_attestationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self);
            make.centerX.equalTo(self);
            make.height.offset(14);
        }];
     }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
