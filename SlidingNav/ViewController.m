//
//  ViewController.m
//  SlidingNav
//
//  Created by Yun_He_Lee on 15/9/14.
//  Copyright (c) 2015年 lee. All rights reserved.
//

#import "ViewController.h"
#import "SlidingNavView.h"
#import "BaseTableViewVc.h"

@interface ViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong)SlidingNavView *houseNavView;
@property (nonatomic, strong)UIScrollView *scrollView;
@end

@implementation ViewController
{
    NSArray *titles;
    NSArray *titles_Vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
     titles = @[@"one", @"two",@"three"];
    [self addController];
    /** 添加子控制器 */
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.houseNavView];
    titles_Vc = self.childViewControllers;
    BaseTableViewVc *tableView = titles_Vc[0];
    [self.scrollView addSubview:tableView.view];
    //弱引用 防止循环引用
    __weak __typeof(self) weakSelf = self;
    self.houseNavView.slidingNavViewBlock = ^(NSInteger selectIndex) {
        //---回调
        [weakSelf setCurrentPage:selectIndex];
    };
}
- (void)addController
{
    for (int i=0 ; i<titles.count ;i++){
        BaseTableViewVc *vc1 = [[BaseTableViewVc alloc]initWithStyle:UITableViewStylePlain];
        [self addChildViewController:vc1];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//------懒加载
-(SlidingNavView *)houseNavView{
    if (_houseNavView ==nil) {
        
        _houseNavView = [[SlidingNavView alloc] initWithTitle:titles];
        [_houseNavView setFrame:CGRectMake(0, 20, self.view.bounds.size.width,60)];
        _houseNavView.layer.shadowColor = [UIColor grayColor].CGColor;
        [_houseNavView setBackgroundColor:[UIColor whiteColor]];
        _houseNavView.layer.shadowOffset = CGSizeMake(1.0f , 1.0f);
        _houseNavView.layer.shadowOpacity = 0.5f;
        _houseNavView.layer.shadowRadius = 1.0f;
    }
    return _houseNavView;
}

-(UIScrollView *)scrollView{
    if (_scrollView ==nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 40, self.view.frame.size.width, self.view.frame.size.height - 40- 64)];
        _scrollView.bounces = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.contentSize = CGSizeMake(self.view.frame.size.width * titles.count, self.view.frame.size.height - 80);
        _scrollView.delegate = self;
    }
    return _scrollView;
}

// 设置偏移
- (void)setCurrentPage:(NSInteger)currentPage {
    [UIView animateWithDuration:0.2 animations:^{
         self.scrollView.contentOffset = CGPointMake(self.view.frame.size.width * currentPage, 0);
         BaseTableViewVc *tableView = titles_Vc[currentPage];
        [self.scrollView addSubview:tableView.view];
    }];
    
}
//scrollView 代理
#pragma mark - UIScrollViewDelegate delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    self.houseNavView.currentOffset = scrollView.contentOffset;
}


@end
