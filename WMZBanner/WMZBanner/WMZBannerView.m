

//
//  WMZBannerView.m
//  WMZBanner
//
//  Created by wmz on 2019/9/6.
//  Copyright © 2019 wmz. All rights reserved.
//

#import "WMZBannerView.h"
#import "WMZBannerFlowLayout.h"
#import "WMZBannerControl.h"
#import "WMZBannerOverLayout.h"
#import "WMZBannerFadeLayout.h"
@interface WMZBannerView()<UICollectionViewDelegate,UICollectionViewDataSource>{
    BOOL beganDragging;
    CGFloat marginTime;
}
@property(strong,nonatomic)UICollectionView *myCollectionV;
@property(strong,nonatomic)UICollectionViewFlowLayout *flowL ;
@property(strong,nonatomic)WMZBannerControl *bannerControl ;
@property(strong,nonatomic)NSArray *data;
@property(strong,nonatomic)WMZBannerParam *param;
@property(strong,nonatomic)NSTimer *timer;
@property(strong,nonatomic)UIView *line;
@property(assign,nonatomic)NSInteger lastIndex;
@end
@implementation WMZBannerView
- (instancetype)initConfigureWithModel:(WMZBannerParam *)param withView:(UIView*)parentView{
    if (self = [super init]) {
        self.param = param;
        if (parentView) {
            [parentView addSubview:self];
        }
        self.param.wFrame = CGRectMake(self.param.wFrame.origin.x,
                                       self.param.wFrame.origin.y,
                                       (int)self.param.wFrame.size.width,
                                       (int)self.param.wFrame.size.height);
        [self setFrame:self.param.wFrame];
        self.data = [NSArray arrayWithArray:self.param.wData];
        [self setUp];
    }
    return self;
}

/**
 *  调用方法
 *
 */
- (instancetype)initConfigureWithModel:(WMZBannerParam *)param{
    if (self = [super init]) {
        self.param = param;
        self.param.wFrame = CGRectMake(self.param.wFrame.origin.x,
                                       self.param.wFrame.origin.y,
                                       (int)self.param.wFrame.size.width,
                                       (int)self.param.wFrame.size.height);
        [self setFrame:self.param.wFrame];
        self.data = [NSArray arrayWithArray:self.param.wData];
        [self setUp];
    }
    return self;
}


- (void)updateUI{
    self.data = [NSArray arrayWithArray:self.param.wData];
    [self resetCollection];
}


- (void)resetCollection{
    self.bannerControl.frame = CGRectMake((self.bounds.size.width - 60)/2 , self.bounds.size.height - 30,60, 30);
    self.bannerControl.numberOfPages = self.data.count;
    self.bannerControl.hidden = self.param.wHideBannerControl;
    if (self.data.count == 1) {
        self.bannerControl.hidden = YES;
    }
    [UIView animateWithDuration:0.0 animations:^{
        [self.myCollectionV reloadData];
        if (self.param.wSelectIndex>=0|| self.param.wRepeat) {
            NSIndexPath *path = [NSIndexPath indexPathForRow: self.param.wRepeat?((BANNERCOUNT/2)*self.data.count+self.param.wSelectIndex):self.param.wSelectIndex inSection:0];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self scrolToPath:path animated:NO];
                self.bannerControl.currentPage = self.param.wSelectIndex;
                self.param.myCurrentPath = self.param.wRepeat?((BANNERCOUNT/2)*self.data.count+self.param.wSelectIndex):self.param.wSelectIndex;
                if (self.param.wAutoScroll) {
                    [self createTimer];
                }else{
                    [self cancelTimer];
                }
            });
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self scrollEnd:[NSIndexPath indexPathForRow: self.param.wRepeat?((BANNERCOUNT/2)*self.data.count+self.param.wSelectIndex):self.param.wSelectIndex inSection:0]];
        });
    } completion:^(BOOL finished) {}];
    
    
    if (self.param.wSpecialStyle == SpecialStyleLine&&self.param.wData.count) {
        [self addSubview:self.line];
        self.line.hidden = NO;
        self.line.backgroundColor = [UIColor redColor];
        if (self.param.wSpecialCustumLine) {
            self.param.wSpecialCustumLine(self.line);
        }
        
        CGFloat lineHeight = self.line.frame.size.height?:2;
        CGFloat lineWidth = self.param.wFrame.size.width/self.param.wData.count;
        self.line.frame = CGRectMake(0, self.param.wFrame.size.height -lineHeight,  lineWidth, lineHeight);
    }else{
        self.line.hidden = YES;
    }
    
    
}

