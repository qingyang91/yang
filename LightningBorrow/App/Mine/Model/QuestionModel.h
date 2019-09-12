//
//  QuestionModel.h
//  BorrowingMoney
//
//  Created by Qingyang Xu on 2018/8/27.
//  Copyright © 2018年 puxu. All rights reserved.
//

#import "JSONModel.h"

@interface QuestionModel : JSONModel

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *create_time;
@property (nonatomic,copy) NSString *subh;
@property (nonatomic,copy) NSString *typeId;
@property (nonatomic, assign) BOOL isSelected;

@end
