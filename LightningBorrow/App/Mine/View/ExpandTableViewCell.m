//
//  ExpandTableViewCell.m
//  BorrowingMoney
//
//  Created by Qingyang Xu on 2018/8/27.
//  Copyright © 2018年 puxu. All rights reserved.
//

#import "ExpandTableViewCell.h"
#import "LsitFrameModel.h"
@implementation ExpandTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self addSubviews];
    }
    return self;
}
-(void)addSubviews{
    self.quesView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"问题"]];
    [self.contentView addSubview:self.quesView];
    
    self.questionLB = [[UILabel alloc]init];
    self.questionLB.font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
    [self.contentView addSubview:self.questionLB];
    self.questionLB.textAlignment = NSTextAlignmentLeft;
    
    self.arrowIV = [[UIImageView alloc]init];
    [self.contentView addSubview:self.arrowIV];
    
    self.line = [[UIView alloc]init];
    [self.contentView addSubview:self.line];
    
    
    self.answerLB = [[UILabel alloc]init];
    [self.contentView addSubview:self.answerLB];
    self.answerLB.font = [UIFont systemFontOfSize:12];
    self.answerLB.textAlignment = NSTextAlignmentLeft;
    self.answerLB.numberOfLines = 0;
    
    self.line1 = [[UIView alloc]init];
    [self.contentView addSubview:self.line1];
    self.line1.backgroundColor = [UIColor colorWithHexString:@"#EBEBEB"];
    
}

-(void)setFrameModel:(LsitFrameModel *)frameModel{
    _frameModel = frameModel;
    self.questionLB.frame = frameModel.questionFrame;
    self.arrowIV.frame    = frameModel.arrowFrame;
    self.line.frame       = frameModel.firstLineFrame;
    self.answerLB.frame   = frameModel.answerFrame;
    self.line1.frame      = frameModel.secondLineFrame;
    self.quesView.frame   = frameModel.imageFrame;
    
    self.questionLB.text = [NSString stringWithFormat:@"%@",frameModel.listModel.title];
    self.answerLB.text = [NSString stringWithFormat:@"%@",frameModel.listModel.content];
    self.arrowIV.contentMode = UIViewContentModeScaleAspectFit;
    if (frameModel.listModel.isSelected) {
        self.arrowIV.image = [UIImage imageNamed:@"chevron up"];
        self.line.frame = CGRectMake(0, 45, kScreenW, 1);
        self.line.backgroundColor = [UIColor colorWithHexString:@"#EBEBEB"];
    }else{
        self.arrowIV.image = [UIImage imageNamed:@"chevron down"];
        self.line.backgroundColor = [UIColor colorWithHexString:@"#EBEBEB"];
    }
    
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
