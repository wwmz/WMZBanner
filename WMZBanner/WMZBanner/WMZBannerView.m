

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
#define COUNT 500
@interface WMZBannerView()<UICollectionViewDelegate,UICollectionViewDataSource>{
    dispatch_source_t timer; //定时器
    BOOL beganDragging;
}
@property(strong,nonatomic)UICollectionView *myCollectionV;
@property(strong,nonatomic)WMZBannerFlowLayout *flowL ;
@property(strong,nonatomic)WMZBannerControl *bannerControl ;
@property(strong,nonatomic)UIImageView *bgImgView;
@property(strong,nonatomic)NSArray *data;
@property(strong,nonatomic)WMZBannerParam *param;
@end
@implementation WMZBannerView
- (instancetype)initConfigureWithModel:(WMZBannerParam *)param withView:(UIView*)parentView{
    if (self = [super init]) {
        self.param = param;
        if (parentView) {
            [parentView addSubview:self];
            self.param.wMasonry? [self mas_makeConstraints:self.param.wMasonry]:[self setFrame:self.param.wFrame];
            if (self.param.wMasonry) {
                [self.superview layoutIfNeeded];
            }
            self.data = [NSArray arrayWithArray:self.param.wData];
            [self setUp];
        }
    }
    return self;
}

- (void)updateUI{
    self.data = [NSArray arrayWithArray:self.param.wData];
    self.bannerControl.numberOfPages = self.data.count;
    [UIView animateWithDuration:0.0 animations:^{
        [self.myCollectionV reloadData];
    } completion:^(BOOL finished) {
        NSIndexPath *path = [NSIndexPath indexPathForRow:(self.param.wRepeat?COUNT*self.data.count/2:0)+self.param.wSelectIndex inSection:0];
        [self scrolToPath:path animated:NO];
        self.bannerControl.currentPage = self.param.wSelectIndex;
    }];
}

- (void)setUp{
    if (self.param.wItemSize.height == 0 || self.param.wItemSize.width == 0 ) {
        self.param.wItemSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
    }else if(self.param.wItemSize.width<self.frame.size.width/2){
        self.param.wItemSize = CGSizeMake(self.frame.size.width/2, self.param.wItemSize.height);
    }else if(self.param.wItemSize.height>self.frame.size.height){
        self.param.wItemSize = CGSizeMake(self.param.wItemSize.width, self.frame.size.height);
    }else if(self.param.wItemSize.width>self.frame.size.width){
        self.param.wItemSize = CGSizeMake(self.frame.size.width, self.param.wItemSize.height);
    }
    
    self.flowL = [[WMZBannerFlowLayout alloc] initConfigureWithModel:self.param];;

    [self addSubview:self.myCollectionV];
    [self.myCollectionV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_offset(0);
    }];
    self.myCollectionV.scrollEnabled = self.param.wCanFingerSliding;
    [self.myCollectionV registerClass:[Collectioncell class] forCellWithReuseIdentifier:NSStringFromClass([Collectioncell class])];
    if (self.param.wMyCellClassName) {
        [self.myCollectionV registerClass:NSClassFromString(self.param.wMyCellClassName) forCellWithReuseIdentifier:self.param.wMyCellClassName];
    }

    self.bannerControl = [[WMZBannerControl alloc]initWithFrame:CGRectMake(0, self.param.wItemSize.height-40, self.param.wItemSize.width, 30) WithModel:self.param];
    self.bannerControl.center = CGPointMake(self.center.x, self.bannerControl.center.y);
    self.bannerControl.numberOfPages = self.data.count;
    [self addSubview:self.bannerControl];
    self.bannerControl.hidden = self.param.wHideBannerControl;
    
    [UIView animateWithDuration:0.0 animations:^{
        [self.myCollectionV reloadData];
    } completion:^(BOOL finished) {
        NSIndexPath *path = [NSIndexPath indexPathForRow:(self.param.wRepeat?COUNT*self.data.count/2:0)+self.param.wSelectIndex inSection:0];
        if (self.param.wRepeat||self.param.wSelectIndex>0){
            [self scrolToPath:path animated:NO];
        }
         self.bannerControl.currentPage = self.param.wSelectIndex;
        if (self.param.wAutoScroll) {
            beganDragging = YES;
            [self createTimer];
        }else{
            beganDragging = NO;
            [self cancelTimer];
        }
    }];
    
    self.bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    self.myCollectionV.backgroundView = self.bgImgView;
    self.bgImgView.hidden = !self.param.wEffect;
    
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    effectView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [self.myCollectionV.backgroundView addSubview:effectView];


}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger index = self.param.wRepeat?(indexPath.row%self.data.count):indexPath.row;
    id dic = self.data[index];
    if (self.param.wMyCell) {
        return self.param.wMyCell([NSIndexPath indexPathForRow:index inSection:0], collectionView, dic,self.bgImgView,self.data);
    }else{
        //默认视图
        Collectioncell *cell = (Collectioncell *)[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([Collectioncell class]) forIndexPath:indexPath];
        
        cell.param = self.param;
        if ([dic isKindOfClass:[NSDictionary class]]) {
            [self setIconData:cell.icon withData:dic[@"icon"]];
            [self setIconData:self.bgImgView withData:dic[@"icon"]];
        }else{
            [self setIconData:cell.icon withData:dic];
            [self setIconData:self.bgImgView withData:dic];
        }
      return cell;
        
    }
}

