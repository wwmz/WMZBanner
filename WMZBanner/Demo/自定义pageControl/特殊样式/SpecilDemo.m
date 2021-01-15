//
//  SpecilDemo.m
//  WMZBanner
//
//  Created by wmz on 2020/4/15.
//  Copyright © 2020 wmz. All rights reserved.
//

#import "SpecilDemo.h"
#import "WMZBannerView.h"
@interface SpecilDemo ()

@end

@implementation SpecilDemo

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self styleOne];
}


- (void)styleOne{
    WMZBannerParam *param =  BannerParam()
    .wFrameSet(CGRectMake(10,100, BannerWitdh-20, BannerHeight*0.25))
    .wItemSizeSet(CGSizeMake(BannerWitdh-20, BannerHeight*0.23))
    .wDataSet([self getData])
    //自定义下划线
    .wSpecialCustumLineSet(^(UIView *line) {
        line.frame = CGRectMake(0, 0, 100, 3);
        line.backgroundColor = [UIColor redColor];
    })
    .wHideBannerControlSet(YES)
    .wSpecialStyleSet(SpecialStyleLine);
    WMZBannerView *viewOne = [[WMZBannerView alloc]initConfigureWithModel:param];
    [self.view addSubview:viewOne];
    
}

- (NSArray*)getData{
    return @[
      @{@"name":@"第0个",@"icon":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1576744105022&di=f4aadd0b85f93309a4629c998773ae83&imgtype=0&src=http%3A%2F%2Fimg.pconline.com.cn%2Fimages%2Fupload%2Fupc%2Ftx%2Fwallpaper%2F1206%2F07%2Fc0%2F11909864_1339034191111.jpg"},
      @{@"name":@"第1个",@"icon":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1576744105022&di=f06819b43c8032d203642874d1893f3d&imgtype=0&src=http%3A%2F%2Fi2.sinaimg.cn%2Fent%2Fs%2Fm%2Fp%2F2009-06-25%2FU1326P28T3D2580888F326DT20090625072056.jpg"},
      @{@"name":@"第2个",@"icon":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1577338893&di=189401ebacb9704d18f6ab02b7336923&imgtype=jpg&er=1&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fblog%2F201308%2F05%2F20130805105309_5E2zE.jpeg"},
      @{@"name":@"第3个",@"icon":@"https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=3425860897,3737508983&fm=26&gp=0.jpg"}

      ];
}

@end
