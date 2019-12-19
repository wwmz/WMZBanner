



//
//  TianMaoCell.m
//  WMZBanner
//
//  Created by wmz on 2019/12/16.
//  Copyright © 2019 wmz. All rights reserved.
//

#import "TianMaoCell.h"

@implementation TianMaoCell
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self){
        self.backImage = [UIImageView new];
        [self.contentView addSubview:self.backImage];
        self.backImage.frame = CGRectMake(0, 0, frame.size.width, frame.size.height*0.85);
        
        
        self.bottomView = [UIView new];
        [self.contentView addSubview:self.bottomView];
         self.bottomView.frame = CGRectMake(0, CGRectGetMaxY(self.backImage.frame), frame.size.width, frame.size.height*0.15);
        self.bottomView.backgroundColor = BannerColor(0x035eef);
        
        
        self.topLa = [UILabel new];
        self.topLa.text = @"最新上线";
        self.topLa.textAlignment = NSTextAlignmentCenter;
        self.topLa.frame = CGRectMake(20, 20, 80, 40);
        self.topLa.layer.masksToBounds = YES;
        self.topLa.layer.cornerRadius = 15;
        self.topLa.textColor = [UIColor whiteColor];
        [self.backImage addSubview:self.topLa];
        self.topLa.backgroundColor = BannerColor(0x035eef);
        
        self.titleLa = [UILabel new];
        self.titleLa.text = @"“天猫精灵,每天晚安闹钟”";
        self.titleLa.frame = CGRectMake(20, CGRectGetMaxY(self.topLa.frame)+20, frame.size.width - 40,50);
        self.titleLa.numberOfLines = 2;
        self.titleLa.textColor = [UIColor whiteColor];
        self.titleLa.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
        [self.backImage addSubview:self.titleLa];
        
        self.textLa = [UILabel new];
        self.textLa.text = @"真设美团晚安闹钟最高可得88元";
        self.textLa.textColor = BannerColor(0x666666);
        self.textLa.frame = CGRectMake(20, CGRectGetMaxY(self.titleLa.frame)+10, frame.size.width - 40,40);
        self.textLa.numberOfLines = 2;
        self.textLa.font = [UIFont systemFontOfSize:14.0f];
        [self.backImage addSubview:self.textLa];
        
        self.typeLa = [UILabel new];
        self.typeLa.text = @"先设置后抽奖";
        self.typeLa.textColor = [UIColor whiteColor];
        self.typeLa.frame = CGRectMake(20, 10, self.bottomView.frame.size.width*0.7,self.bottomView.frame.size.height-20);
        [self.bottomView addSubview:self.typeLa];
        
        self.detailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.detailBtn.backgroundColor = BannerColor(0x0d50c1);
        self.detailBtn.frame = CGRectMake(self.bottomView.frame.size.width*0.7, 10, self.bottomView.frame.size.width*0.3,self.bottomView.frame.size.height-20);
        [self.detailBtn setTitle:@"详情" forState:UIControlStateNormal];
        self.detailBtn.layer.masksToBounds = YES;
        self.detailBtn.layer.cornerRadius = (self.bottomView.frame.size.height-20)/2;
        [self.bottomView addSubview:self.detailBtn];
        [self.detailBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        
    }
    return self;
}

@end
