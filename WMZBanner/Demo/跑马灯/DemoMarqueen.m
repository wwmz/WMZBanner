


//
//  DemoMarqueen.m
//  WMZBanner
//
//  Created by wmz on 2019/12/19.
//  Copyright © 2019 wmz. All rights reserved.
//

#import "DemoMarqueen.h"
#import "WMZBannerView.h"
@interface DemoMarqueen ()

@end

@implementation DemoMarqueen

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
     /*
      *横向
      */
     WMZBannerParam *param =  BannerParam()
     .wFrameSet(CGRectMake(10, BannerHeight/6, BannerWitdh-20, BannerHeight/4))
     .wDataSet([self getData])
    //开启跑马灯
     .wMarqueeSet(YES)
     //开启循环滚动
     .wRepeatSet(YES)
     //速率
    .wMarqueeRateSet(0.6);
     WMZBannerView *viewOne = [[WMZBannerView alloc]initConfigureWithModel:param];
     [self.view addSubview:viewOne];
    
    
     /*
      *纵向
      */
     WMZBannerParam *param1 =  BannerParam()
     .wFrameSet(CGRectMake(10, BannerHeight/2, BannerWitdh-20, BannerHeight/4))
     .wDataSet([self getData])
    //开启跑马灯
     .wMarqueeSet(YES)
     //开启循环滚动
     .wRepeatSet(YES)
    //不可拖动
     .wCanFingerSlidingSet(NO)
     //纵向
     .wVerticalSet(YES);
    
     WMZBannerView *viewOne1 = [[WMZBannerView alloc]initConfigureWithModel:param1];
     [self.view addSubview:viewOne1];
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
