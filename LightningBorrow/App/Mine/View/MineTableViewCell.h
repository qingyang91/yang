//
//  MineTableViewCell.h
//  BorrowingMoney
//
//  Created by Qingyang Xu on 2018/8/27.
//  Copyright © 2018年 puxu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MineTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *rightIma;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@end