- (void)setUp{
    
    if (self.data&&self.data.count==1) {
        self.param.wRepeat = NO;
        self.param.wAutoScroll = NO;
    }
    
    if (self.param.wMarquee) {
        self.param.wAutoScroll = YES;
        self.param.wHideBannerControl = YES;
        marginTime = 0.005;
        self.param.wRepeat = YES;
    }
    self.param.wFrame = CGRectIntegral(self.param.wFrame);
    if (self.param.wScreenScale<1&&self.param.wScreenScale>0) {
        CGRect rect = self.param.wFrame;
        rect.origin.x = rect.origin.x * self.param.wScreenScale;
        rect.origin.y = rect.origin.y * self.param.wScreenScale;
        rect.size.width = rect.size.width * self.param.wScreenScale;
        rect.size.height = rect.size.height * self.param.wScreenScale;
        self.param.wFrame = rect;
        self.frame = self.param.wFrame;
        
        CGSize size = self.param.wItemSize;
        size.width *= self.param.wScreenScale;
        size.height *= self.param.wScreenScale;
        self.param.wItemSize = size;
        
        self.param.wLineSpacing*=self.param.wScreenScale;
        
        UIEdgeInsets sets = self.param.wSectionInset;
        sets.top*=self.param.wScreenScale;
        sets.right*=self.param.wScreenScale;
        sets.bottom*=self.param.wScreenScale;
        sets.left*=self.param.wScreenScale;
        self.param.wSectionInset = sets;
    }
    if (self.param.wItemSize.height == 0 || self.param.wItemSize.width == 0 ) {
        self.param.wItemSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
    }

    else if(self.param.wItemSize.height>self.frame.size.height){
        self.param.wItemSize = CGSizeMake(self.param.wItemSize.width, self.frame.size.height);
    }else if(self.param.wItemSize.width>self.frame.size.width){
        self.param.wItemSize = CGSizeMake(self.frame.size.width, self.param.wItemSize.height);
    }
    int width = self.param.wItemSize.width;
    int height = self.param.wItemSize.height;
    self.param.wItemSize = CGSizeMake(width, height);
    
    if (self.param.wFadeOpen) {
        self.flowL = [[WMZBannerFadeLayout alloc] initConfigureWithModel:self.param];
    }else if (self.param.wCardOverLap) {
        if (self.param.wScaleFactor == 0.5) {
            self.param.wScaleFactor = 0.8f;
        }
        self.flowL = [[WMZBannerOverLayout alloc] initConfigureWithModel:self.param];
    }else{
        self.flowL = [[WMZBannerFlowLayout alloc] initConfigureWithModel:self.param];
    }


    [self addSubview:self.myCollectionV];
    self.myCollectionV.scrollEnabled = self.param.wCanFingerSliding;
    [self.myCollectionV registerClass:[Collectioncell class] forCellWithReuseIdentifier:NSStringFromClass([Collectioncell class])];
    [self.myCollectionV registerClass:[CollectionTextCell class] forCellWithReuseIdentifier:NSStringFromClass([CollectionTextCell class])];
    if (self.param.wMyCellClassName) {
        [self.myCollectionV registerClass:NSClassFromString(self.param.wMyCellClassName) forCellWithReuseIdentifier:self.param.wMyCellClassName];
    }
    if (self.param.wMyCellClassNames) {
        if ([self.param.wMyCellClassNames isKindOfClass:[NSString class]]) {
           [self.myCollectionV registerClass:NSClassFromString(self.param.wMyCellClassNames) forCellWithReuseIdentifier:self.param.wMyCellClassNames];
        }else if ([self.param.wMyCellClassNames isKindOfClass:[NSArray class]]){
            [(NSArray*)self.param.wMyCellClassNames enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([obj isKindOfClass:[NSString class]]) {
                     [self.myCollectionV registerClass:NSClassFromString(obj) forCellWithReuseIdentifier:obj];
                }
            }];
        }
    }
    
    if (self.param.wXibCellClassNames) {
        if ([self.param.wXibCellClassNames isKindOfClass:[NSString class]]) {
            [self.myCollectionV registerNib:[UINib nibWithNibName:self.param.wXibCellClassNames bundle:nil] forCellWithReuseIdentifier:self.param.wXibCellClassNames];
        }else if ([self.param.wXibCellClassNames isKindOfClass:[NSArray class]]){
            [(NSArray*)self.param.wXibCellClassNames enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([obj isKindOfClass:[NSString class]]) {
                     [self.myCollectionV registerNib:[UINib nibWithNibName:obj bundle:nil] forCellWithReuseIdentifier:obj];
                }
            }];
        }
    }
    
    self.myCollectionV.pagingEnabled = (self.param.wItemSize.width == self.myCollectionV.frame.size.width && self.param.wLineSpacing == 0)||self.param.wVertical;
    if ([self.myCollectionV isPagingEnabled]) {
        self.myCollectionV.decelerationRate = UIScrollViewDecelerationRateNormal;
    }
    
    self.bannerControl = [[WMZBannerControl alloc]initWithFrame:CGRectMake((self.bounds.size.width - 60)/2 , self.bounds.size.height - 30,60, 30) WithModel:self.param];
    [self addSubview:self.bannerControl];

    self.bgImgView = [UIImageView new];
    self.bgImgView.contentMode = self.param.wImageFill?UIViewContentModeScaleAspectFill:UIViewContentModeScaleToFill;
    [self addSubview:self.bgImgView];
    [self sendSubviewToBack:self.bgImgView];
    self.bgImgView.hidden = !self.param.wEffect;
    self.bgImgView.layer.masksToBounds = YES;
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    [self.bgImgView addSubview:effectView];
    
    self.myCollectionV.frame = self.bounds;
    if (self.param.wCustomControl) {
        self.param.wCustomControl(self.bannerControl);
    }
    self.bgImgView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height*self.param.wEffectHeight);
    effectView.frame = self.bgImgView.bounds;
    [self resetCollection];
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger index = self.param.wRepeat?indexPath.row%self.data.count:indexPath.row;
    id dic = self.data[index];
    UICollectionViewCell *tmpCell = nil;
    if (self.param.wMyCell) {
        tmpCell = self.param.wMyCell([NSIndexPath indexPathForRow:index inSection:indexPath.section], collectionView, dic,self.bgImgView,self.data);
    }else{
        //默认视图
        Collectioncell *cell = (Collectioncell *)[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([Collectioncell class]) forIndexPath:indexPath];
        cell.param = self.param;
        if ([dic isKindOfClass:[NSDictionary class]]) {
            [self setIconData:cell.icon withData:dic[self.param.wDataParamIconName]];
        }else{
            [self setIconData:cell.icon withData:dic];
        }
        tmpCell = cell;
        cell.contentView.layer.cornerRadius = self.param.wCustomImageRadio;
    }
    return tmpCell;
}

