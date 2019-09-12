//
//  LoanTableViewCell.m
//  LightningBorrow
//
//  Created by 光磊信息 on 2018/12/17.
//  Copyright © 2018年 光磊信息. All rights reserved.
//

#import "LightningLoanTableViewCell.h"

@implementation LightningLoanTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backView.layer.cornerRadius = 5;
    self.backView.layer.shadowOffset = CGSizeMake(2, 2);
    self.backView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.backView.layer.shadowOpacity = 1;
    
    self.typeLabel.layer.cornerRadius = 9;
    self.typeLabel.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
