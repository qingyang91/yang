//
//  ProductModel.m
//  BorrowingMoney
//
//  Created by 光磊信息 on 2018/8/28.
//  Copyright © 2018年 puxu. All rights reserved.
//

#import "ProductModel.h"

@implementation ProductModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
}

@end
