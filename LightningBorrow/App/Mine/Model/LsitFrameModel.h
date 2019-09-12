//
//  LsitFrameModel.h
//  BorrowingMoney
//
//  Created by Qingyang Xu on 2018/8/27.
//  Copyright © 2018年 puxu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HeightFont.h"
#import "QuestionModel.h"
@interface LsitFrameModel : NSObject

@property(nonatomic,assign)CGRect questionFrame;
@property(nonatomic,assign)CGRect arrowFrame;
@property(nonatomic,assign)CGRect firstLineFrame;
@property(nonatomic,assign)CGRect answerFrame;
@property(nonatomic,assign)CGRect secondLineFrame;
@property(nonatomic,assign)CGRect imageFrame;

//cell的高度
//未展开的高度
@property(nonatomic,assign)CGFloat unExpandCellHeight;
//展开的高度
@property(nonatomic,assign)CGFloat expandCellHeight;

@property(nonatomic,strong)QuestionModel *listModel;

@end
