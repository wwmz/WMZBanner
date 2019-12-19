//
//  WMZBannerOverLayout.h
//  WMZBanner
//
//  Created by wmz on 2019/12/18.
//  Copyright © 2019 wmz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WMZBannerParam.h"
NS_ASSUME_NONNULL_BEGIN

@interface WMZBannerOverLayout : UICollectionViewFlowLayout
@property(nonatomic,strong)WMZBannerParam *param;
- (instancetype)initConfigureWithModel:(WMZBannerParam *)param;
@end

NS_ASSUME_NONNULL_END
