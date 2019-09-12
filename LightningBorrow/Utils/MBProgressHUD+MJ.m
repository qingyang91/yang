//
//  MBProgressHUD+MJ.m
//
//  Created by mj on 13-4-18.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "MBProgressHUD+MJ.h"
//#import "Define.h"

@implementation MBProgressHUD (MJ)
#pragma mark 显示信息
+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view
{
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = text;
   //hud.label.text = text;
    // 设置图片
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", icon]]];
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    
    hud.userInteractionEnabled = NO;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    // 3秒之后再消失
    [hud hide:YES afterDelay:3];
    //[hud hideAnimated:YES afterDelay:3];
    
}

+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view afterDelay:(NSTimeInterval)afterDelay
{
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
//    hud.labelText = text;
     hud.label.text = text;
    // 设置图片
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", icon]]];
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
//    hud.userInteractionEnabled = NO;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    // 1秒之后再消失
    //[hud hide:YES afterDelay:afterDelay];
    [hud hideAnimated:YES afterDelay:afterDelay];

}

#pragma mark 显示错误信息
+ (void)showError:(NSString *)error toView:(UIView *)view{
    [self show:error icon:@"error.png" view:view];
}

+ (void)showSuccess:(NSString *)success toView:(UIView *)view
{
    [self show:success icon:@"success.png" view:view];
}

#pragma mark 显示一些信息
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view {
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
//    hud.labelText = message;
    hud.label.text = message;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // YES代表需要蒙版效果
    //hud.dimBackground = YES;
    hud.dimBackground = YES;
    return hud;
}

+ (void)showSuccess:(NSString *)success
{
    NSString *str = nil;
    if (![success containsString:@"！"]) {
        str = [NSString stringWithFormat:@"%@！", success];
    } else {
        str = success;
    }
    [self showSuccess:str toView:nil];
}

+ (void)showSuccess:(NSString *)success afterDelay:(NSTimeInterval)afterDelay
{
    NSString *str = nil;
    if (![success containsString:@"！"]) {
        str = [NSString stringWithFormat:@"%@！", success];
    } else {
        str = success;
    }
    [self show:str icon:@"success.png" view:nil afterDelay:afterDelay];
}

+ (void)showError:(NSString *)error
{
    NSString *str = nil;
    if (![error containsString:@"！"]) {
        str = [NSString stringWithFormat:@"%@！", error];
    } else {
        str = error;
    }
    [self showError:str toView:nil];
}

+ (void)showError:(NSString *)error afterDelay:(NSTimeInterval)afterDelay
{
    NSString *str = nil;
    if (![error containsString:@"！"]) {
        str = [NSString stringWithFormat:@"%@！", error];
    } else {
        str = error;
    }
    [self show:str icon:@"error.png" view:nil afterDelay:afterDelay];
}

+ (MBProgressHUD *)showMessage:(NSString *)message
{
    return [self showMessage:message toView:nil];
}

+ (void)hideHUDForView:(UIView *)view
{
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    [self hideHUDForView:view animated:YES];
}

+ (void)hideHUD
{
    [self hideHUDForView:nil];
}
@end
