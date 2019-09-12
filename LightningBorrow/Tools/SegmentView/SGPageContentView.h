//
//  SGPageContentView.h
//
//  Created by yangpan on 2016/12/15.
//  Copyright © 2016年 ZJW. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SGPageContentView;

@protocol SGPageContentViewDelegare <NSObject>
/// delegatePageContentView
- (void)SGPageContentView:(SGPageContentView *)SGPageContentView progress:(CGFloat)progress originalIndex:(NSInteger)originalIndex targetIndex:(NSInteger)targetIndex;

@end

@interface SGPageContentView : UIView
/**
 *  对象方法创建 SGPageContentView
 *
 *  @param frame     frame
 *  @param parentVC     当前控制器
 *  @param childVCs     子控制器个数
 */
- (instancetype)initWithFrame:(CGRect)frame parentVC:(UIViewController *)parentVC childVCs:(NSArray *)childVCs;
/**
 *  类方法创建 SGPageContentView
 *
 *  @param frame     frame
 *  @param parentVC     当前控制器
 *  @param childVCs     子控制器个数
 */
+ (instancetype)pageContentViewWithFrame:(CGRect)frame parentVC:(UIViewController *)parentVC childVCs:(NSArray *)childVCs;

/** delegatePageContentView */
@property (nonatomic, weak) id<SGPageContentViewDelegare> delegatePageContentView;

/** 给外界提供的方法，获取 SGSegmentedControl 选中按钮的下标, 必须实现 */
- (void)setPageCententViewCurrentIndex:(NSInteger)currentIndex;

@end
