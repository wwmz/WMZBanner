//
//  ViewController.m
//  WMZBanner
//
//  Created by wmz on 2019/9/6.
//  Copyright © 2019 wmz. All rights reserved.
//

#import "ViewController.h"
#import "WMZBannerView.h"
#import "MyCell.h"
@interface ViewController ()
@property(nonatomic,strong)WMZBannerView *viewOne;
@property(nonatomic,strong)WMZBannerView *viewTwo;
@property(nonatomic,strong)WMZBannerView *viewThree;
@property(nonatomic,strong)WMZBannerView *viewFour;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self demoOne];
    [self demoTwo];
    [self demoThree];
    [self demoFour];
}

//所有属性
- (void)demoOne{
    WMZBannerParam *param =
    BannerParam()
    //自定义视图必传
    .wMyCellClassNameSet(@"MyCell")
    .wMyCellSet(^UICollectionViewCell *(NSIndexPath *indexPath, UICollectionView *collectionView, id model, UIImageView *bgImageView) {
        //自定义视图
        MyCell *cell = (MyCell *)[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([MyCell class]) forIndexPath:indexPath];
        [cell.icon sd_setImageWithURL:[NSURL URLWithString:model[@"icon"]] placeholderImage:nil];
        cell.leftText.text = model[@"name"];
        //毛玻璃效果必须实现
        [bgImageView sd_setImageWithURL:[NSURL URLWithString:model[@"icon"]] placeholderImage:nil];
        return cell;
    })
    .wEventClickSet(^(id anyID, NSIndexPath *path) {
        NSLog(@"点击 %@ %@",anyID,path);
    })
    .wMasonrySet(^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(30);
        make.height.mas_equalTo(BannerHeight/5);
    })
    .wImageFillSet(YES)
    .wLineSpacingSet(10)
    .wScaleSet(YES)
    .wEffectSet(YES)
    .wActiveDistanceSet(400)
    .wScaleFactorSet(0.5)
    .wItemSizeSet(CGSizeMake(BannerWitdh*0.5, BannerHeight/5))
    .wContentOffsetXSet(0.5)
    .wSelectIndexSet(2)
    .wRepeatSet(YES)
    .wAutoScrollSecondSet(3)
    .wAutoScrollSet(NO)
    .wPositionSet(BannerCellPositionCenter)
    .wBannerControlSelectColorSet([UIColor whiteColor])
    .wBannerControlColorSet([UIColor cyanColor])
    .wBannerControlImageSet(@"AAA")
    .wBannerControlSelectImageSet(@"BBB")
    .wBannerControlImageSizeSet(CGSizeMake(10, 10))
    .wBannerControlSelectImageSizeSet(CGSizeMake(10, 10))
    .wBannerControlImageRadiusSet(5)
    .wHideBannerControlSet(NO)
    .wCanFingerSlidingSet(YES)
    .wDataSet([self getData])
    ;
    
    self.viewOne = [[WMZBannerView alloc]initConfigureWithModel:param withView:self.view];
    
    //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //        //模拟网络请求
    //        param.wDataSet(@[
    //                         @{@"name":@"自定义文本11",@"icon":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1567762995596&di=fe55b2c249e91b18b5dc9e26cf2f048c&imgtype=0&src=http%3A%2F%2Fimage.diyiyou.com%2Fgame%2F2016%2F09%2F1473325030_8.jpg"},
    //                         @{@"name":@"自定义文本22",@"icon":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1567762995596&di=583eed4742e4e074a22937ebdae24338&imgtype=0&src=http%3A%2F%2Fwww.gamemei.com%2Fbackground%2Fuploads%2F160608%2F24-16060P95125564.jpg"}
    //                         ]);
    //        [banner updateUI];
    //    });
}

