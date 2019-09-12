//
//  ProductModel.h
//  BorrowingMoney
//
//  Created by 光磊信息 on 2018/8/28.
//  Copyright © 2018年 puxu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductModel : NSObject

@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *amount;
@property (nonatomic, copy) NSString *desci;
@property (nonatomic, copy) NSString *loaname;
@property (nonatomic, copy) NSString *loanlimit;
@property (nonatomic, copy) NSString *loanrate;
@property (nonatomic, copy) NSString *upload;
@property (nonatomic, copy) NSString *url;

@end
