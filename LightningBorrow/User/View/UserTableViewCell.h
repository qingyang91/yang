//
//  UserTableViewCell.h
//  LightningBorrow
//
//  Created by 光磊信息 on 2018/12/13.
//  Copyright © 2018年 光磊信息. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *rightImg;

@end
