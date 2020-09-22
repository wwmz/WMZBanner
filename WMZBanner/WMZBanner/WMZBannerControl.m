//
//  WMZBannerControl.m
//  WMZBanner
//
//  Created by wmz on 2019/9/6.
//  Copyright © 2019 wmz. All rights reserved.
//

#import "WMZBannerControl.h"
#define bannerPointSize CGSizeMake(8,8)
@interface WMZBannerControl()
{
    NSInteger _numberOfPages;
    NSInteger _currentPage;
}
@property(nonatomic,strong)NSMutableArray *imageArr;
@end
@implementation WMZBannerControl

- (instancetype)initWithFrame:(CGRect)frame WithModel:(WMZBannerParam *)param{
    if (self = [super initWithFrame:frame]) {
        self.param = param;
        self.userInteractionEnabled = NO;
        self.currentPageIndicatorTintColor = param.wBannerControlSelectColor;
        self.pageIndicatorTintColor = param.wBannerControlColor;
        if (param.wBannerControlImage) {
            self.inactiveImage = [UIImage imageNamed:param.wBannerControlImage];
            self.inactiveImageSize = param.wBannerControlImageSize;
            self.pageIndicatorTintColor = [UIColor clearColor];
        }
        if (param.wBannerControlSelectImage) {
            self.currentImage = [UIImage imageNamed:param.wBannerControlSelectImage];
            self.currentImageSize = param.wBannerControlSelectImageSize;
            self.currentPageIndicatorTintColor = [UIColor clearColor];
        }
        
        [self resetFrame];

    }
    return self;
}

- (void)setCurrentPage:(NSInteger)currentPage{
    _currentPage = currentPage;
    [self updateDots];
}

- (void)setNumberOfPages:(NSInteger)numberOfPages{
    _numberOfPages = numberOfPages;
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];\
    UIView *tempView = nil;
    for (int i = 0; i<numberOfPages; i++) {
        UIView *bgView = [UIView new];
        
        bgView.frame = CGRectMake(tempView?CGRectGetMaxX(tempView.frame)+self.param.wBannerControlSelectMargin:self.param.wBannerControlSelectMargin, 0,self.frame.size.width/numberOfPages , self.frame.size.height);
        [self addSubview:bgView];
        UIImageView *imageView = [UIImageView new];
        imageView.tag = 111;
        [bgView addSubview:imageView];
        
        UIView  *pointView = [UIImageView new];
        [bgView addSubview:pointView];
        pointView.tag = 222;
        pointView.frame = CGRectMake((bgView.frame.size.width - bannerPointSize.width)/2, (bgView.frame.size.height - bannerPointSize.height)/2, bannerPointSize.width, bannerPointSize.height);
        pointView.layer.backgroundColor = self.param.wBannerControlColor.CGColor;
        pointView.layer.cornerRadius = pointView.frame.size.height/2;
        
        tempView = bgView;
    }
}


- (void)updateDots{
    for (int i = 0; i < [self.subviews count]; i++) {
        UIView *bgView = self.subviews[i];
        UIImageView *dot = [bgView viewWithTag:111];
        UIView *pointView = [bgView viewWithTag:222];
        if (i == self.currentPage){
           pointView.layer.backgroundColor = self.param.wBannerControlSelectColor.CGColor;
           pointView.hidden = self.currentImage?YES:NO;
           dot.hidden = self.currentImage?NO:YES;
           if (self.currentImage) {
               dot.image = self.currentImage;
               CGRect rect = dot.frame;
               rect.size = self.currentImageSize;
               dot.frame = rect;
               dot.layer.masksToBounds = YES;
               dot.layer.cornerRadius =  self.param.wBannerControlImageRadius?:self. self.currentImageSize.height/2;
           }
        }else{
            pointView.layer.backgroundColor = self.param.wBannerControlColor.CGColor;
            pointView.hidden = self.inactiveImage?YES:NO;
            dot.hidden = self.currentImage?NO:YES;
            if (self.inactiveImage) {
                dot.image = self.inactiveImage;
                CGRect rect = dot.frame;
                rect.size = self.inactiveImageSize;
                dot.frame = rect;
                dot.layer.masksToBounds = YES;
                dot.layer.cornerRadius = self.param.wBannerControlImageRadius?:self. self.inactiveImageSize.height/2;
            }
        }
    }
    [self layoutSubviews];
}



- (void)layoutSubviews
{
    [super layoutSubviews];
    if (self.param.wBannerControlImage&&self.param.wBannerControlSelectImage){
        UIView *tmp = nil;
        for (int i=0; i<[self.subviews count]; i++) {
            UIView* dot = [self.subviews objectAtIndex:i];
            CGFloat x = (tmp?CGRectGetMaxX(tmp.frame):0)+self.param.wBannerControlSelectMargin;
            CGFloat y = 0;
            if (i == self.currentPage) {
                y = (self.bounds.size.height - self.currentImageSize.height)/2;
                [dot setFrame:CGRectMake(x, y, self.currentImageSize.width, self.currentImageSize.height)];
            }else {
                y = (self.bounds.size.height - self.inactiveImageSize.height)/2;
                [dot setFrame:CGRectMake(x, y, self.inactiveImageSize.width, self.inactiveImageSize.height)];
            }
            tmp = dot;
            if (i == [self.subviews count]-1) {
                CGRect rect = self.frame;
                rect.size.width = CGRectGetMaxX(dot.frame);
                rect.origin.x = (self.param.wFrame.size.width - rect.size.width)/2;
                self.frame = rect;
            }
        }
    }
    [self resetFrame];
}

- (void)resetFrame{
    
    for (int i=0; i<[self.subviews count]; i++) {
        UIView* dot = [self.subviews objectAtIndex:i];
        if (i == [self.subviews count]-1) {
            CGRect rect = self.frame;
            rect.size.width = CGRectGetMaxX(dot.frame);
            rect.origin.x = (self.param.wFrame.size.width - rect.size.width)/2;
            self.frame = rect;
        }
    }
    if (self.param.wBannerControlPosition == BannerControlLeft) {
          CGRect rect = self.frame;
          rect.origin.x = 30;
          self.frame = rect;
      }
      if (self.param.wBannerControlPosition == BannerControlRight) {
          CGRect rect = self.frame;
          rect.origin.x = self.superview.frame.size.width - rect.size.width  - 30;
          self.frame = rect;
      }
      if (self.param.wCustomControl) {
          self.param.wCustomControl(self);
      }
}

- (NSMutableArray *)imageArr{
    if (!_imageArr) {
        _imageArr = [NSMutableArray new];
    }
    return _imageArr;
}

@end
