//
//  WMZBannerFlowLayout.m
//  WMZBanner
//
//  Created by wmz on 2019/9/6.
//  Copyright © 2019 wmz. All rights reserved.
//

#import "WMZBannerFlowLayout.h"
@interface WMZBannerFlowLayout(){
    CGSize factItemSize;
}
@end
@implementation WMZBannerFlowLayout
- (instancetype)initConfigureWithModel:(WMZBannerParam *)param{
    if (self = [super init]) {
        self.param = param;
    }
    return self;
}

- (void)prepareLayout
{
    [super prepareLayout];
  
    self.itemSize = self.param.wItemSize;
    self.minimumInteritemSpacing = (self.param.wFrame.size.height-self.param.wItemSize.height)/2;
    self.minimumLineSpacing = self.param.wLineSpacing;
    self.sectionInset = self.param.wSectionInset;
    if ([self.collectionView isPagingEnabled]) {
         self.scrollDirection = self.param.wVertical? UICollectionViewScrollDirectionVertical
                                                     :UICollectionViewScrollDirectionHorizontal;
    }else{
         self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    return [self cardScaleTypeInRect:rect];
}

//卡片缩放
- (NSArray<UICollectionViewLayoutAttributes *> *)cardScaleTypeInRect:(CGRect)rect{
    
    NSArray *array = [self getCopyOfAttributes:[super layoutAttributesForElementsInRect:rect]];
    if (!self.param.wScale||self.param.wMarquee) {
        return array;
    }
    CGRect  visibleRect = CGRectZero;
    visibleRect.origin = self.collectionView.contentOffset;
    visibleRect.size = self.collectionView.bounds.size;
    for (int i = 0; i<array.count; i++) {
        UICollectionViewLayoutAttributes *attributes = array[i];
        CGFloat distance = CGRectGetMidX(visibleRect) - attributes.center.x;
        CGFloat normalizedDistance = fabs(distance / self.param.wActiveDistance);
        CGFloat zoom = 1 - self.param.wScaleFactor  * normalizedDistance;
        attributes.transform3D = CATransform3DMakeScale(1.0, zoom, 1.0);
        attributes.frame = CGRectMake(attributes.frame.origin.x, attributes.frame.origin.y + zoom, attributes.size.width, attributes.size.height);
        if (self.param.wAlpha<1) {
            CGFloat collectionCenter =  self.collectionView.frame.size.width / 2 ;
            CGFloat offset = self.collectionView.contentOffset.x ;
            CGFloat normalizedCenter =  attributes.center.x - offset;
            CGFloat maxDistance = (self.itemSize.width) + self.minimumLineSpacing;
            CGFloat distance1 = MIN(fabs(collectionCenter - normalizedCenter), maxDistance);
            CGFloat ratio = (maxDistance - distance1) / maxDistance;
            CGFloat alpha = ratio * (1 - self.param.wAlpha) +self.param.wAlpha;
            attributes.alpha = alpha;
        }
        if (self.param.wZindex) {
           attributes.zIndex = zoom*100;
        }
        attributes.center = CGPointMake(attributes.center.x, (self.param.wPosition == BannerCellPositionBottom?attributes.center.y:self.collectionView.center.y) + zoom);

    }
    return array;
}



- (NSArray *)getCopyOfAttributes:(NSArray *)attributes
{
    NSMutableArray *copyArr = [NSMutableArray new];
    for (UICollectionViewLayoutAttributes *attribute in attributes) {
        [copyArr addObject:[attribute copy]];
    }
    return copyArr;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    if (self.param.wMarquee){
        return NO;
    }
    return ![self.collectionView isPagingEnabled];
}

/**
 * collectionView停止滚动时的偏移量
 */
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    if ([self.collectionView isPagingEnabled]||self.param.wMarquee) {
        return proposedContentOffset;
    }
    CGRect rect;
    rect.origin.y = 0;
    rect.origin.x = proposedContentOffset.x;
    rect.size = self.collectionView.frame.size;
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
  
    
    CGFloat centerX = proposedContentOffset.x + self.collectionView.frame.size.width * self.param.wContentOffsetX;
    CGFloat minDelta = MAXFLOAT;
    for (UICollectionViewLayoutAttributes *attrs in array) {
        if (ABS(minDelta) > ABS(attrs.center.x - centerX)) {
            minDelta = attrs.center.x - centerX;
        }
    }

    proposedContentOffset.x += minDelta;

    if (!self.param.wCardOverLap) {
        self.param.myCurrentPath = round((ABS(proposedContentOffset.x))/(self.param.wItemSize.width+self.param.wLineSpacing));
    }

    return proposedContentOffset;
    
}

@end
