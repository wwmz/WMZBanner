//
//  WMZBannerControl.m
//  WMZBanner
//
//  Created by wmz on 2019/9/6.
//  Copyright © 2019 wmz. All rights reserved.
//

#import "WMZBannerControl.h"

@implementation WMZBannerControl

- (instancetype)initWithFrame:(CGRect)frame WithModel:(WMZBannerParam *)param{
    if (self = [super initWithFrame:frame]) {
        self.param = param;
        self.userInteractionEnabled = NO;
        self.hidesForSinglePage = YES;
        self.currentPageIndicatorTintColor = param.wBannerControlColor;
        self.pageIndicatorTintColor = param.wBannerControlSelectColor;
        
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

    }
    return self;
}

- (void)setCurrentPage:(NSInteger)currentPage{
    [super setCurrentPage:currentPage];
    [self updateDots];
}


- (void)updateDots{
    for (int i = 0; i < [self.subviews count]; i++) {
        UIImageView *dot = [self imageViewForSubview:[self.subviews objectAtIndex:i] currPage:i];
        if (i == self.currentPage){
            dot.image = self.currentImage;
            CGRect rect = dot.frame;
            rect.size = self.currentImageSize;
            dot.frame = rect;
            dot.layer.masksToBounds = YES;
            dot.layer.cornerRadius =  self.param.wBannerControlImageRadius?:self. self.currentImageSize.height/2;
        }else{
            dot.image = self.inactiveImage;
            CGRect rect = dot.frame;
            rect.size = self.inactiveImageSize;
            dot.frame = rect;
            dot.layer.masksToBounds = YES;
            dot.layer.cornerRadius = self.param.wBannerControlImageRadius?:self. self.inactiveImageSize.height/2;
        }
    }
}


- (UIImageView *)imageViewForSubview:(UIView *)view currPage:(int)currPage{
    UIImageView *dot = nil;
    if ([view isKindOfClass:[UIView class]]) {
        for (UIView *subview in view.subviews) {
            if ([subview isKindOfClass:[UIImageView class]]) {
                dot = (UIImageView *)subview;
                break;
            }
        }
        if (dot == nil) {
            dot = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, view.frame.size.width, view.frame.size.height)];
            [view addSubview:dot];
        }
    }else {
        dot = (UIImageView *)view;
    }
    
    return dot;
}


@end
