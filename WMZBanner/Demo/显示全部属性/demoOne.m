//
//  demoOne.m
//  WMZBanner
//
//  Created by wmz on 2019/12/16.
//  Copyright © 2019 wmz. All rights reserved.
//

#import "demoOne.h"
#import "WMZBannerView.h"
#import "MyCell.h"
@interface demoOne ()
@property(nonatomic,strong)WMZBannerView *viewOne;
@property(nonatomic,strong)WMZBannerParam *param;

@end

@implementation demoOne


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn setTitle:@"更新数据" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(updata) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    [btn sizeToFit]; 
    self.navigationItem.rightBarButtonItem = barItem;

    
    BannerWeakSelf(self);
    self.param =
     BannerParam()
    //自定义pageControl的位置
    .wCustomControlSet(^(UIPageControl *pageControl) {
        
    })
    //自定义视图必传
    .wMyCellClassNameSet(@"MyCell")
    .wMyCellSet(^UICollectionViewCell *(NSIndexPath *indexPath, UICollectionView *collectionView, id model, UIImageView *bgImageView,NSArray*dataArr) {
            //自定义视图
        MyCell *cell = (MyCell *)[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([MyCell class]) forIndexPath:indexPath];
        [cell.icon sd_setImageWithURL:[NSURL URLWithString:model[@"icon"]] placeholderImage:nil];
        cell.leftText.text = model[@"name"];
        return cell;
    })
    .wEventClickSet(^(id anyID, NSInteger index) {
        NSLog(@"点击 %@ %ld",anyID,index);
    })
    .wEventCenterClickSet(^(id anyID, NSInteger index,BOOL isCenter,UICollectionViewCell *cell) {
        NSLog(@"判断居中点击");
    })
    .wEventScrollEndSet( ^(id anyID, NSInteger index, BOOL isCenter,UICollectionViewCell *cell) {
        //毛玻璃效果外部调整
         BannerStrongSelf(weakObject)
         [strongObject.viewOne.bgImgView sd_setImageWithURL:[NSURL URLWithString:anyID[@"icon"]] placeholderImage:nil];
    })
    //图片对应的key值
    .wDataParamIconNameSet(@"icon")
    .wFrameSet(CGRectMake(0, BannerHeight/3, BannerWitdh, BannerHeight/3))
    //图片铺满
    .wImageFillSet(YES)
    //item间距
    .wLineSpacingSet(10)
    //开启缩放
    .wScaleSet(YES)
    //毛玻璃效果
    .wEffectSet(YES)
    //毛玻璃背景的高度系数
    .wEffectHeightSet(1)
    //缩放垂直间距
    .wActiveDistanceSet(400)
    //缩放系数
    .wScaleFactorSet(0.5)
    //item的size
    .wItemSizeSet(CGSizeMake(BannerWitdh*0.5, BannerHeight/3))
    //滑动固定偏移距离 itemSize.width*倍数
    .wContentOffsetXSet(0.5)
    //默认滑动到第index个
    .wSelectIndexSet(2)
    //循环滚动
    .wRepeatSet(YES)
    //自动滚动时间
    .wAutoScrollSecondSet(3)
    //自动滚动
    .wAutoScrollSet(YES)
    //卡片叠加模式
    .wCardOverLapSet(NO)
    //cell的位置
    .wPositionSet(BannerCellPositionCenter)
    //分页按钮的选中的颜色
    .wBannerControlSelectColorSet([UIColor whiteColor])
    //分页按钮的未选中的颜色
    .wBannerControlColorSet([UIColor cyanColor])
    //分页按钮的未选中的图片
    .wBannerControlImageSet(@"slideCirclePoint")
    //分页按钮的选中的图片
    .wBannerControlSelectImageSet(@"slidePoint")
    //分页按钮的未选中图片的size
    .wBannerControlImageSizeSet(CGSizeMake(10, 10))
    //分页按钮选中的图片的size
    .wBannerControlSelectImageSizeSet(CGSizeMake(15, 10))
    //分页按钮的圆角
    .wBannerControlImageRadiusSet(5)
    //自定义圆点间距
    .wBannerControlSelectMarginSet(3)
    //隐藏分页按钮
    .wHideBannerControlSet(NO)
    //能否拖动
    .wCanFingerSlidingSet(YES)
    //整体缩小
    .wScreenScaleSet(1)
    //左右半透明 中间不透明
    .wAlphaSet(0.5)
    //开启跑马灯效果
    .wMarqueeSet(NO)
    //跑马灯速度
    .wMarqueeRateSet(5)
    //开启纵向
    .wVerticalSet(NO)
    //分页按钮的位置
    .wBannerControlPositionSet(BannerControlCenter)
    //左右偏移 让第一个和最后一个可以居中
    .wSectionInsetSet(UIEdgeInsetsMake(0,BannerWitdh*0.25, 0, BannerWitdh*0.25))
    //数据源
    .wDataSet([self getData])
    ;
    
    self.viewOne = [[WMZBannerView alloc]initConfigureWithModel:self.param withView:self.view];
}

//更新数据
- (void)updata{
    self.param.wDataSet(@[
@{@"name":@"自定义文本11",@"icon":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1576501052334&di=47c55150e39ee4e13f52c2a2d60e3249&imgtype=0&src=http%3A%2F%2Fn.sinaimg.cn%2Fsinacn%2Fw800h450%2F20171207%2F9641-fypnsin6729109.jpg"},
@{@"name":@"自定义文本22",@"icon":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1576501100534&di=59ea2b526bd9050cd0e606be63ca1235&imgtype=0&src=http%3A%2F%2Fn.sinaimg.cn%2Fsinacn20110%2F82%2Fw1080h602%2F20191105%2F3093-ihyxcrp3886394.jpg"}
    ]);
    [self.viewOne updateUI];
}

- (NSArray*)getData{
    return @[
      @{@"name":@"自定义文本1",@"icon":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1576744105022&di=f4aadd0b85f93309a4629c998773ae83&imgtype=0&src=http%3A%2F%2Fimg.pconline.com.cn%2Fimages%2Fupload%2Fupc%2Ftx%2Fwallpaper%2F1206%2F07%2Fc0%2F11909864_1339034191111.jpg"},
      @{@"name":@"自定义文本2",@"icon":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1576744105022&di=f06819b43c8032d203642874d1893f3d&imgtype=0&src=http%3A%2F%2Fi2.sinaimg.cn%2Fent%2Fs%2Fm%2Fp%2F2009-06-25%2FU1326P28T3D2580888F326DT20090625072056.jpg"},
      @{@"name":@"自定义文本3",@"icon":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1577338893&di=189401ebacb9704d18f6ab02b7336923&imgtype=jpg&er=1&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fblog%2F201308%2F05%2F20130805105309_5E2zE.jpeg"},
      @{@"name":@"自定义文本4",@"icon":@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1576744174216&di=36ffb42bf8757df08455b34c6b7d66c5&imgtype=0&src=http%3A%2F%2Fwww.7dapei.com%2Fimages%2F201203c%2F119.3.jpg"}
      ];
}
- (void)dealloc{
    
}
@end
