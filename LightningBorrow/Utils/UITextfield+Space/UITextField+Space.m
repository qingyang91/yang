//
//  UITextField+Space.m
//  zhukeyunfuManger
//
//  Created by chenjiajun on 2018/5/4.
//  Copyright © 2018年 zkyfios02. All rights reserved.
//

#import "UITextField+Space.h"

@implementation UITextField (Space)

-(void)changePlaceholderSpaceWithPlaceholer:(NSString *)placeholder Space:(CGFloat)space {
    NSString *placeholderText = self.placeholder;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:placeholderText attributes:@{NSKernAttributeName:@(space)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [placeholderText length])];
//    [attributedString addAttribute:NSFontAttributeName value:kSystemMainFont(12.0f, UIFontWeightRegular) range:NSMakeRange(0, [placeholderText length])];
    //    textfield.attributedText = attributedString;
    self.attributedPlaceholder = attributedString;
    [self sizeToFit];
}

@end