- (void)setIconData:(UIImageView*)icon withData:(id)data{
    if (!data) return;
    if ([data isKindOfClass:[NSString class]]) {
        if ([(NSString*)data hasPrefix:@"http"]) {
            [icon sd_setImageWithURL:[NSURL URLWithString:(NSString*)data] placeholderImage:self.param.wPlaceholderImage?[UIImage imageNamed:self.param.wPlaceholderImage]:nil];
        }else{
            icon.image = [UIImage imageNamed:(NSString*)data];
        }
    }
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return  self.param.wRepeat?self.data.count*BANNERCOUNT:self.data.count;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.param.wEventClick) {
        NSInteger index = self.param.wRepeat?indexPath.row%self.data.count:indexPath.row;
        id dic = self.data[index];
        self.param.wEventClick(dic, index);
    }
    
    if (self.param.wEventCenterClick) {
        NSInteger index = self.param.wRepeat?indexPath.row%self.data.count:indexPath.row;
        id dic = self.data[index];
        BOOL center = [self checkCellInCenterCollectionView:collectionView AtIndexPath:indexPath];
        UICollectionViewCell *currentCell = (UICollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
        self.param.wEventCenterClick(dic, index,center,currentCell);
    }
    if (self.param.wClickCenter) {
        NSArray *visibleCellIndex = [collectionView visibleCells];
        NSArray *sortedIndexPaths = [visibleCellIndex sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            NSIndexPath *path1 = (NSIndexPath *)[collectionView indexPathForCell:obj1];
            NSIndexPath *path2 = (NSIndexPath *)[collectionView indexPathForCell:obj2];
            return [path1 compare:path2];
        }];
        if (sortedIndexPaths.count>0) {
            NSInteger center = sortedIndexPaths.count/2;
            UICollectionViewCell *tmpCell = [collectionView cellForItemAtIndexPath:indexPath];
            for (int i = 0; i < sortedIndexPaths.count; i++) {
                UICollectionViewCell *cell = sortedIndexPaths[i];
                if (cell == tmpCell) {
                    NSIndexPath *nextIndexPath = nil;
                    if (i>center || i<center) {
                        nextIndexPath = [NSIndexPath indexPathForItem: indexPath.row inSection:0];
                        self.param.myCurrentPath = indexPath.row;
                        [self scrolToPath:nextIndexPath animated:YES];
                        [collectionView setUserInteractionEnabled:NO];
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                             [collectionView setUserInteractionEnabled:YES];
                        });
                    }
                    break;
                }
            }
        }
    }
}

