
//
//  WMZBannerFadeLayout.m
//  WMZBanner
//
//  Created by wmz on 2020/6/15.
//  Copyright © 2020 wmz. All rights reserved.
//

#import "WMZBannerFadeLayout.h"
@interface WMZBannerFadeLayout()
@property(nonatomic,assign)CGPoint collectionContenOffset;
@property(nonatomic,assign)CGSize collectionContenSize;
@property(nonatomic,assign)CGFloat last;
@end
@implementation WMZBannerFadeLayout
- (instancetype)initConfigureWithModel:(WMZBannerParam *)param{
    if (self = [super init]) {
        self.param = param;
    }
    return self;
}

- (void)prepareLayout
{
    [super prepareLayout];
    self.collectionView.bounces = NO;
    self.collectionView.pagingEnabled = YES;
    self.itemSize = self.param.wItemSize;
    self.minimumInteritemSpacing = (self.param.wFrame.size.height-self.param.wItemSize.height)/2;
    self.minimumLineSpacing = self.param.wLineSpacing;
    self.sectionInset = self.param.wSectionInset;
    self.scrollDirection = self.param.wVertical? UICollectionViewScrollDirectionVertical
                                                           :UICollectionViewScrollDirectionHorizontal;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    return [self cardOverLapTypeInRect:rect];
}

//卡片重叠
- (NSArray<UICollectionViewLayoutAttributes *> *)cardOverLapTypeInRect:(CGRect)rect{
    NSInteger itemsCount = [self.collectionView numberOfItemsInSection:0];
    if (itemsCount <= 0) {
        return nil;
    }
    NSMutableArray *mArr = [[NSMutableArray alloc] init];
    if (self.param.wVertical) {
        if (self.collectionView.contentOffset.y>self.last) {
            self.right = YES;
        }else if (self.collectionView.contentOffset.y<self.last){
            self.right = NO;
        }
    }else{
        if (self.collectionView.contentOffset.x>self.last) {
            self.right = YES;
        }else if (self.collectionView.contentOffset.x<self.last){
            self.right = NO;
        }
    }
    
    self.param.myCurrentPath = self.param.wVertical?
    (self.right?MAX(floor(self.collectionContenOffset.y / (int)self.collectionContenSize.height), 0):MAX(ceil(self.collectionContenOffset.y / (int)self.collectionContenSize.height), 0)):
    (self.right?MAX(floor(self.collectionContenOffset.x / (int)self.collectionContenSize.width), 0):MAX(ceil(self.collectionContenOffset.x / (int)self.collectionContenSize.width), 0));
    NSInteger minVisibleIndex = MAX(self.param.myCurrentPath-1, 0);
    NSInteger maxVisibleIndex = MIN(self.param.myCurrentPath+1, itemsCount-1);
    for (NSInteger i = minVisibleIndex; i <= maxVisibleIndex; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        UICollectionViewLayoutAttributes *attributes = [[self layoutAttributesForItemAtIndexPath:indexPath] copy];
        CGRect rect = attributes.frame;
        if (self.param.wVertical) {
            rect.origin.y = self.collectionView.contentOffset.y;
        }else{
            rect.origin.x = self.collectionView.contentOffset.x;
        }
        attributes.frame = rect;
        if (i == self.param.myCurrentPath) {
            attributes.zIndex = 1200;
        }else{
            attributes.zIndex = 999-i;
        }
        [mArr addObject:attributes];
    }
    self.last = self.param.wVertical?self.collectionView.contentOffset.y:self.collectionView.contentOffset.x;
    return mArr;
}
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}
- (CGSize)collectionContenSize{
     return CGSizeMake((int)self.collectionView.bounds.size.width, (int)self.collectionView.bounds.size.height);
}

- (CGPoint)collectionContenOffset{
    return CGPointMake((int)self.collectionView.contentOffset.x, (int)self.collectionView.contentOffset.y);
}
@end
