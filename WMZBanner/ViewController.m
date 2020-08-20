//
//  ViewController.m
//  WMZBanner
//
//  Created by wmz on 2019/9/6.
//  Copyright © 2019 wmz. All rights reserved.
//

#import "ViewController.h"
#import "WMZBannerView.h"
#import "MyCell.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *ta;
@property(nonatomic,strong)NSArray *taData;
@property(nonatomic,strong)NSArray *vcData;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UITableView *ta = [[UITableView alloc]initWithFrame:CGRectMake(0, 88, self.view.frame.size.width,self.view.frame.size.height-88) style:UITableViewStyleGrouped];
    [self.view addSubview:ta];
    ta.estimatedRowHeight = 100;
    if (@available(iOS 11.0, *)) {
        ta.estimatedSectionFooterHeight = 0.01;
        ta.estimatedSectionHeaderHeight = 0.01;
        ta.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    ta.dataSource = self;
    ta.delegate = self;
    self.ta = ta;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.taData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.font = [UIFont systemFontOfSize:14.0f];
    cell.textLabel.text = self.taData[indexPath.row];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Class class = NSClassFromString(self.vcData[indexPath.row]);
    [self.navigationController pushViewController:[class new] animated:YES];
}

- (NSArray *)taData{
    if (!_taData) {
        _taData = @[@"显示全部属性(+更新数据)",@"自定义pageControl",@"正常样式(横向+纵向)",@"天猫精灵样式",@"电商播报",@"自定义卡片样式",@"叠加样式",@"跑马灯",@"特殊样式(下划线)",@"特殊样式(淡入淡出-横向/纵向)",@"特殊样式(首个变大)"];
    }
    return _taData;
}

- (NSArray *)vcData{
    if (!_vcData) {
        _vcData = @[@"demoOne",@"DemoPageControl",@"demoNormal",@"DemoTianMao",@"DemoDianshang",@"DemoCard",@"DemoAdd",@"DemoMarqueen",@"SpecilDemo",@"FadeDemo",@"SpecilFirstScaleDemo"];
    }
    return _vcData;
}

@end
