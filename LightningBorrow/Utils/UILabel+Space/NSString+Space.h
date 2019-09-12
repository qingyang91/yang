//
//  NSString+Space.h
//  ZhuKeBao
//
//  Created by chenjiajun on 2018/4/25.
//  Copyright © 2018年 zhukeyunfu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Space)
+ (void)changeWordSpaceForLabel:(UILabel *)label WithSpace:(float)space;
+ (void)changeWordSpaceForTextField:(UITextField *)textfield WithSpace:(float)space;

@end