/*
 检测是否是中间的cell 当前判断依据为最大的cell 如果cell大小一样 那么取显示的first第一个
 */
- (BOOL)checkCellInCenterCollectionView:(UICollectionView *)collectionView AtIndexPath:(NSIndexPath *)indexPath{
    BOOL center = NO;
    NSMutableArray *arr = [NSMutableArray new];
    NSMutableArray *indexArr = [NSMutableArray new];
    for (int i = 0; i<[collectionView visibleCells].count; i++) {
        UICollectionViewCell *cell = [collectionView visibleCells][i];
        [arr addObject:[NSString stringWithFormat:@"%.0f",cell.frame.size.height]];
        [indexArr addObject:cell];
    }
    
    float max = [[arr valueForKeyPath:@"@max.floatValue"] floatValue];
           
    NSInteger cellIndex = [arr indexOfObject:[NSString stringWithFormat:@"%.0f",max]];
    if (cellIndex == NSNotFound) {
        if (arr.count%2 == 0) {
            cellIndex = arr.count/2 ;
        }else{
            cellIndex = arr.count/2+1 ;
        }
    }
    if (cellIndex<indexArr.count) {
        UICollectionViewCell *cell = indexArr[cellIndex];
        UICollectionViewCell *currentCell = (UICollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
        if (cell == currentCell) {
            center = YES;
        }
    }
    return center;
}

//滚动处理
- (void)scrolToPath:(NSIndexPath*)path animated:(BOOL)animated{
    
    if (self.param.wRepeat?(path.row> self.data.count*BANNERCOUNT-1):(path.row> self.data.count-1)){
        [self cancelTimer];
        return;
    }
    if (self.data.count==0) return;
    if (self.param.wCardOverLap||self.param.wFadeOpen) {
         [self.myCollectionV setContentOffset: self.param.wVertical?
          CGPointMake(0, path.row *self.myCollectionV.bounds.size.height):
          CGPointMake(path.row *self.myCollectionV.bounds.size.width, 0)
                                     animated:animated];
    }else{
        if ([self.myCollectionV isPagingEnabled]) {
            [self.myCollectionV scrollToItemAtIndexPath:path atScrollPosition:
             self.param.wVertical?UICollectionViewScrollPositionCenteredVertically:
                                  UICollectionViewScrollPositionCenteredHorizontally animated:animated];
        }else{
            [self.myCollectionV scrollToItemAtIndexPath:path atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:animated];
        }
    }
    
    if ([self.myCollectionV isPagingEnabled]||self.param.wCardOverLap) return;
    if(self.param.wContentOffsetX>0.5){
        self.myCollectionV.contentOffset = CGPointMake(self.myCollectionV.contentOffset.x-(self.param.wContentOffsetX-0.5)*self.myCollectionV.frame.size.width, self.myCollectionV.contentOffset.y);
    }else if(self.param.wContentOffsetX<0.5){
        self.myCollectionV.contentOffset = CGPointMake(self.myCollectionV.contentOffset.x+self.myCollectionV.frame.size.width *(0.5-self.param.wContentOffsetX), self.myCollectionV.contentOffset.y);
    }
}


//定时器
- (void)createTimer{
    if (!self.timer) {
        SEL sel = NSSelectorFromString(self.param.wMarquee?@"autoMarqueenScrollAction":@"autoScrollAction");
        self.timer = [NSTimer scheduledTimerWithTimeInterval:self.param.wMarquee?marginTime: self.param.wAutoScrollSecond  target:self selector:sel userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    }
}

//定时器方法 自动滚动
- (void)autoScrollAction{
    if (beganDragging) return;
    if (!self.timer) return;
    if (!self.superview) return;
    if (!self.param.wAutoScroll) {
        [self cancelTimer];
        return;
    }
    self.param.myCurrentPath+=1;
    if (self.param.wRepeat&&  self.param.myCurrentPath == (self.data.count*BANNERCOUNT - 1)) {
       self.param.myCurrentPath = 0;
    }
    else if(!self.param.wRepeat&&  self.param.myCurrentPath == self.data.count){
        [self cancelTimer];
        return;
    }
    NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem: self.param.myCurrentPath inSection:0];
    [self scrolToPath:nextIndexPath animated:YES];
}

//定时器方法 跑马灯
- (void)autoMarqueenScrollAction{
    if (!self.timer) return;
    if (!self.superview) return;
    if (!self.param.wAutoScroll) {
        [self cancelTimer];
        return;
    }
    NSValue *value = nil;
    if (self.param.wVertical) {
        CGFloat OffsetY = self.myCollectionV.contentOffset.y + self.param.wMarqueeRate;
        if (OffsetY >self.myCollectionV.contentSize.height) {
            OffsetY = self.myCollectionV.contentSize.height/2;
        }
        value = [NSValue valueWithCGPoint:CGPointMake(self.myCollectionV.contentOffset.x, OffsetY)];
    }else{
        CGFloat OffsetX = self.myCollectionV.contentOffset.x + self.param.wMarqueeRate;
        if (OffsetX >self.myCollectionV.contentSize.width) {
            OffsetX = self.myCollectionV.contentSize.width/2;
        }
        value = [NSValue valueWithCGPoint:CGPointMake(OffsetX, self.myCollectionV.contentOffset.y)];
    }
    [self.myCollectionV setContentOffset:value.CGPointValue];
}

//定时器销毁
- (void)cancelTimer{
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

//开始拖动
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    beganDragging = YES;
    if (!self.param.wMarquee) {
        if (self.param.wAutoScroll) {
            [self cancelTimer];
        }
    }else{
        [self cancelTimer];
        [self performSelector:@selector(createTimer) withObject:nil afterDelay:self.param.wAutoScrollSecond];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger index = 0;
    if (self.param.wCardOverLap||self.param.wFadeOpen) {
        if ([self.myCollectionV isPagingEnabled]&&!self.param.wMarquee) {
            index = self.param.myCurrentPath;
        }
    }else{
        if ([self.myCollectionV isPagingEnabled]&&!self.param.wMarquee) {
            index =  self.param.wVertical?
                               scrollView.contentOffset.y/scrollView.frame.size.height:
                               scrollView.contentOffset.x/scrollView.frame.size.width;
            self.param.myCurrentPath = index;
        }else{
            index = self.param.myCurrentPath;
        }
    }
    self.bannerControl.currentPage = self.param.wRepeat?index %self.data.count:index;
    if (self.param.wEventDidScroll) {
        self.param.wEventDidScroll(scrollView.contentOffset);
    }
    [self setUpSpecialFrame];
}

//拖动结束
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    beganDragging = NO;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (!self.param.wMarquee) {
        if (![self.myCollectionV isPagingEnabled]) {
            self.bannerControl.currentPage = self.param.wRepeat?self.param.myCurrentPath%self.data.count:self.param.myCurrentPath;
        }
        if (self.param.wAutoScroll) {
            [self createTimer];
        }
        [self setUpSpecialFrame];
        [self scrollEnd:[NSIndexPath indexPathForRow:self.param.myCurrentPath inSection:0]];
        [self fadeAction];
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    if (self.param.wCardOverLap) {
        self.param.myCurrentPath = self.param.wVertical?
              MAX(floor(scrollView.contentOffset.y / scrollView.bounds.size.height ), 0):
              MAX(floor(scrollView.contentOffset.x / scrollView.bounds.size.width ), 0);
    }
    [self scrollEnd:[NSIndexPath indexPathForRow:self.param.myCurrentPath inSection:0]];
    [self setUpSpecialFrame];
    [self fadeAction];
}

- (void)scrollEnd:(NSIndexPath*)indexPath{
    if (!self.data.count) return;
    if (self.param.wMarquee) return;
    NSInteger current = MAX( self.param.wCardOverLap?self.param.overFactPath:self.param.myCurrentPath, 0);
    NSInteger index =  self.param.wRepeat?current%self.data.count:current;
    if (index>self.data.count-1) {
        index = 0;
    }
    //取上一张
    id dic = self.data[index];
    if (self.param.wEventScrollEnd) {
        BOOL center = [self checkCellInCenterCollectionView:self.myCollectionV AtIndexPath:indexPath];
        UICollectionViewCell *currentCell = (UICollectionViewCell*)[self.myCollectionV cellForItemAtIndexPath:indexPath];
        self.param.wEventScrollEnd(dic, index, center,currentCell);
    }
    if (self.param.wEffect) {
        if ([dic isKindOfClass:[NSDictionary class]]) {
            [self setIconData:self.bgImgView  withData:dic[self.param.wDataParamIconName]];
        }else{
            [self setIconData:self.bgImgView  withData:dic];
        }
    }
    self.bannerControl.currentPage =  index;
    
    if (self.param.wEventDidScroll) {
        self.param.wEventDidScroll(self.myCollectionV.contentOffset);
    }
    self.lastIndex = current;
}
//淡入淡出
- (void)fadeAction{
    if (self.param.wFadeOpen) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            WMZBannerFadeLayout *fade = (WMZBannerFadeLayout*)self.flowL;
            if (![fade isKindOfClass:[WMZBannerFadeLayout class]]) {
                return;
            }
            NSInteger current = MAX(self.param.myCurrentPath, 0);
            NSInteger index = self.param.wRepeat?current%self.data.count:current;
            self.bannerControl.currentPage =  index;
            NSInteger itemsCount = [self.myCollectionV numberOfItemsInSection:0];
            NSInteger showIndex = MIN(itemsCount-1, MAX(0, current));
            NSInteger hideIndex = fade.right?MAX(showIndex-1, 0):MIN(showIndex+1, itemsCount-1);
            NSIndexPath *showIndexPath = [NSIndexPath indexPathForRow:showIndex inSection:0];
            NSIndexPath *hideIndexPath = [NSIndexPath indexPathForRow:hideIndex inSection:0];
            [self showAninationWithView:[self.myCollectionV cellForItemAtIndexPath:showIndexPath]];
            [self hideAninationWithView:[self.myCollectionV cellForItemAtIndexPath:hideIndexPath]];
        });
    }
}
//更新下划线位置
- (void)setUpSpecialFrame{
    if (!self.param.wSpecialStyle) return;
    if (!self.data.count) return;

    if (self.param.wSpecialStyle == SpecialStyleLine) {
        [UIView animateWithDuration:0.5 animations:^{
            CGRect rect = self.line.frame;
            rect.origin.x = (self.param.wRepeat?self.param.myCurrentPath%self.data.count:self.param.myCurrentPath)*rect.size.width;
            self.line.frame = rect;
        }];
    }
}

