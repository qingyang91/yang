//
//  UserInfoModel.h
//  BeikoCube
//
//  Created by Qingyang Xu on 2018/8/14.
//  Copyright © 2018年 光磊信息. All rights reserved.
//

#import "JSONModel.h"

@interface UserInfoModel : JSONModel

@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *token;
@property (nonatomic, copy) NSString *str1;
@property (nonatomic, copy) NSString *str2;
@property (nonatomic, copy) NSString *str3;
@property (nonatomic, copy) NSString *str4;
@property (nonatomic, copy) NSString *str5;
@property (nonatomic, copy) NSString *str6;
@property (nonatomic, copy) NSString *isTrueName;
@property (nonatomic, copy) NSString *isOperator;
@property (nonatomic, copy) NSString *isRelation;
@property (nonatomic, copy) NSString *isCard;


@end