- (void)setIconData:(UIImageView*)icon withData:(id)data{
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
    return  self.param.wRepeat?self.data.count*COUNT:self.data.count;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.param.wEventClick) {
        NSInteger index = self.param.wRepeat?(indexPath.row%self.data.count):indexPath.row;
        NSIndexPath *path = [NSIndexPath indexPathForRow:index inSection:0];
        id dic = self.data[index];
        self.param.wEventClick(dic, path);
    }
}



//滚动处理
- (void)scrolToPath:(NSIndexPath*)path animated:(BOOL)animated{
    if (path.row> (self.param.wRepeat?(self.data.count*COUNT-1):(self.data.count-1))) return;
    if (self.data.count==0) return;
    [self.myCollectionV scrollToItemAtIndexPath:path atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:animated];
    if (self.param.wRepeat && path.row>= (self.data.count*COUNT-1)) return;
    if (!self.param.wRepeat && path.row>= (self.data.count-1)) return;
    if(self.param.wContentOffsetX>0.5){
        self.myCollectionV.contentOffset = CGPointMake(self.myCollectionV.contentOffset.x-(self.param.wContentOffsetX-0.5)*self.myCollectionV.frame.size.width, self.myCollectionV.contentOffset.y);
    }else if(self.param.wContentOffsetX<0.5){
        self.myCollectionV.contentOffset = CGPointMake(self.myCollectionV.contentOffset.x+self.myCollectionV.frame.size.width *(0.5-self.param.wContentOffsetX), self.myCollectionV.contentOffset.y);
    }
}


//定时器
- (void)createTimer{
    if (!self.param.wAutoScroll) {
        [self cancelTimer]; return;
    }

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1  * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            dispatch_queue_t global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, global);
            dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, self.param.wAutoScrollSecond * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
            dispatch_source_set_event_handler(timer, ^{
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self autoScrollAction];
                        
                    });
                });
            });
            dispatch_resume(timer);
    });
}

//定时器方法
- (void)autoScrollAction{
    if (!beganDragging) return;
    NSIndexPath* currrentIndexPath = [self getCurrentIndexPath];
    NSIndexPath *currentIndexPathReset = [NSIndexPath indexPathForItem:currrentIndexPath.item inSection:0];
    NSInteger nextItem = currentIndexPathReset.item ;
    //屏幕只显示一个 要获取下一个需要加1
    nextItem+=1;
    if (self.param.wRepeat&& nextItem == self.data.count*COUNT) {
        nextItem = 0;
        NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:nextItem inSection:0];
        [self scrolToPath:nextIndexPath animated:NO];
        return;
    }
    else if(!self.param.wRepeat&& nextItem == self.data.count){
        [self cancelTimer];
        return;
    }
    NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:nextItem inSection:0];
    [self scrolToPath:nextIndexPath animated:YES];
}

//定时器销毁
- (void)cancelTimer{
    if (timer) {
        dispatch_source_cancel(timer);
    }
}

//开始拖动
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    beganDragging = NO;
    [self cancelTimer];
}

//加速度结束
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    beganDragging = YES;
    [self createTimer];
}


//拖动结束
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (!decelerate) {
        beganDragging = NO;;
    }
}


//滑动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSIndexPath* currrentIndexPath = [self getCurrentIndexPath];
    self.bannerControl.currentPage = (int)(currrentIndexPath.item%self.data.count);
}

//获取当前显示的indexPath
- (NSIndexPath*)getCurrentIndexPath{
    NSArray *sortedIndexPaths = [[self.myCollectionV indexPathsForVisibleItems] sortedArrayUsingSelector:@selector(compare:)];
    NSIndexPath* currrentIndexPath = nil;
//    NSLog(@"%@",sortedIndexPaths);
    if (sortedIndexPaths.count>2) {
        currrentIndexPath = sortedIndexPaths[1];
    }else if(sortedIndexPaths.count == 2){
        if (self.param.wContentOffsetX>0.5) {
            currrentIndexPath = sortedIndexPaths.lastObject;
        }else if(self.param.wContentOffsetX<0.5){
            currrentIndexPath = sortedIndexPaths.firstObject;
        }else{
             currrentIndexPath = sortedIndexPaths.lastObject;
        }
        NSIndexPath* last = sortedIndexPaths.lastObject;
        if (last.row == (self.param.wRepeat?(self.data.count*COUNT-1):(self.data.count-1)) ) {
            currrentIndexPath = last;
        }
    }else{
        currrentIndexPath = sortedIndexPaths.lastObject;
    }
//    NSLog(@"%@",currrentIndexPath);
    return currrentIndexPath;
}

- (UICollectionView *)myCollectionV{
    if (!_myCollectionV) {
        _myCollectionV = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:_flowL];
        _myCollectionV.delegate = self;
        _myCollectionV.dataSource = self;
        _myCollectionV.showsVerticalScrollIndicator = NO;
        _myCollectionV.showsHorizontalScrollIndicator = NO;
        _myCollectionV.backgroundColor = [UIColor clearColor];
        _myCollectionV.bounces = NO;
//        _myCollectionV.alwaysBounceVertical = YES;
//        _myCollectionV.alwaysBounceHorizontal = YES;
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

- (void)dealloc{
    [self cancelTimer];
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
        [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        self.contentView.layer.masksToBounds = YES;
        self.contentView.layer.cornerRadius = 5;
    }
    return self;
}

- (void)setParam:(WMZBannerParam *)param{
    _param = param;
    self.icon.contentMode = param.wImageFill?UIViewContentModeScaleAspectFill:UIViewContentModeScaleToFill;
}
@end
