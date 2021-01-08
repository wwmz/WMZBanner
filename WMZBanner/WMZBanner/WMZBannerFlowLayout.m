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
    [self setUpIndex];
    NSArray *array = [self getCopyOfAttributes:[super layoutAttributesForElementsInRect:rect]];
    if (!self.param.wScale||self.param.wMarquee) {
        return array;
    }
    CGRect  visibleRect = CGRectZero;
    visibleRect.origin = self.collectionView.contentOffset;
    visibleRect.size = self.collectionView.bounds.size;
    NSMutableArray *marr = [NSMutableArray new];
    NSInteger minIndex = 0;
    CGFloat minCenterX = [(UICollectionViewLayoutAttributes*)array.firstObject center].x;
    for (int i = 0; i<array.count; i++) {
        UICollectionViewLayoutAttributes *attributes = array[i];
        CGRect cellFrameInSuperview = [self.collectionView convertRect:attributes.frame toView:self.collectionView.superview];
        if (cellFrameInSuperview.origin.x>=0&&
            cellFrameInSuperview.origin.x<=self.collectionView.frame.size.width) {
            if (minCenterX>cellFrameInSuperview.origin.x) {
                minCenterX = cellFrameInSuperview.origin.x;
                minIndex = i;
            }
        }
    }
    for (int i = 0; i<array.count; i++) {
        UICollectionViewLayoutAttributes *attributes = array[i];
        CGFloat distance = CGRectGetMidX(visibleRect) - attributes.center.x;
        if (self.param.wContentOffsetX!=0.5) {
             distance = CGRectGetMidX(visibleRect) - (attributes.center.x + (0.5-self.param.wContentOffsetX)*visibleRect.size.width);
        }
        if (self.param.wSpecialStyle == SpecialStyleFirstScale) {
            distance = CGRectGetMinX(visibleRect) - attributes.center.x;
        }
        CGFloat normalizedDistance = fabs(distance / self.param.wActiveDistance);
        CGFloat zoom = 1 - self.param.wScaleFactor  * normalizedDistance;
        if (self.param.wSpecialStyle == SpecialStyleFirstScale) {
            if (i == minIndex) {
                attributes.transform3D = CATransform3DMakeScale(1.0, zoom+0.6, 1.0);
            }else{
                attributes.transform3D = CATransform3DMakeScale(1.0, 1.0, 1.0);
            }
        }else{
            attributes.transform3D = CATransform3DMakeScale(1.0, zoom, 1.0);
        }
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
        CGPoint center = CGPointMake(attributes.center.x, self.collectionView.center.y );
        if (self.param.wPosition == BannerCellPositionBottom) {
            center =  CGPointMake(attributes.center.x, attributes.center.y + attributes.size.height*(1-zoom));
            attributes.center = center;
        }else if (self.param.wPosition == BannerCellPositionTop) {
            center =  CGPointMake(attributes.center.x, attributes.center.y-  attributes.size.height*(1-zoom));
            attributes.center = center;
        }else if (self.param.wPosition == BannerCellPositionCenter) {
            attributes.center = center;
        }
        [marr addObject:attributes];
    }
    return marr;
}

- (void)setUpIndex{
    if (!self.param.wCardOverLap) {
         self.param.myCurrentPath = self.param.wVertical?
         round((ABS(self.collectionView.contentOffset.y))/(self.param.wItemSize.height+self.param.wLineSpacing)):
             round ((ABS(self.collectionView.contentOffset.x))/(self.param.wItemSize.width+self.param.wLineSpacing));
    }
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

       
    CGFloat offSetAdjustment = MAXFLOAT;
    CGFloat horizontalCenter = (CGFloat) (proposedContentOffset.x + self.collectionView.frame.size.width * self.param.wContentOffsetX);

    CGRect targetRect = CGRectMake(proposedContentOffset.x,
                                    0.0,
                                    self.collectionView.bounds.size.width,
                                    self.collectionView.bounds.size.height);
       
    NSArray *attributes = [self layoutAttributesForElementsInRect:targetRect];
    NSPredicate *cellAttributesPredicate = [NSPredicate predicateWithBlock: ^BOOL(UICollectionViewLayoutAttributes * _Nonnull evaluatedObject,NSDictionary<NSString *,id> * _Nullable bindings){
           return (evaluatedObject.representedElementCategory == UICollectionElementCategoryCell);
       }];
       
    NSArray *cellAttributes = [attributes filteredArrayUsingPredicate: cellAttributesPredicate];
       
    UICollectionViewLayoutAttributes *currentAttributes;
       
    for (UICollectionViewLayoutAttributes *layoutAttributes in cellAttributes)
    {
        CGFloat itemHorizontalCenter = layoutAttributes.center.x;
        if (ABS(itemHorizontalCenter - horizontalCenter) < ABS(offSetAdjustment))
        {
            currentAttributes   = layoutAttributes;
            offSetAdjustment    = itemHorizontalCenter - horizontalCenter;
        }
    }
       
    CGFloat nextOffset          = proposedContentOffset.x + offSetAdjustment;
       
    proposedContentOffset.x     = nextOffset;
    CGFloat deltaX              = proposedContentOffset.x - self.collectionView.contentOffset.x;
    CGFloat velX                = velocity.x;
       
    if (fabs(deltaX) <= FLT_EPSILON || fabs(velX) <= FLT_EPSILON || (velX > 0.0 && deltaX > 0.0) || (velX < 0.0 && deltaX < 0.0))
    {
        
    }else if (velocity.x > 0.0){
      NSArray *revertedArray = [[attributes reverseObjectEnumerator] allObjects];
      BOOL found = YES;
      float proposedX = 0.0;
      for (UICollectionViewLayoutAttributes *layoutAttributes in revertedArray)
           {
               if(layoutAttributes.representedElementCategory == UICollectionElementCategoryCell)
               {
                   CGFloat itemHorizontalCenter = layoutAttributes.center.x;
                   if (itemHorizontalCenter > proposedContentOffset.x) {
                       found = YES;
                       proposedX = nextOffset + (currentAttributes.frame.size.width / 2) + (layoutAttributes.frame.size.width / 2);
                   } else {
                       break;
                   }
               }
           }
           
           if (found) {
               proposedContentOffset.x = proposedX;
               proposedContentOffset.x += self.param.wLineSpacing;
           }
       }
       else if (velocity.x < 0.0)
       {
           for (UICollectionViewLayoutAttributes *layoutAttributes in cellAttributes)
           {
               CGFloat itemHorizontalCenter = layoutAttributes.center.x;
               if (itemHorizontalCenter > proposedContentOffset.x)
               {
                   proposedContentOffset.x = nextOffset - ((currentAttributes.frame.size.width / 2) + (layoutAttributes.frame.size.width / 2));
                   proposedContentOffset.x -= self.param.wLineSpacing;
                   break;
               }
           }
       }
       proposedContentOffset.y = 0.0;
       
       return proposedContentOffset;
    
}

@end
