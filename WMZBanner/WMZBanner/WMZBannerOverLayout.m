
//
//  WMZBannerOverLayout.m
//  WMZBanner
//
//  Created by wmz on 2019/12/18.
//  Copyright © 2019 wmz. All rights reserved.
//
#import "WMZBannerOverLayout.h"
@interface WMZBannerOverLayout()
@property(nonatomic,assign)CGPoint collectionContenOffset;
@property(nonatomic,assign)CGSize collectionContenSize;
@property(nonatomic,assign)CGFloat last;
@property(nonatomic,assign)BOOL right;
@end
@implementation WMZBannerOverLayout
- (instancetype)initConfigureWithModel:(WMZBannerParam *)param{
    if (self = [super init]) {
        self.param = param;
        self.collectionView.bounces = NO;
    }
    return self;
}

- (void)prepareLayout
{
    [super prepareLayout];
    if (self.param.wCardOverLapCount<=0) {
        self.param.wCardOverLapCount = 4;
    }
    self.collectionView.pagingEnabled = YES;
    self.itemSize = self.param.wVertical?
    CGSizeMake(self.param.wItemSize.width , (self.param.wItemSize.height - (self.param.wCardOverLapCount - 1)*self.param.wLineSpacing)):
    CGSizeMake(self.param.wItemSize.width - (self.param.wCardOverLapCount - 1)*self.param.wLineSpacing, self.param.wItemSize.height);
    self.minimumInteritemSpacing = (self.param.wCardOverLapCount - 1)*self.param.wLineSpacing*2;
    self.minimumLineSpacing = (self.param.wCardOverLapCount - 1)*self.param.wLineSpacing*2;
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

    self.param.myCurrentPath = self.param.wVertical?
    MAX(floor ((int)self.collectionContenOffset.y / self.collectionContenSize.height ), 0):
    MAX(floor((int)self.collectionContenOffset.x / self.collectionContenSize.width ), 0);

    self.param.overFactPath = self.param.wVertical?
           MAX(ceil ((int)self.collectionContenOffset.y / self.collectionContenSize.height ), 0):
           MAX(ceil((int)self.collectionContenOffset.x / self.collectionContenSize.width ), 0);
    NSInteger minVisibleIndex = MAX(self.param.myCurrentPath, 0);
    NSInteger contentOffset =  self.param.wVertical?
    self.collectionContenOffset.y:self.collectionContenOffset.x;
    NSInteger collectionBounds = self.param.wVertical?
    self.collectionContenSize.height:self.collectionContenSize.width;
    CGFloat offset = contentOffset % collectionBounds;
    CGFloat offsetProgress = offset / (self.param.wVertical?self.collectionContenSize.height:self.collectionContenSize.width)*1.0f;
    NSInteger maxVisibleIndex = MAX(MIN(itemsCount - 1, self.param.myCurrentPath + self.param.wCardOverLapCount), minVisibleIndex);
    NSMutableArray *mArr = [[NSMutableArray alloc] init];
    
    for (NSInteger i = minVisibleIndex; i<=maxVisibleIndex; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        UICollectionViewLayoutAttributes *attributes = [[self layoutAttributesForItemAtIndexPath:indexPath] copy];
           
        NSInteger visibleIndex = MAX(indexPath.item - self.param.myCurrentPath + 1, 0);
        attributes.size =  self.itemSize;
        CGFloat topCardMidX = self.param.wVertical?
        (self.collectionContenOffset.y +  self.collectionContenSize.height / 2):
        (self.collectionContenOffset.x +  self.collectionContenSize.width / 2);
        attributes.center = self.param.wVertical?
        CGPointMake(self.collectionContenSize.width/2, topCardMidX + self.param.wLineSpacing * (visibleIndex - 1)):
        CGPointMake(topCardMidX + self.param.wLineSpacing * (visibleIndex - 1), self.collectionContenSize.height/2);
        attributes.zIndex = 925457662 - visibleIndex;
        CGFloat scale = [self parallaxProgressForVisibleIndex:visibleIndex offsetProgress:offsetProgress minScale:self.param.wScaleFactor];
        attributes.transform = CGAffineTransformMakeScale(scale, scale);
        if (visibleIndex == 1) {
            if (self.param.wVertical) {
                if (minVisibleIndex != maxVisibleIndex) {
                    if (self.collectionContenOffset.y >= 0) {
                        attributes.center = CGPointMake(attributes.center.x, attributes.center.y - offset);
                    }else{
                        attributes.center = CGPointMake(attributes.center.x , attributes.center.y + attributes.size.height * (1 - scale)/2 - self.param.wLineSpacing * offsetProgress);
                    }
                }
            }else{
                if (minVisibleIndex != maxVisibleIndex) {
                    if (self.collectionContenOffset.x >= 0) {
                           attributes.center =  CGPointMake(attributes.center.x - offset, attributes.center.y);
                       }else{
                           attributes.center = CGPointMake(attributes.center.x + attributes.size.width * (1 - scale)/2 - self.param.wLineSpacing * offsetProgress, attributes.center.y);
                       }
                   }
               }
               if (self.param.wCardOverAlphaOpen) {
                    attributes.alpha = MAX(1-offsetProgress, MAX(self.param.wCardOverMinAlpha, 0));
               }
           }else if (visibleIndex == self.param.wCardOverLapCount + 1){
               attributes.center = self.param.wVertical?
                    CGPointMake(attributes.center.x, attributes.center.y + attributes.size.height * (1 - scale)/2 - self.param.wLineSpacing):
                    CGPointMake(attributes.center.x + attributes.size.width * (1 - scale)/2 - self.param.wLineSpacing, attributes.center.y);
                    if (self.param.wCardOverAlphaOpen) {
                        attributes.alpha = MAX(offsetProgress, MAX(self.param.wCardOverMinAlpha, 0));
                    }
           }else{
               attributes.center = self.param.wVertical?
                        CGPointMake(attributes.center.x , attributes.center.y + attributes.size.height * (1 - scale)/2 - self.param.wLineSpacing * offsetProgress):
                        CGPointMake(attributes.center.x + attributes.size.width * (1 - scale)/2 - self.param.wLineSpacing * offsetProgress, attributes.center.y);
              if (self.param.wCardOverAlphaOpen) {
                 attributes.alpha = MAX(offsetProgress, MAX(self.param.wCardOverMinAlpha*2, 0));
              }
           }
           [mArr addObject:attributes];
        }
    return mArr;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

- (CGFloat)parallaxProgressForVisibleIndex:(NSInteger)visibleIndex
                         offsetProgress:(CGFloat)offsetProgress
                               minScale:(CGFloat)minScale
{
    CGFloat step = (1.0 - minScale) / (self.param.wCardOverLapCount-1)*1.0;
    return (1.0 - (visibleIndex - 1) * step + step * offsetProgress);
}

- (CGSize)collectionContenSize{
     return CGSizeMake((int)self.collectionView.bounds.size.width, (int)self.collectionView.bounds.size.height);
}

- (CGPoint)collectionContenOffset{
    return CGPointMake((int)self.collectionView.contentOffset.x, (int)self.collectionView.contentOffset.y);
}

@end
