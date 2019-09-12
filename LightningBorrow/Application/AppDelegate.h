//
//  AppDelegate.h
//  LightningBorrow
//
//  Created by 光磊信息 on 2018/12/12.
//  Copyright © 2018年 光磊信息. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LightningTabbarController.h"
#import "PXTabBarViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) LightningTabbarController *tabBarVC;
@property (nonatomic, strong) PXTabBarViewController *tabVC;

@end

