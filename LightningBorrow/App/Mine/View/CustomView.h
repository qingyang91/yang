//
//  CustomView.h
//  LightningBorrow
//
//  Created by Qingyang Xu on 2019/1/5.
//  Copyright © 2019年 光磊信息. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomView : UIView

- (instancetype)initWithTitle:(NSString *)text Rirht:(NSString *)rightText ConfirmBlock:(void(^)())confirmBlock;

- (void)show;

@end

NS_ASSUME_NONNULL_END
