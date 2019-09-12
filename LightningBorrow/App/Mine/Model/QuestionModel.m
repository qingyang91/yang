//
//  QuestionModel.m
//  BorrowingMoney
//
//  Created by Qingyang Xu on 2018/8/27.
//  Copyright © 2018年 puxu. All rights reserved.
//

#import "QuestionModel.h"

@implementation QuestionModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"typeId" : @"id"};
}

@end
