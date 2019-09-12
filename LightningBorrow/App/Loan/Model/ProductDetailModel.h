//
//  ProductDetailModel.h
//  BorrowingMoney
//
//  Created by Qingyang Xu on 2018/8/28.
//  Copyright © 2018年 puxu. All rights reserved.
//

#import "JSONModel.h"

@interface ProductDetailModel : JSONModel

@property (nonatomic, copy) NSString *loaname;
@property (nonatomic, copy) NSString *amount;
@property (nonatomic, copy) NSString *scope;
@property (nonatomic, copy) NSString *loanrate;
@property (nonatomic, copy) NSString *loanlimit;
@property (nonatomic, copy) NSString *limits;
@property (nonatomic, copy) NSString *loantime;
@property (nonatomic, copy) NSString *upload;
@property (nonatomic, copy) NSString *apply;
@property (nonatomic, copy) NSString *information;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *typeId;

@end
