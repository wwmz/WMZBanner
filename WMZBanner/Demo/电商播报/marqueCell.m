




//
//  marqueCell.m
//  WMZBanner
//
//  Created by wmz on 2019/12/17.
//  Copyright © 2019 wmz. All rights reserved.
//

#import "marqueCell.h"

@implementation marqueCell
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self){
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.label = [UILabel new];
        self.label.font = [UIFont systemFontOfSize:17.0];
        self.label.textColor = [UIColor blackColor];
        [self.contentView addSubview:self.label];
        self.label.frame = CGRectMake(10, 10, frame.size.width*0.7, frame.size.height-20);
        
        self.detailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.detailBtn.frame = CGRectMake(frame.size.width*0.7, 10, frame.size.width*0.3,frame.size.height-20);
        [self.contentView addSubview:self.detailBtn];
        [self.detailBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    }
    return self;
}
@end
