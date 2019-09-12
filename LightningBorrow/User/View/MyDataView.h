//
//  MyDataView.h
//  LightningBorrow
//
//  Created by 光磊信息 on 2018/12/13.
//  Copyright © 2018年 光磊信息. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyDataView : UIView

@property (nonatomic, strong) UILabel *attestationLabel;

- (instancetype)initWithFrame:(CGRect)frame ImageName:(NSString *)imageName title:(NSString *)title;

@end
