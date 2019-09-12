//
//  AbousModel.h
//  BorrowingMoney
//
//  Created by Qingyang Xu on 2018/8/30.
//  Copyright © 2018年 puxu. All rights reserved.
//

#import "JSONModel.h"

@interface AbousModel : JSONModel

@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *linkman;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *pic;
@property (nonatomic, copy) NSString *tel;
@property (nonatomic, copy) NSString *wx_id;

@end
