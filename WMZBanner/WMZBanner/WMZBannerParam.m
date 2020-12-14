//
//  WMZBannerParam.m
//  WMZBanner
//
//  Created by wmz on 2019/9/6.
//  Copyright © 2019 wmz. All rights reserved.
//

#import "WMZBannerParam.h"

@implementation WMZBannerParam

WMZBannerPropSetFuncImplementation(WMZBannerParam, CGRect,                        wFrame)
WMZBannerPropSetFuncImplementation(WMZBannerParam, NSArray*,                      wData)
WMZBannerPropSetFuncImplementation(WMZBannerParam, CGFloat,                       wScaleFactor)
WMZBannerPropSetFuncImplementation(WMZBannerParam, CGFloat,                       wCardOverMinAlpha)
WMZBannerPropSetFuncImplementation(WMZBannerParam, BOOL,                          wCardOverAlphaOpen)
WMZBannerPropSetFuncImplementation(WMZBannerParam, BOOL,                          wFadeOpen)
WMZBannerPropSetFuncImplementation(WMZBannerParam, BOOL,                          wEffect)
WMZBannerPropSetFuncImplementation(WMZBannerParam, BOOL,                          wVertical)
WMZBannerPropSetFuncImplementation(WMZBannerParam, BOOL,                          wImageFill)
WMZBannerPropSetFuncImplementation(WMZBannerParam, BOOL,                          wScale)
WMZBannerPropSetFuncImplementation(WMZBannerParam, BOOL,                          wRepeat)
WMZBannerPropSetFuncImplementation(WMZBannerParam, BOOL,                          wAutoScroll)
WMZBannerPropSetFuncImplementation(WMZBannerParam, BOOL,                          wHideBannerControl)
WMZBannerPropSetFuncImplementation(WMZBannerParam, BOOL,                          wCanFingerSliding)
WMZBannerPropSetFuncImplementation(WMZBannerParam, BOOL,                          wMarquee)
WMZBannerPropSetFuncImplementation(WMZBannerParam, BOOL,                          wCardOverLap)
WMZBannerPropSetFuncImplementation(WMZBannerParam, BOOL,                          wZindex)
WMZBannerPropSetFuncImplementation(WMZBannerParam, BOOL,                          wClickCenter)
WMZBannerPropSetFuncImplementation(WMZBannerParam, NSInteger,                     wCardOverLapCount)
WMZBannerPropSetFuncImplementation(WMZBannerParam, CGFloat,                       wActiveDistance)
WMZBannerPropSetFuncImplementation(WMZBannerParam, CGSize,                        wItemSize)
WMZBannerPropSetFuncImplementation(WMZBannerParam, int,                           wLineSpacing)
WMZBannerPropSetFuncImplementation(WMZBannerParam, CGFloat,                       wEffectHeight)
WMZBannerPropSetFuncImplementation(WMZBannerParam, CGFloat,                       wContentOffsetX)
WMZBannerPropSetFuncImplementation(WMZBannerParam, CGFloat,                       wScreenScale)
WMZBannerPropSetFuncImplementation(WMZBannerParam, BannerCellPosition,            wPosition)
WMZBannerPropSetFuncImplementation(WMZBannerParam, SpecialStyle,                  wSpecialStyle)
WMZBannerPropSetFuncImplementation(WMZBannerParam, NSString*,                     wPlaceholderImage)
WMZBannerPropSetFuncImplementation(WMZBannerParam, NSInteger,                     wSelectIndex)
WMZBannerPropSetFuncImplementation(WMZBannerParam, NSString*,                     wMyCellClassName)
WMZBannerPropSetFuncImplementation(WMZBannerParam, BannerCellCallBlock,           wMyCell)
WMZBannerPropSetFuncImplementation(WMZBannerParam, BannerClickBlock,              wEventClick)
WMZBannerPropSetFuncImplementation(WMZBannerParam, BannerScrollEndBlock,          wEventScrollEnd)
WMZBannerPropSetFuncImplementation(WMZBannerParam, BannerCenterClickBlock,        wEventCenterClick)
WMZBannerPropSetFuncImplementation(WMZBannerParam, BannerScrollBlock,             wEventDidScroll)
WMZBannerPropSetFuncImplementation(WMZBannerParam, UIColor*,                      wBannerControlColor)
WMZBannerPropSetFuncImplementation(WMZBannerParam, UIColor*,                      wBannerControlSelectColor)
WMZBannerPropSetFuncImplementation(WMZBannerParam, NSString*,                     wBannerControlImage)
WMZBannerPropSetFuncImplementation(WMZBannerParam, NSString*,                     wDataParamIconName)
WMZBannerPropSetFuncImplementation(WMZBannerParam, NSString*,                     wBannerControlSelectImage)
WMZBannerPropSetFuncImplementation(WMZBannerParam, CGSize,                        wBannerControlImageSize)
WMZBannerPropSetFuncImplementation(WMZBannerParam, CGSize,                        wBannerControlSelectImageSize)
WMZBannerPropSetFuncImplementation(WMZBannerParam, CGFloat,                       wAutoScrollSecond)
WMZBannerPropSetFuncImplementation(WMZBannerParam, CGFloat,                       wAlpha)
WMZBannerPropSetFuncImplementation(WMZBannerParam, CGFloat,                       wBannerControlImageRadius)
WMZBannerPropSetFuncImplementation(WMZBannerParam, UIEdgeInsets,                  wSectionInset)
WMZBannerPropSetFuncImplementation(WMZBannerParam, UIScrollViewDecelerationRate,  wDecelerationRate)
WMZBannerPropSetFuncImplementation(WMZBannerParam, BannerControlPosition,         wBannerControlPosition)
WMZBannerPropSetFuncImplementation(WMZBannerParam, UIColor*,                      wMarqueeTextColor)
WMZBannerPropSetFuncImplementation(WMZBannerParam, BannerPageControl,             wCustomControl)
WMZBannerPropSetFuncImplementation(WMZBannerParam, BannerSpecialLine,             wSpecialCustumLine)
WMZBannerPropSetFuncImplementation(WMZBannerParam, CGFloat,                       wBannerControlSelectMargin)
WMZBannerPropSetFuncImplementation(WMZBannerParam, CGFloat,                       wMarqueeRate)
WMZBannerPropSetFuncImplementation(WMZBannerParam, CGFloat,                       wCustomImageRadio)
WMZBannerPropSetFuncImplementation(WMZBannerParam, id,                            wMyCellClassNames)
WMZBannerPropSetFuncImplementation(WMZBannerParam, id,                            wXibCellClassNames)
WMZBannerParam * BannerParam(void){
    return  [WMZBannerParam new];
}

