//
//  ProductDetailModel.m
//  BorrowingMoney
//
//  Created by Qingyang Xu on 2018/8/28.
//  Copyright © 2018年 puxu. All rights reserved.
//

#import "ProductDetailModel.h"

@implementation ProductDetailModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"typeId" : @"id"};
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.typeId = value;
    }
}

@end