- (void)showAninationWithView:(UIView*)view{
    [view.layer removeAllAnimations];
    CABasicAnimation *scale = [CABasicAnimation animation];
    scale.keyPath = @"transform.scale";
    scale.fromValue = [NSNumber numberWithFloat:1.3];
    scale.toValue = [NSNumber numberWithFloat:1.0];

    CABasicAnimation *showViewAnn = [CABasicAnimation animationWithKeyPath:@"opacity"];
    showViewAnn.fromValue = [NSNumber numberWithFloat:0.5];
    showViewAnn.toValue = [NSNumber numberWithFloat:1];

    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[scale, showViewAnn];
    group.duration = 0.6;
    [view.layer addAnimation:group forKey:nil];
}
- (void)hideAninationWithView:(UIView*)view{
    [view.layer removeAllAnimations];
     CABasicAnimation *scale = [CABasicAnimation animation];
     scale.keyPath = @"transform.scale";
     scale.fromValue = [NSNumber numberWithFloat:1];
     scale.toValue = [NSNumber numberWithFloat:1.3];

     CABasicAnimation *showViewAnn = [CABasicAnimation animationWithKeyPath:@"opacity"];
     showViewAnn.fromValue = [NSNumber numberWithFloat:1];
     showViewAnn.toValue = [NSNumber numberWithFloat:0];

     CAAnimationGroup *group = [CAAnimationGroup animation];
     group.animations = @[scale, showViewAnn];
     group.duration = 0.6;
     [view.layer addAnimation:group forKey:nil];
}

