//
//  LoanTableViewCell.h
//  LightningBorrow
//
//  Created by Qingyang Xu on 2018/12/25.
//  Copyright © 2018年 光磊信息. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LoanTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *productIma;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *tipRateLaebl;
@property (weak, nonatomic) IBOutlet UILabel *rateLabel;

@end

NS_ASSUME_NONNULL_END
