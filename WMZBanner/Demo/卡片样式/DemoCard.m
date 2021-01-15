//
//  DemoCard.m
//  WMZBanner
//
//  Created by wmz on 2019/12/17.
//  Copyright © 2019 wmz. All rights reserved.
//

#import "DemoCard.h"
#import "WMZBannerView.h"
#import "MyCell.h"
@interface DemoCard ()

@end

@implementation DemoCard

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self demoOne];
    [self demoTwo];
    [self demoThree];
}

- (void)demoOne{
    WMZBannerParam *param =
    BannerParam()
    //自定义视图必传
    .wMyCellClassNameSet(@"MyCell")
    .wMyCellSet(^UICollectionViewCell *(NSIndexPath *indexPath, UICollectionView *collectionView, id model, UIImageView *bgImageView,NSArray*dataArr) {
               //自定义视图
        MyCell *cell = (MyCell *)[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([MyCell class]) forIndexPath:indexPath];
        cell.leftText.text = model[@"name"];
        [cell.icon sd_setImageWithURL:[NSURL URLWithString:model[@"icon"]] placeholderImage:nil];
        return cell;
    })
    .wFrameSet(CGRectMake(0, 100, BannerWitdh, BannerHeight*0.2))
    .wDataSet([self getData])
    //关闭pageControl
    .wHideBannerControlSet(YES)
    //开启缩放
    .wScaleSet(YES)
    //自定义item的大小
    .wItemSizeSet(CGSizeMake(BannerWitdh*0.55, BannerHeight*0.2))
    //固定移动的距离
    .wContentOffsetXSet(0.5)
    //循环
    .wRepeatSet(NO)
    //中间cell层级最上面
    .wZindexSet(YES)
    //整体左右间距  设置为size.width的一半 让最后一个可以居中
    .wSectionInsetSet(UIEdgeInsetsMake(0,50, 0, BannerWitdh*0.55*0.3))
    //间距
    .wLineSpacingSet(10)
    //开启背景毛玻璃
    .wEffectSet(YES)
    //点击左右居中
    .wClickCenterSet(YES)
    ;
    WMZBannerView *bannerView = [[WMZBannerView alloc]initConfigureWithModel:param];
    [self.view addSubview:bannerView];
}

- (void)demoTwo{
    WMZBannerParam *param =
    BannerParam()
   //自定义视图必传
   .wMyCellClassNameSet(@"MyCell")
   .wMyCellSet(^UICollectionViewCell *(NSIndexPath *indexPath, UICollectionView *collectionView, id model, UIImageView *bgImageView,NSArray*dataArr) {
              //自定义视图
       MyCell *cell = (MyCell *)[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([MyCell class]) forIndexPath:indexPath];
       cell.leftText.text = model[@"name"];
       [cell.icon sd_setImageWithURL:[NSURL URLWithString:model[@"icon"]] placeholderImage:nil];
       return cell;
   })
   .wFrameSet(CGRectMake(0, BannerHeight*0.4, BannerWitdh, BannerHeight*0.2))
   .wDataSet([self getData])
   //关闭pageControl
   .wHideBannerControlSet(YES)
   //自定义item的大小
   .wItemSizeSet(CGSizeMake(BannerWitdh*0.55, BannerHeight*0.2))
   //固定移动的距离
   .wContentOffsetXSet(0.5)
//   //自动滚动
   .wAutoScrollSet(YES)
    //循环
    .wRepeatSet(YES)
   //整体左右间距  设置为size.width的一半 让最后一个可以居中
   .wSectionInsetSet(UIEdgeInsetsMake(0,20, 0, BannerWitdh*0.55*0.3))
   //间距
   .wLineSpacingSet(20)
   ;
   WMZBannerView *bannerView = [[WMZBannerView alloc]initConfigureWithModel:param];
   [self.view addSubview:bannerView];
}

- (void)demoThree{
     WMZBannerParam *param =
     BannerParam()
    //自定义视图必传
    .wMyCellClassNameSet(@"MyCell")
    .wMyCellSet(^UICollectionViewCell *(NSIndexPath *indexPath, UICollectionView *collectionView, id model, UIImageView *bgImageView,NSArray*dataArr) {
               //自定义视图
        MyCell *cell = (MyCell *)[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([MyCell class]) forIndexPath:indexPath];
        cell.leftText.text = model[@"name"];
        [cell.icon sd_setImageWithURL:[NSURL URLWithString:model[@"icon"]] placeholderImage:nil];
        return cell;
    })
    .wFrameSet(CGRectMake(0, BannerHeight*0.7, BannerWitdh, BannerHeight*0.2))
    .wDataSet([self getData])
    //关闭pageControl
    .wHideBannerControlSet(YES)
    //开启缩放
    .wScaleSet(YES)
    //自定义item的大小
    .wItemSizeSet(CGSizeMake(BannerWitdh*0.2-10, BannerHeight*0.2))
    //固定移动的距离
    .wContentOffsetXSet(0.5)
     //循环
     .wRepeatSet(YES)
    //整体左右间距  设置为size.width的一半 让最后一个可以居中
    .wSectionInsetSet(UIEdgeInsetsMake(0,10, 0, BannerWitdh*0.55*0.3))
    //间距
    .wLineSpacingSet(10)
    ;
    WMZBannerView *bannerView = [[WMZBannerView alloc]initConfigureWithModel:param];
    [self.view addSubview:bannerView];
}
- (NSArray*)getData{
    return @[
      @{@"name":@"自定义文本1",@"icon":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1576744105022&di=f4aadd0b85f93309a4629c998773ae83&imgtype=0&src=http%3A%2F%2Fimg.pconline.com.cn%2Fimages%2Fupload%2Fupc%2Ftx%2Fwallpaper%2F1206%2F07%2Fc0%2F11909864_1339034191111.jpg"},
      @{@"name":@"自定义文本2",@"icon":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1576744105022&di=f06819b43c8032d203642874d1893f3d&imgtype=0&src=http%3A%2F%2Fi2.sinaimg.cn%2Fent%2Fs%2Fm%2Fp%2F2009-06-25%2FU1326P28T3D2580888F326DT20090625072056.jpg"},
      @{@"name":@"自定义文本3",@"icon":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1577338893&di=189401ebacb9704d18f6ab02b7336923&imgtype=jpg&er=1&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fblog%2F201308%2F05%2F20130805105309_5E2zE.jpeg"},
      @{@"name":@"自定义文本4",@"icon":@"https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=3425860897,3737508983&fm=26&gp=0.jpg"}
      ];
}
- (void)dealloc{
    
}
@end
