//
//  demoNormal.m
//  WMZBanner
//
//  Created by wmz on 2019/12/16.
//  Copyright © 2019 wmz. All rights reserved.
//

#import "demoNormal.h"
#import "WMZBannerView.h"
@interface demoNormal ()

@end

@implementation demoNormal

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    /*
     *横向
     */
    WMZBannerParam *param =
    BannerParam()
//    .wEventDidScrollSet(^(long contentoffet) {
//        NSLog(@"%ld",contentoffet);
//    })
    .wFrameSet(CGRectMake(10, BannerHeight/6, BannerWitdh-20, BannerHeight/4))
    .wDataSet(@[])
    //开启循环滚动
    .wRepeatSet(YES)
    //设置item的间距
    .wLineSpacingSet(10)
    //开启自动滚动
    .wAutoScrollSet(YES)
    //自动滚动时间
    .wAutoScrollSecondSet(3)
    
    ;
    WMZBannerView *viewOne = [[WMZBannerView alloc]initConfigureWithModel:param];
    [self.view addSubview:viewOne];
    
    //模拟刷新数据
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        param.wDataSet([self getData]);
        [viewOne updateUI];
    });
    
    
    
    /*
     *纵向
     */
    WMZBannerParam *param1 =  BannerParam()
    .wFrameSet(CGRectMake(10, BannerHeight/2, BannerWitdh-20, BannerHeight/4))
    .wDataSet([self getData])
    //开启循环滚动
    .wRepeatSet(YES)
    //开启纵向
    .wVerticalSet(YES);
    WMZBannerView *viewTwo = [[WMZBannerView alloc]initConfigureWithModel:param1];
    [self.view addSubview:viewTwo];
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
