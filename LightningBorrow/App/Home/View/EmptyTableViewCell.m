//
//  EmptyTableViewCell.m
//  shellFlowers
//
//  Created by Qingyang Xu on 2018/12/6.
//  Copyright © 2018年 puxu. All rights reserved.
//

#import "EmptyTableViewCell.h"

@implementation EmptyTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if(self){
        self.backgroundColor=[UIColor clearColor];
        [self initSubView];
    }
    
    return self;
}
- (void)initSubView{
    _imageEmptyView = [[UIImageView alloc]init];
    _imageEmptyView.image = [UIImage imageNamed:@"空"];
    _imageEmptyView.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:_imageEmptyView];
    [self.imageEmptyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).with.offset(AutoHeight(90));
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.width.mas_equalTo(160);
        make.height.mas_equalTo(160);
    }];
    
    _emptyLabel = [[UILabel alloc]init];
    _emptyLabel.text = @"数据为空";
    _emptyLabel.textAlignment = NSTextAlignmentCenter;
    _emptyLabel.font = [UIFont systemFontOfSize:14];
    _emptyLabel.textColor = [UIColor colorWithHexString:@"#6C6C6C"];
    [self.contentView addSubview:_emptyLabel];
    [self.emptyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).with.offset(30);
        make.right.equalTo(self.contentView).with.offset(-30);
        make.top.equalTo(self.imageEmptyView.mas_bottom).with.offset(15);
        make.height.mas_equalTo(20);
    }];
    
    _emptyBtn = [[UIButton alloc]init];
    [_emptyBtn setTitleColor:kAppNavColor forState:UIControlStateNormal];
    [_emptyBtn setTitle:@"重新尝试" forState:UIControlStateNormal];
    _emptyBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    _emptyBtn.titleLabel.textAlignment = 1;
    [self.contentView addSubview:_emptyBtn];
    [_emptyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).with.offset(30);
        make.right.equalTo(self.contentView).with.offset(-30);
        make.top.equalTo(self.emptyLabel.mas_bottom).with.offset(5);
        make.height.mas_equalTo(20);
    }];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
