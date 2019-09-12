//
//  ExpandTableViewCell.h
//  BorrowingMoney
//
//  Created by Qingyang Xu on 2018/8/27.
//  Copyright © 2018年 puxu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LsitFrameModel;

@interface ExpandTableViewCell : UITableViewCell

@property (nonatomic, strong) LsitFrameModel *frameModel;
@property (nonatomic, strong) UILabel       *questionLB;
@property (nonatomic, strong) UILabel       *answerLB;
@property (nonatomic, strong) UIImageView   *arrowIV;
@property (nonatomic, strong) UIView        *line;
@property (nonatomic, strong) UIView        *line1;
@property (nonatomic, strong) UIImageView *quesView;
@end