- (UICollectionView *)myCollectionV{
    if (!_myCollectionV) {
        _myCollectionV = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:self.flowL];
        _myCollectionV.delegate = self;
        _myCollectionV.dataSource = self;
        _myCollectionV.showsVerticalScrollIndicator = NO;
        _myCollectionV.showsHorizontalScrollIndicator = NO;
        _myCollectionV.backgroundColor = [UIColor clearColor];
        _myCollectionV.decelerationRate = _param.wDecelerationRate;
    }
    return _myCollectionV;
}

- (WMZBannerControl *)bannerControl{
    if (!_bannerControl) {
        _bannerControl = [[WMZBannerControl alloc]initWithFrame:CGRectZero WithModel:_param];
    }
    return _bannerControl;
}

- (UIView *)line{
    if (!_line) {
        _line = [UIView new];
    }
    return _line;
}

- (void)dealloc{
    //单纯调用这里无法消除定时器
    [self cancelTimer];
}

//要配合这里调用
- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    if (!newSuperview &&self.timer) {
        // 销毁定时器
        [self.timer invalidate];
        self.timer = nil;
    }
}

@end

@implementation Collectioncell
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self){
        self.icon = [UIImageView new];
        self.icon.layer.masksToBounds = YES;
        [self.contentView addSubview:self.icon];
        self.icon.frame = self.contentView.bounds;
        self.contentView.layer.masksToBounds = YES;
    }
    return self;
}

- (void)setParam:(WMZBannerParam *)param{
    _param = param;
    self.icon.contentMode = param.wImageFill?UIViewContentModeScaleAspectFill:UIViewContentModeScaleToFill;
}
@end

@implementation CollectionTextCell
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self){
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.label = [UILabel new];
        self.label.font = [UIFont systemFontOfSize:17.0];
        self.label.textColor = [UIColor redColor];
        [self.contentView addSubview:self.label];
        self.label.frame = CGRectMake(10, 0, frame.size.width-20, frame.size.height);
    }
    return self;
}

- (void)setParam:(WMZBannerParam *)param{
    _param = param;
    self.label.textColor = self.param.wMarqueeTextColor;
}
@end
