//
//  LoanModel.h
//  BorrowingMoney
//
//  Created by Qingyang Xu on 2018/8/28.
//  Copyright © 2018年 puxu. All rights reserved.
//

#import "JSONModel.h"

@interface LoanModel : JSONModel

@property (nonatomic, copy) NSString *loaname;
@property (nonatomic, copy) NSString *loanrate;
@property (nonatomic, copy) NSString *scope;
@property (nonatomic, copy) NSString *sort;
@property (nonatomic, copy) NSString *upload;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *hide;
@property (nonatomic, copy) NSString *hot;
@property (nonatomic, copy) NSString *typeId;

@end
