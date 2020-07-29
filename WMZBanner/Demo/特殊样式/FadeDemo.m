





//
//  FadeDemo.m
//  WMZBanner
//
//  Created by wmz on 2020/6/17.
//  Copyright © 2020 wmz. All rights reserved.
//

#import "FadeDemo.h"
#import "WMZBannerView.h"
@interface FadeDemo ()

@end

@implementation FadeDemo

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self styleOne];
    [self styleTwo];
}


- (void)styleOne{
    WMZBannerParam *param =  BannerParam()
    .wFrameSet(CGRectMake(10,100, BannerWitdh-20, BannerHeight*0.25))
    .wItemSizeSet(CGSizeMake(BannerWitdh-20, BannerHeight*0.25))
    .wDataSet([self getData])
    //淡入淡出
    .wFadeOpenSet(YES)
    .wAutoScrollSet(YES)
    .wRepeatSet(YES)
    .wAutoScrollSecondSet(1.5)
    ;
    WMZBannerView *viewOne = [[WMZBannerView alloc]initConfigureWithModel:param];
    [self.view addSubview:viewOne];
}

- (void)styleTwo{
    WMZBannerParam *param =  BannerParam()
    .wFrameSet(CGRectMake(10,BannerHeight*0.25+150, BannerWitdh-20, BannerHeight*0.25))
    .wItemSizeSet(CGSizeMake(BannerWitdh-30, BannerHeight*0.25))
    .wDataSet([self getData])
    .wLineSpacingSet(5)
    .wHideBannerControlSet(YES)
    //淡入淡出
    .wFadeOpenSet(YES)
    //纵向
    .wVerticalSet(YES);
    WMZBannerView *viewOne = [[WMZBannerView alloc]initConfigureWithModel:param];
    [self.view addSubview:viewOne];
}

- (NSArray*)getData{
    return @[
      @"http://f.hiphotos.baidu.com/zhidao/wh%3D450%2C600/sign=64fdb384ce5c1038242bc6c68721bf25/060828381f30e92435342faf44086e061c95f798.jpg",
          @"http://dmimg.5054399.com/allimg/optuji/qbanop/38.jpg",
          @"http://img4.imgtn.bdimg.com/it/u=3778233232,2537963140&fm=26&gp=0.jpg",
      @"http://gss0.baidu.com/-4o3dSag_xI4khGko9WTAnF6hhy/zhidao/pic/item/09fa513d269759ee1100528cb2fb43166d22df20.jpg"

      ];
}

@end
