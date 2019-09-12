//
//  CodeTableViewCell.h
//  LightningBorrow
//
//  Created by 光磊信息 on 2018/12/13.
//  Copyright © 2018年 光磊信息. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CodeTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet JKCountDownButton *codeBtn;
@property (weak, nonatomic) IBOutlet UITextField *codeTF;

@end
