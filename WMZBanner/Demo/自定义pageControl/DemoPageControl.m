//
//  DemoPageControl.m
//  WMZBanner
//
//  Created by wmz on 2019/12/19.
//  Copyright © 2019 wmz. All rights reserved.
//

#import "DemoPageControl.h"
#import "WMZBannerView.h"
@interface DemoPageControl ()

@end

@implementation DemoPageControl

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self styleDefault];
    [self styleOne];
    [self styleTwo];
    [self styleThree];
}

- (void)styleDefault{
    WMZBannerParam *param =  BannerParam()
    .wBannerControlColorSet([UIColor lightGrayColor])
    .wBannerControlSelectColorSet([UIColor orangeColor])
    .wFrameSet(CGRectMake(10, 100, BannerWitdh-20, BannerHeight/6))
    .wDataSet([self getData]);
    WMZBannerView *viewOne = [[WMZBannerView alloc]initConfigureWithModel:param];
    [self.view addSubview:viewOne];
}

- (void)styleOne{
      WMZBannerParam *param =  BannerParam()
      .wBannerControlImageSet(@"bannerP1")
      .wBannerControlSelectImageSet(@"bannerP2")
      .wBannerControlImageSizeSet(CGSizeMake(8, 20))
      .wBannerControlSelectImageSizeSet(CGSizeMake(20, 20))
       //调整间距
      .wBannerControlSelectMarginSet(3)
      .wBannerControlPositionSet(BannerControlRight)
      .wFrameSet(CGRectMake(10, BannerHeight/3, BannerWitdh-20, BannerHeight/6))
      .wDataSet([self getData]);
      WMZBannerView *viewOne = [[WMZBannerView alloc]initConfigureWithModel:param];
      [self.view addSubview:viewOne];
}

- (void)styleTwo{
      WMZBannerParam *param =  BannerParam()
      .wFrameSet(CGRectMake(10, BannerHeight/2+20, BannerWitdh-20, BannerHeight/6))
      .wBannerControlImageSet(@"bannerP3")
      .wBannerControlSelectImageSet(@"bannerP4")
      .wBannerControlImageSizeSet(CGSizeMake(14, 14))
      .wBannerControlSelectImageSizeSet(CGSizeMake(14, 14))
      .wBannerControlPositionSet(BannerControlLeft)
      .wDataSet([self getData]);
      WMZBannerView *viewOne = [[WMZBannerView alloc]initConfigureWithModel:param];
      [self.view addSubview:viewOne];
}

- (void)styleThree{
      WMZBannerParam *param =  BannerParam()
      .wFrameSet(CGRectMake(10, BannerHeight*0.7+20, BannerWitdh-20, BannerHeight/6))
      .wBannerControlImageSet(@"bannerP3")
      .wBannerControlSelectImageSet(@"bannerP2")
      .wBannerControlImageSizeSet(CGSizeMake(10, 10))
      .wBannerControlSelectImageSizeSet(CGSizeMake(30, 30))
      //自定义pageControl的位置
      .wCustomControlSet(^(UIPageControl *pageControl) {
          //随意改变xy值
          CGRect rect = pageControl.frame;
          rect.origin.y =  10;
          pageControl.frame = rect;
      })
      .wDataSet([self getData]);
      WMZBannerView *viewOne = [[WMZBannerView alloc]initConfigureWithModel:param];
      [self.view addSubview:viewOne];
}


- (NSArray*)getData{
    return @[
      @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1576744105022&di=f4aadd0b85f93309a4629c998773ae83&imgtype=0&src=http%3A%2F%2Fimg.pconline.com.cn%2Fimages%2Fupload%2Fupc%2Ftx%2Fwallpaper%2F1206%2F07%2Fc0%2F11909864_1339034191111.jpg",
      @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1576744105022&di=f06819b43c8032d203642874d1893f3d&imgtype=0&src=http%3A%2F%2Fi2.sinaimg.cn%2Fent%2Fs%2Fm%2Fp%2F2009-06-25%2FU1326P28T3D2580888F326DT20090625072056.jpg",
      @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1577338893&di=189401ebacb9704d18f6ab02b7336923&imgtype=jpg&er=1&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fblog%2F201308%2F05%2F20130805105309_5E2zE.jpeg",
      @"https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=3425860897,3737508983&fm=26&gp=0.jpg"
      ];
}
- (void)dealloc{
    
}

@end
