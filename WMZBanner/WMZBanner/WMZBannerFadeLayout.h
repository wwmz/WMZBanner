//
//  WMZBannerFadeLayout.h
//  WMZBanner
//
//  Created by wmz on 2020/6/15.
//  Copyright © 2020 wmz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WMZBannerParam.h"
NS_ASSUME_NONNULL_BEGIN

@interface WMZBannerFadeLayout : UICollectionViewFlowLayout
@property(nonatomic,strong)WMZBannerParam *param;
@property(nonatomic,assign)BOOL right;
- (instancetype)initConfigureWithModel:(WMZBannerParam *)param;
@end

NS_ASSUME_NONNULL_END
