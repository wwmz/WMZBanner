

//
//  KuaiBaoCell.m
//  WMZBanner
//
//  Created by wmz on 2019/12/17.
//  Copyright © 2019 wmz. All rights reserved.
//

#import "KuaiBaoCell.h"

@implementation KuaiBaoCell
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self){
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.label = [UILabel new];
        self.label.font = [UIFont systemFontOfSize:17.0];
        self.label.textColor = [UIColor redColor];
        [self.contentView addSubview:self.label];
        self.label.frame = CGRectMake(10, 10, frame.size.width*0.15, frame.size.height-20);
        
        self.detailBtn = [UILabel new];
        self.detailBtn.font = [UIFont systemFontOfSize:17.0];
        self.detailBtn.frame = CGRectMake(frame.size.width*0.15, 10, frame.size.width*0.85,frame.size.height-20);
        [self.contentView addSubview:self.detailBtn];
    }
    return self;
}
@end
