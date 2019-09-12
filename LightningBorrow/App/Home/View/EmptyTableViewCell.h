//
//  EmptyTableViewCell.h
//  shellFlowers
//
//  Created by Qingyang Xu on 2018/12/6.
//  Copyright © 2018年 puxu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EmptyTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *imageEmptyView;
@property (nonatomic, strong) UILabel     *emptyLabel;
@property (nonatomic, strong) UIButton     *emptyBtn;

@end

NS_ASSUME_NONNULL_END
