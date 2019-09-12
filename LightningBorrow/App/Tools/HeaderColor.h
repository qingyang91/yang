//
//  HeaderColor.h
//  CookBook
//
//  Created by Qingyang Xu on 2018/8/24.
//  Copyright © 2018年 puxu. All rights reserved.
//

#ifndef HeaderColor_h
#define HeaderColor_h


//颜色
#define kColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define mainColor [UIColor colorWithHexString:@"#0075FF"]
//随机色
#define kRandomColor kColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

//整个app的颜色
#define kAppColor kColor(255, 255, 255)

//整个app导航栏的颜色
#define kAppNavColor [UIColor colorWithHexString:@"#2F54EB"]

// 背景色
#define VCBackgroundColor [UIColor colorWithHexString:@"#F8F8F8"]

//常用色
#define  GrayTextColor [UIColor colorWithHexString:@"#615656"]

#define  AppBlueColor     [UIColor colorWithHexString:@"#597EF7"]

#define  color_gray [UIColor colorWithWhite:0 alpha:0.2]
#define  separateColor [UIColor colorWithHexString:@"#EDEDED"]



#endif /* HeaderColor_h */