- (instancetype)init{
    if (self = [super init]) {
        _wAlpha = 1;
        _wScaleFactor = 0.5f;
        _wLineSpacing = 0.0f;
        _wContentOffsetX = 0.5f;
        _wAutoScrollSecond = 3.0f;
        _wPosition = BannerCellPositionCenter;
        _wActiveDistance = 400.0f;
        _wScale = NO;
        _wRepeat = NO;
        _wSelectIndex = 0;
        _wImageFill = YES;
        _wBannerControlColor = [UIColor whiteColor];
        _wBannerControlSelectColor = [UIColor orangeColor];
        _wBannerControlImageSize = CGSizeMake(10, 10);
        _wBannerControlSelectImageSize = CGSizeMake(10, 10);
        _wCanFingerSliding = YES;
        _wSectionInset = UIEdgeInsetsMake(0,0, 0, 0);
        _wDecelerationRate = 0.1;
        _wScreenScale = 1;
        _wMarqueeTextColor = [UIColor redColor];
        _wEffectHeight = 1;
        _wDataParamIconName = @"icon";
        _wBannerControlSelectMargin = 3;
        _wMarqueeRate = 0.5;
        _wCardOverLapCount = 4;
        _wCardOverMinAlpha = 0.1;
        _wCustomImageRadio = 5.0f;
    }
    return self;
}

@end
