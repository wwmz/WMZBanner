//
//  WMZBannerFlowLayout.m
//  WMZBanner
//
//  Created by wmz on 2019/9/6.
//  Copyright © 2019 wmz. All rights reserved.
//

#import "WMZBannerFlowLayout.h"
@interface WMZBannerFlowLayout()
@property(nonatomic,strong)NSDictionary *config;
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
    self.minimumInteritemSpacing = 0;
    self.minimumLineSpacing = self.param.wLineSpacing;
    self.sectionInset = self.param.wSectionInset;
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *array = [self getCopyOfAttributes:[super layoutAttributesForElementsInRect:rect]];
    if (!self.param.wScale) {
        return array;
    }
    CGRect  visibleRect = CGRectZero;
    visibleRect.origin = self.collectionView.contentOffset;
    visibleRect.size = self.collectionView.bounds.size;
    for (UICollectionViewLayoutAttributes *attributes  in array) {
        CGFloat distance = CGRectGetMidX(visibleRect) - attributes.center.x;
        CGFloat normalizedDistance = fabs(distance / self.param.wActiveDistance);
        CGFloat zoom = 1 - self.param.wScaleFactor  * normalizedDistance;
        attributes.transform3D = CATransform3DMakeScale(1.0, zoom, 1.0);
        attributes.frame = CGRectMake(attributes.frame.origin.x, attributes.frame.origin.y + zoom, attributes.size.width, attributes.size.height);
        CGFloat scrollDirectionItemHeight = self.itemSize.height;
        CGFloat sideItemFixedOffset = 0;
        sideItemFixedOffset = (scrollDirectionItemHeight - scrollDirectionItemHeight * 0.7) / 2;
        
        attributes.center = CGPointMake(attributes.center.x, (self.param.wPosition == BannerCellPositionBottom?attributes.center.y:self.collectionView.center.y) + zoom);
        
    }
    return array;
}

//防止报错
- (NSArray *)getCopyOfAttributes:(NSArray *)attributes
{
    NSMutableArray *copyArr = [NSMutableArray new];
    for (UICollectionViewLayoutAttributes *attribute in attributes) {
        [copyArr addObject:[attribute copy]];
    }
    return copyArr;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}


/**
 * collectionView停止滚动时的偏移量
 */
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{

    CGRect rect;
    rect.origin.y = 0;
    rect.origin.x = proposedContentOffset.x;
    rect.size = self.collectionView.frame.size;
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    CGFloat centerX = proposedContentOffset.x + self.collectionView.frame.size.width * self.param.wContentOffsetX;
    CGFloat minDelta = self.param.wItemSize.width;
    for (UICollectionViewLayoutAttributes *attrs in array) {
        if (ABS(minDelta) > ABS(attrs.center.x - centerX)) {
            minDelta = attrs.center.x - centerX;
        }
    }
    // 修改原有的偏移量
    proposedContentOffset.x += minDelta;
    return proposedContentOffset;
}

@end