//最常用全图banner 无任何效果
- (void)demoTwo{
    WMZBannerParam *param =  BannerParam()
    .wMasonrySet(^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(BannerHeight/4+10);
        make.height.mas_equalTo(BannerHeight/5);
    }).wDataSet([self getData])
    //开启循环滚动
    .wRepeatSet(YES)
    //开启自动滚动
    .wAutoScrollSet(YES)
    //自动滚动时间
    .wAutoScrollSecondSet(3)
    ;
    self.viewTwo = [[WMZBannerView alloc]initConfigureWithModel:param withView:self.view];
}

//天猫精灵样式
- (void)demoThree{
    WMZBannerParam *param =  BannerParam()
    .wMasonrySet(^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(BannerHeight/2+10);
        make.height.mas_equalTo(BannerHeight/5);
    }).wDataSet([self getData])
    //关闭pageControl
    .wHideBannerControlSet(YES)
    //开启缩放
    .wScaleSet(YES)
    //垂直缩放参数
    .wActiveDistanceSet(400)
    //缩放系数
    .wScaleFactorSet(0.5)
    //自定义item的大小
    .wItemSizeSet(CGSizeMake(BannerWitdh*0.7, BannerHeight/5))
    //固定移动的距离
    .wContentOffsetXSet(0.4)
    //循环
    .wRepeatSet(NO)
    //整体左右间距
    .wSectionInsetSet(UIEdgeInsetsMake(0,10, 0, 10))
    
    ;
    self.viewThree = [[WMZBannerView alloc]initConfigureWithModel:param withView:self.view];
}


//
- (void)demoFour{
    WMZBannerParam *param =
    BannerParam()
    //自定义视图必传
    .wMyCellClassNameSet(@"MyCell")
    .wMyCellSet(^UICollectionViewCell *(NSIndexPath *indexPath, UICollectionView *collectionView, id model, UIImageView *bgImageView) {
        //自定义视图
        MyCell *cell = (MyCell *)[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([MyCell class]) forIndexPath:indexPath];
        [cell.icon sd_setImageWithURL:[NSURL URLWithString:model[@"icon"]] placeholderImage:nil];
        cell.leftText.text = model[@"name"];
        //毛玻璃效果必须实现
        [bgImageView sd_setImageWithURL:[NSURL URLWithString:model[@"icon"]] placeholderImage:nil];
        return cell;
    })
    .wMasonrySet(^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(BannerHeight/4*3+10);
        make.height.mas_equalTo(BannerHeight/5);
    })
    .wLineSpacingSet(15)
    .wScaleSet(YES)
    .wActiveDistanceSet(400)
    .wScaleFactorSet(0.5)
    .wItemSizeSet(CGSizeMake(BannerWitdh*0.8, BannerHeight/5))
    .wContentOffsetXSet(0.5)
    .wSelectIndexSet(2)
    .wRepeatSet(YES)
    .wAutoScrollSecondSet(3)
    .wAutoScrollSet(NO)
    .wPositionSet(BannerCellPositionCenter)
    .wBannerControlSelectColorSet([UIColor whiteColor])
    .wBannerControlColorSet([UIColor cyanColor])
    .wDataSet([self getData])
    ;
    
    self.viewFour = [[WMZBannerView alloc]initConfigureWithModel:param withView:self.view];
    
}

- (NSArray*)getData{
    return @[
      @{@"name":@"自定义文本1",@"icon":@"http://www.51pptmoban.com/d/file/2014/01/20/e382d9ad5fe92e73a5defa7b47981e07.jpg"},
      @{@"name":@"自定义文本2",@"icon":@"http://hbimg.b0.upaiyun.com/9fd1b3a78826fc29b997e5bc39180c3b1f8ed3d76b4b-LxIY28_fw658"},
      @{@"name":@"自定义文本3",@"icon":@"http://img.sccnn.com/bimg/337/23662.jpg"},
      @{@"name":@"自定义文本4",@"icon":@"http://pic26.nipic.com/20130118/9356147_134953884000_2.jpg"}
      ];
}

@end
