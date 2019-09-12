//
//  LsitFrameModel.m
//  BorrowingMoney
//
//  Created by Qingyang Xu on 2018/8/27.
//  Copyright © 2018年 puxu. All rights reserved.
//

#import "LsitFrameModel.h"

@implementation LsitFrameModel

-(void)setListModel:(QuestionModel *)listModel{
    _listModel = listModel;

    self.imageFrame = CGRectMake(16, 15, 16, 16);
    self.questionFrame  = CGRectMake(40, 15, kScreenW-80, 15);
    self.arrowFrame     = CGRectMake(kScreenW-30, 10, 24, 24);
    self.firstLineFrame = CGRectMake(0, 45, kScreenW, 1);
    self.unExpandCellHeight = CGRectGetMaxY(self.firstLineFrame)+5;

    CGFloat answerH     = [HeightFont getStringHeight:listModel.content andFont:13 andWidth:kScreenW-40];
    self.answerFrame    = CGRectMake(40, 40, kScreenW-80, answerH);
    self.secondLineFrame    = CGRectMake(0, CGRectGetMaxY(self.answerFrame)+5, kScreenW, 1);

    self.expandCellHeight = CGRectGetMaxY(self.secondLineFrame);

}

@end
