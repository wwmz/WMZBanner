//
//  SpecilFirstScaleDemo.m
//  WMZBanner
//
//  Created by wmz on 2020/8/19.
//  Copyright © 2020 wmz. All rights reserved.
//

#import "SpecilFirstScaleDemo.h"
#import "WMZBannerView.h"
@interface SpecilFirstScaleDemo ()

@end

@implementation SpecilFirstScaleDemo

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self styleOne];
}


- (void)styleOne{
    WMZBannerParam *param =  BannerParam()
    .wFrameSet(CGRectMake(10,100, BannerWitdh-20, BannerHeight*0.25))
    .wItemSizeSet(CGSizeMake((BannerWitdh-50)/3, BannerHeight*0.18))
    .wDataSet([self getData])
    .wScaleSet(YES)
    .wLineSpacingSet(10)
    .wRepeatSet(YES)
    .wHideBannerControlSet(YES)
    .wSpecialStyleSet(SpecialStyleFirstScale);
    WMZBannerView *viewOne = [[WMZBannerView alloc]initConfigureWithModel:param];
    [self.view addSubview:viewOne];
    
}

- (NSArray*)getData{
    return @[
      @{@"name":@"第0个",@"icon":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1597912538465&di=cf27b604a09cc86a31b136525fd6611b&imgtype=0&src=http%3A%2F%2Fimg3.imgtn.bdimg.com%2Fit%2Fu%3D2422345863%2C2654460938%26fm%3D214%26gp%3D0.jpg"},
      @{@"name":@"第1个",@"icon":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1597912514660&di=a0182075bd0bc424d12ab7472a4cad15&imgtype=0&src=http%3A%2F%2Fimg3.a0bi.com%2Fupload%2Fttq%2F20140802%2F1406969914400.jpg"},
      @{@"name":@"第2个",@"icon":@"https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=294505291,2139227285&fm=26&gp=0.jpg"},
      @{@"name":@"第3个",@"icon":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1597912514660&di=2ea315151ad9030350ed0ad4aa971ce1&imgtype=0&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201501%2F27%2F20150127103509_KvXhU.thumb.700_0.jpeg"},
      
//      @{@"name":@"第0个",@"icon":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1597912538465&di=cf27b604a09cc86a31b136525fd6611b&imgtype=0&src=http%3A%2F%2Fimg3.imgtn.bdimg.com%2Fit%2Fu%3D2422345863%2C2654460938%26fm%3D214%26gp%3D0.jpg"},
//      @{@"name":@"第1个",@"icon":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1597912514660&di=a0182075bd0bc424d12ab7472a4cad15&imgtype=0&src=http%3A%2F%2Fimg3.a0bi.com%2Fupload%2Fttq%2F20140802%2F1406969914400.jpg"},
//      @{@"name":@"第2个",@"icon":@"https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=294505291,2139227285&fm=26&gp=0.jpg"},
//      @{@"name":@"第3个",@"icon":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1597912514660&di=2ea315151ad9030350ed0ad4aa971ce1&imgtype=0&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fitem%2F201501%2F27%2F20150127103509_KvXhU.thumb.700_0.jpeg"}

      ];
}


@end
