//
//  TianMaoCell.h
//  WMZBanner
//
//  Created by wmz on 2019/12/16.
//  Copyright © 2019 wmz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WMZBannerConfig.h"
NS_ASSUME_NONNULL_BEGIN

@interface TianMaoCell : UICollectionViewCell
@property(nonatomic,strong)UIImageView *backImage;
@property(nonatomic,strong)UILabel *topLa;
@property(nonatomic,strong)UILabel *titleLa;
@property(nonatomic,strong)UILabel *textLa;
@property(nonatomic,strong)UILabel *typeLa;
@property(nonatomic,strong)UIView *bottomView;
@property(nonatomic,strong)UIButton *detailBtn;
@end

NS_ASSUME_NONNULL_END
