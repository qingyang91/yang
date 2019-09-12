//
//  AboutModel.h
//  LightningBorrow
//
//  Created by Qingyang Xu on 2018/12/27.
//  Copyright © 2018年 光磊信息. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AboutModel : NSObject

@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *path;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *typeId;

@end

NS_ASSUME_NONNULL_END
