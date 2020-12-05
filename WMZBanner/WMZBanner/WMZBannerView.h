//
//  WMZBannerView.h
//  WMZBanner
//
//  Created by wmz on 2019/9/6.
//  Copyright © 2019 wmz. All rights reserved.
//

#import "WMZBannerParam.h"
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface WMZBannerView : UIView
//背景图
@property(strong,nonatomic)UIImageView *bgImgView;

/**
 *  调用方法
 *
 */
- (instancetype)initConfigureWithModel:(WMZBannerParam *)param withView:(UIView*)parentView;

/**
 *  调用方法
 *
 */
- (instancetype)initConfigureWithModel:(WMZBannerParam *)param;
/**
 *  更新UI
 *
 */
- (void)updateUI;


/**
*  手动调用滚动
*
*/
- (void)scrolToPath:(NSIndexPath*)path animated:(BOOL)animated;

@end

@interface Collectioncell : UICollectionViewCell
@property(nonatomic,strong)UIImageView *icon;
@property(nonatomic,strong)WMZBannerParam *param;
@end

@interface CollectionTextCell : UICollectionViewCell
@property(nonatomic,strong)UILabel *label;
@property(nonatomic,strong)WMZBannerParam *param;
@end

NS_ASSUME_NONNULL_END
