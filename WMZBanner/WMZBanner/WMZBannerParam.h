//
//  WMZBannerParam.h
//  WMZBanner
//
//  Created by wmz on 2019/9/6.
//  Copyright © 2019 wmz. All rights reserved.
//

#import "WMZBannerConfig.h"
NS_ASSUME_NONNULL_BEGIN

@interface WMZBannerParam : NSObject
/* =========================================Attributes==========================================*/

//布局方式 frame  必传
WMZBannerPropStatementAndPropSetFuncStatement(assign, WMZBannerParam, CGRect,               wFrame)
//数据源 必传
WMZBannerPropStatementAndPropSetFuncStatement(strong, WMZBannerParam, NSArray*,             wData)
//特殊样式 default 无
WMZBannerPropStatementAndPropSetFuncStatement(assign, WMZBannerParam, SpecialStyle,                 wSpecialStyle)

//淡入淡出 default NO
WMZBannerPropStatementAndPropSetFuncStatement(assign, WMZBannerParam, BOOL,                 wFadeOpen)
//开启缩放 default NO
WMZBannerPropStatementAndPropSetFuncStatement(assign, WMZBannerParam, BOOL,                 wScale)
//开启卡片重叠模式 default NO
WMZBannerPropStatementAndPropSetFuncStatement(assign, WMZBannerParam, BOOL,                 wCardOverLap)
//卡片重叠模式开启偏移透明度变化 default NO
WMZBannerPropStatementAndPropSetFuncStatement(assign, WMZBannerParam, BOOL,                 wCardOverAlphaOpen)
//叠加模式透明度最小值 defalt 0.1
WMZBannerPropStatementAndPropSetFuncStatement(assign, WMZBannerParam, CGFloat,              wCardOverMinAlpha)
//卡片重叠显示个数 default 4
WMZBannerPropStatementAndPropSetFuncStatement(assign, WMZBannerParam, NSInteger,            wCardOverLapCount)
//背景毛玻璃效果 default NO
WMZBannerPropStatementAndPropSetFuncStatement(assign, WMZBannerParam, BOOL,                 wEffect)
//隐藏pageControl default NO
WMZBannerPropStatementAndPropSetFuncStatement(assign, WMZBannerParam, BOOL,                 wHideBannerControl)
//是否允许手势滑动 default YES
WMZBannerPropStatementAndPropSetFuncStatement(assign, WMZBannerParam, BOOL,                 wCanFingerSliding)
//图片不变形铺满 默认 YES
WMZBannerPropStatementAndPropSetFuncStatement(assign, WMZBannerParam, BOOL,                 wImageFill)
//开启无线滚动 default NO
WMZBannerPropStatementAndPropSetFuncStatement(assign, WMZBannerParam, BOOL,                 wRepeat)
//开启自动滚动 default NO
WMZBannerPropStatementAndPropSetFuncStatement(assign, WMZBannerParam, BOOL,                 wAutoScroll)
//纵向(cell全屏的时候有效) default NO
WMZBannerPropStatementAndPropSetFuncStatement(assign, WMZBannerParam, BOOL,                 wVertical)
//跑马灯(文字效果) default NO
WMZBannerPropStatementAndPropSetFuncStatement(assign, WMZBannerParam, BOOL,                 wMarquee)
//点击左右居中
WMZBannerPropStatementAndPropSetFuncStatement(assign, WMZBannerParam, BOOL,                 wClickCenter)
//中间视图放最上面 default NO
WMZBannerPropStatementAndPropSetFuncStatement(assign, WMZBannerParam, BOOL,                 wZindex)
//整体间距 默认UIEdgeInsetsMake(0,0, 0, 0)
WMZBannerPropStatementAndPropSetFuncStatement(assign, WMZBannerParam, UIEdgeInsets,         wSectionInset)
//自定义图片圆角 default 5
WMZBannerPropStatementAndPropSetFuncStatement(assign, WMZBannerParam, CGFloat,              wCustomImageRadio)
//整体视图缩放系数 default 1
WMZBannerPropStatementAndPropSetFuncStatement(assign, WMZBannerParam, CGFloat,              wScreenScale)
//毛玻璃背景的高度 (视图的高度*倍数) default 1 范围0~1
WMZBannerPropStatementAndPropSetFuncStatement(assign, WMZBannerParam, CGFloat,              wEffectHeight)
//缩放系数 数值越大缩放越大 default 0.5 卡片叠加效果时默认为0.8
WMZBannerPropStatementAndPropSetFuncStatement(assign, WMZBannerParam, CGFloat,              wScaleFactor)
//左右的透明度 default 1
WMZBannerPropStatementAndPropSetFuncStatement(assign, WMZBannerParam, CGFloat,              wAlpha)
//垂直缩放 数值越大缩放越小 default 400
WMZBannerPropStatementAndPropSetFuncStatement(assign, WMZBannerParam, CGFloat,              wActiveDistance)
//item的size default 视图的宽高 item的width最小为父视图的一半 (为了保证同屏最多显示3个 减少不必要的bug)
WMZBannerPropStatementAndPropSetFuncStatement(assign, WMZBannerParam, CGSize,               wItemSize)
//item的之间的间距 default 0
WMZBannerPropStatementAndPropSetFuncStatement(assign, WMZBannerParam, int,                  wLineSpacing)
//滑动的时候偏移的距离 以倍数计算 default 0.5 正中间
WMZBannerPropStatementAndPropSetFuncStatement(assign, WMZBannerParam, CGFloat,              wContentOffsetX)
//左右相邻item的中心点 default BannerCellPositionCenter
WMZBannerPropStatementAndPropSetFuncStatement(assign, WMZBannerParam, BannerCellPosition,   wPosition)
//占位图片 默认 -
WMZBannerPropStatementAndPropSetFuncStatement(copy,   WMZBannerParam, NSString*,            wPlaceholderImage)
//数据源的图片字段 默认 icon
WMZBannerPropStatementAndPropSetFuncStatement(copy,   WMZBannerParam, NSString*,            wDataParamIconName)
//滚动减速时间 default UIScrollViewDecelerationRateFast
WMZBannerPropStatementAndPropSetFuncStatement(assign, WMZBannerParam, UIScrollViewDecelerationRate,wDecelerationRate)
//自动滚动间隔时间 default 3.0f
WMZBannerPropStatementAndPropSetFuncStatement(assign, WMZBannerParam, CGFloat,              wAutoScrollSecond)
//默认移动到第几个 default 0
WMZBannerPropStatementAndPropSetFuncStatement(assign, WMZBannerParam, NSInteger,            wSelectIndex)
//自定义cell内容 默认是Collectioncell类
WMZBannerPropStatementAndPropSetFuncStatement(copy,   WMZBannerParam, BannerCellCallBlock,  wMyCell)
//特殊样式SpecialLine 自定义下划线
WMZBannerPropStatementAndPropSetFuncStatement(copy,   WMZBannerParam, BannerSpecialLine,                  wSpecialCustumLine)
//自定义cell的类名 自定义视图必传 不然会crash
WMZBannerPropStatementAndPropSetFuncStatement(copy,   WMZBannerParam, NSString*,            wMyCellClassName)
//自定义cell的类名 自定义视图必传 不然会crash 和上面的属性wMyCellClassName 二选一 此属性可以传数组
WMZBannerPropStatementAndPropSetFuncStatement(strong, WMZBannerParam, id,                   wMyCellClassNames)
//自定义xib cell的类名 自定义视图必传 不然会crash
WMZBannerPropStatementAndPropSetFuncStatement(strong, WMZBannerParam, id,                   wXibCellClassNames)
//系统的圆点颜色  default  ffffff
WMZBannerPropStatementAndPropSetFuncStatement(strong, WMZBannerParam, UIColor*,             wBannerControlColor)
//系统的圆点选中颜色  default  orange
WMZBannerPropStatementAndPropSetFuncStatement(strong, WMZBannerParam, UIColor*,             wBannerControlSelectColor)
//自定义安全的圆点图标  default -
WMZBannerPropStatementAndPropSetFuncStatement(copy,   WMZBannerParam, NSString*,            wBannerControlImage)
//自定义安全的选中圆点图标  default -
WMZBannerPropStatementAndPropSetFuncStatement(copy,   WMZBannerParam, NSString*,            wBannerControlSelectImage)
//自定义安全的圆点图片圆角 default ImageSize/2
WMZBannerPropStatementAndPropSetFuncStatement(assign, WMZBannerParam, CGFloat,              wBannerControlImageRadius)
//自定义安全的圆点图标的size  default (5,5)
WMZBannerPropStatementAndPropSetFuncStatement(assign, WMZBannerParam, CGSize,               wBannerControlImageSize)
//自定义安全的选中圆点图标的size (10,5)
WMZBannerPropStatementAndPropSetFuncStatement(assign, WMZBannerParam, CGSize,               wBannerControlSelectImageSize)
//自定义圆点的间距 default 3
WMZBannerPropStatementAndPropSetFuncStatement(assign, WMZBannerParam, CGFloat,              wBannerControlSelectMargin)
//自定义pageControl
WMZBannerPropStatementAndPropSetFuncStatement(copy,   WMZBannerParam, BannerPageControl,             wCustomControl)
//pageControl的位置 default BannerControlCenter
WMZBannerPropStatementAndPropSetFuncStatement(assign, WMZBannerParam, BannerControlPosition,wBannerControlPosition)
//跑马灯文字颜色  default  red
WMZBannerPropStatementAndPropSetFuncStatement(strong, WMZBannerParam, UIColor*,             wMarqueeTextColor)
//跑马灯速度  default  0.5
WMZBannerPropStatementAndPropSetFuncStatement(assign, WMZBannerParam, CGFloat,              wMarqueeRate)
/* =========================================Attributes==========================================*/

/* =========================================Events==============================================*/
WMZBannerParam * BannerParam(void);
//点击方法
WMZBannerPropStatementAndPropSetFuncStatement(copy,   WMZBannerParam, BannerClickBlock,     wEventClick)
//点击方法 可获取居中cell
WMZBannerPropStatementAndPropSetFuncStatement(copy,   WMZBannerParam, BannerCenterClickBlock,wEventCenterClick)
//每次滚动结束都会调用 最好是关闭自动滚动的场景使用
WMZBannerPropStatementAndPropSetFuncStatement(copy,   WMZBannerParam, BannerScrollEndBlock, wEventScrollEnd)
//正在滚动
WMZBannerPropStatementAndPropSetFuncStatement(copy,   WMZBannerParam, BannerScrollBlock,    wEventDidScroll)
/* =========================================Events==============================================*/

/* =========================================custom==============================================*/
@property(nonatomic,assign)NSInteger myCurrentPath;

@property(nonatomic,assign)NSInteger overFactPath;
/* =========================================custom==============================================*/

@end

NS_ASSUME_NONNULL_END
