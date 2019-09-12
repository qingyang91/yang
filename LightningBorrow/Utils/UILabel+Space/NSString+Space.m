//
//  NSString+Space.m
//  ZhuKeBao
//
//  Created by chenjiajun on 2018/4/25.
//  Copyright © 2018年 zhukeyunfu. All rights reserved.
//

#import "NSString+Space.h"

@implementation NSString (Space)
+ (void)changeWordSpaceForLabel:(UILabel *)label WithSpace:(float)space {
    
    NSString *labelText = label.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSKernAttributeName:@(space)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    label.attributedText = attributedString;
    [label sizeToFit];
    
}

+ (void)changeWordSpaceForTextField:(UITextField *)textfield WithSpace:(float)space {
    NSString *placeholderText = textfield.placeholder;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:placeholderText attributes:@{NSKernAttributeName:@(space)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [placeholderText length])];
//    textfield.attributedText = attributedString;
    textfield.attributedPlaceholder = attributedString;
    [textfield sizeToFit];
}
@end
