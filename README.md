# WMZBanner - 最好用的轻量级轮播图+卡片样式+自定义样式

演示
==============
![Untitled.gif](https://upload-images.jianshu.io/upload_images/9163368-165e4765ee266cc2.gif?imageMogr2/auto-orient/strip)



特性
==============
- 链式语法 结构优雅
- 支持常规轮播图样式
- 支持卡片式样式
- 支持自定义轮播图cell
- 支持自定义图片的偏移距离
- 支持自定义pagecontrol
- 支持循环滚动,支持自动滚动
- 样式均可自定义
- 支持网络图片和本地图片混合使用


用法
==============

### 默认模式

主要适用于普通样式的情况下使用
 
直观 清晰, 编码时可随初始化控件编写完成, 不影响编码思路.
 
	  WMZBannerParam *param =  BannerParam()
    .wMasonrySet(^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(BannerHeight/4+10);
        make.height.mas_equalTo(BannerHeight/5);
    })
    //传入数据
    .wDataSet([self getData])
    //开启循环滚动
    .wRepeatSet(YES)
    //开启自动滚动
    .wAutoScrollSet(YES)
    //自动滚动时间
    .wAutoScrollSecondSet(3)
    ;
    self.viewTwo = [[WMZBannerView alloc]initConfigureWithModel:param withView:self.view];


### 卡片模式
	
    BannerParam()
    .wMasonrySet(^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(BannerHeight/4*3+10);
        make.height.mas_equalTo(BannerHeight/5);
    })
    //item之间的间距
    .wLineSpacingSet(15)
    //开启缩放效果 
    .wScaleSet(YES)
    //缩放垂直系数
    .wActiveDistanceSet(400)
    //缩放系数
    .wScaleFactorSet(0.5)
    //item的size
    .wItemSizeSet(CGSizeMake(BannerWitdh*0.8, BannerHeight/5))
    //固定移动的距离 size*倍数
    .wContentOffsetXSet(0.5)
    //默认选中
    .wSelectIndexSet(2)
    .wRepeatSet(YES)
    .wAutoScrollSecondSet(3)
    .wAutoScrollSet(NO)
    //item中心位置
    .wPositionSet(BannerCellPositionCenter)
    .wDataSet([self getData]);
    
##### 天猫精灵样式
##### 大概效果图

![C820397D-CF3D-49A5-90E8-6F179F0D4EBF.png](https://upload-images.jianshu.io/upload_images/9163368-86301db3b9ecce99.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

     BannerParam()
    .wMasonrySet(^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(BannerHeight/2+10);
        make.height.mas_equalTo(BannerHeight/5);
    })
    .wDataSet([self getData])
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
    .wRepeatSet(YES)
    //item的间距
    .wLineSpacingSet(10)
    
##### 自定义cell 
##### 传入一个继承UICollectionViewCell的类

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
    
##### 更新UI
-(void)updateUI;
改变.wDataSet(@[]),然后调用updateUI()实例方法即可

##### 其他可配置的全部参数说明
    布局方式 autoLayout 必传 和frame 二选一
    wMasonry
    //布局方式 frame  必传 和autoLayout 二选一
    wFrame
    数据源 必传
    wData
    开启缩放 default NO
    wScale
    背景毛玻璃效果 default NO
    wEffect
    缩放系数 数值越大缩放越大 default 0.5
    wScaleFactor
    垂直缩放 数值越大缩放越小 default 400
    wActiveDistance
    item的size default 视图的宽高 item的width最小为父视图的一半 (为了保证同屏最多显示3个 减少不必要的bug)
    wItemSize
    item的之间的间距 default 0
    wLineSpacing
    滑动的时候偏移的距离 以倍数计算 default 0.5 正中间
    wContentOffsetX
    左右相邻item的中心点 default BannerCellPositionCenter
    wPosition
    图片不变形铺满 默认 YES
    wImageFill
    占位图片 默认 -
    wPlaceholderImage
    开启无线滚动 default NO
    wRepeat
    开启自动滚动 default NO
    wAutoScroll
    自动滚动间隔时间 default 3.0f
    wAutoScrollSecond
    默认移动到第几个 default 0
    wSelectIndex
    自定义cell内容 默认是Collectioncell类
    wMyCell
    自定义cell的类名 自定义视图必传 不然会crash
    wMyCellClassName
    点击方法
    wEventClick
    隐藏pageControl default NO
    wHideBannerControl
    是否允许手势滑动 default YES
    wCanFingerSliding
    系统的圆点颜色  default  ffffff
    wBannerControlColor
    系统的圆点选中颜色  default  orange
    wBannerControlSelectColor
    自定义安全的圆点图标  default -
    wBannerControlImage
    自定义安全的选中圆点图标  default -
    wBannerControlSelectImage
    自定义安全的圆点图片圆角 default ImageSize/2
    wBannerControlImageRadius
    自定义安全的圆点图标的size  default (5,5)
    wBannerControlImageSize
    自定义安全的选中圆点图标的size (10,5)
    wBannerControlSelectImageSize

### 依赖
Masonry和SDWebImage

安装
==============

### CocoaPods
1. 将 cocoapods 更新至最新版本.
2. 在 Podfile 中添加 `pod 'WMZBanner'`。
3. 执行 `pod install` 或 `pod update`。
4. 导入 #import "WMZBannerView.h"。

### 手动安装

1. 下载 WMZBanner 文件夹内的所有内容。
2. 将 WMZBanner 内的源文件添加(拖放)到你的工程。
3. 导入 #import "WMZBannerView.h"

系统要求
==============
该库最低支持 `iOS 9.0` 和 `Xcode 9.0`。



许可证
==============
LEETheme 使用 MIT 许可证，详情见 [LICENSE](LICENSE) 文件。


个人主页
==============
[我的简书](https://www.jianshu.com/u/17b9dd398782)
