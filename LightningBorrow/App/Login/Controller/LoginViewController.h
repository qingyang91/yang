//
//  LoginViewController.h
//  BorrowingMoney
//
//  Created by Qingyang Xu on 2018/8/24.
//  Copyright © 2018年 puxu. All rights reserved.
//

#import "QMUICommonViewController.h"

@class LoginViewController;
@protocol showTimeDelegate <NSObject>
-(void)sendMSMTime:(LoginViewController *)regVC time:(NSInteger) num;
@end

@interface LoginViewController : QMUICommonViewController

@property (nonatomic,assign)id<showTimeDelegate> delegate;
@property (nonatomic,assign)NSInteger numValues;

@end
