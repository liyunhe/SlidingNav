
//
//  SlidingNavView.m
//  SlidingNav
//
//  Created by Yun_He_Lee on 15/9/14.
//  Copyright (c) 2015年 lee. All rights reserved.
//

#import "SlidingNavView.h"
#define kNavCursorHeight 1
#define kScreenWidth  [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height
@interface SlidingNavView ()

@property (nonatomic, strong) NSMutableArray *navBtnArray;
@property (nonatomic, strong) UIButton *currentSelectBtn;
@property (nonatomic, strong) UIView *navCursorView;


@end
@implementation SlidingNavView
- (instancetype)initWithTitle:(NSArray *)titles {
    self = [super init];
    if (!self) {
        return nil;
    }
    if (titles.count > 0) {
        // 导航按钮
        _navBtnArray = [[NSMutableArray alloc] init];
        for (int i = 0; i < titles.count; i++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.tag = i;
            button.titleLabel.font = [UIFont systemFontOfSize:14];
            [button setTitle:titles[i] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
            [button addTarget:self action:@selector(selectHouseAction:) forControlEvents:UIControlEventTouchUpInside];
            [_navBtnArray addObject:button];
            [self addSubview:button];
            
            // 默认第一个选中状态
            if ( i == 0) {
                button.selected = YES;
                button.userInteractionEnabled = NO;
                _currentSelectBtn = button;
            }
        }
        
        // 导航游标
        _navCursorView = [[UIView alloc] init];
        _navCursorView.backgroundColor =[UIColor redColor];
        [self addSubview:_navCursorView];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    NSInteger count = self.navBtnArray.count;
    for (int i = 0; i < count; i++) {
        UIButton *button = self.navBtnArray[i];
        CGFloat x = self.bounds.size.width / count * i;
        CGFloat y = 0;
        CGFloat w = self.bounds.size.width / count;
        CGFloat h = self.bounds.size.height - kNavCursorHeight;
        button.frame = CGRectMake(x, y, w, h);
    }
    
    _navCursorView.frame = CGRectMake(0, self.bounds.size.height - kNavCursorHeight, kScreenWidth / count, kNavCursorHeight);
}

- (void)setCurrentOffset:(CGPoint)currentOffset {
    _navCursorView.frame = CGRectMake(currentOffset.x / self.navBtnArray.count, self.bounds.size.height - kNavCursorHeight, kScreenWidth / self.navBtnArray.count, kNavCursorHeight);
    
    CGFloat currentPage = currentOffset.x / (kScreenWidth);
    NSInteger currentPage1 = currentPage;
    if (currentPage == currentPage1) {
        UIButton *currentBtn = [self.navBtnArray objectAtIndex:currentPage];
        currentBtn.selected = YES;
        currentBtn.userInteractionEnabled = NO;
        _currentSelectBtn.selected = NO;
        _currentSelectBtn.userInteractionEnabled = YES;
        _currentSelectBtn = currentBtn;
    }
}

- (void)selectHouseAction:(UIButton *)sender {
    if (self.slidingNavViewBlock) {
        NSInteger tag = sender.tag;
        for (int i = 0; i < self.navBtnArray.count; i++) {
            if (tag == i) {
                self.slidingNavViewBlock(i);
            }
        }
    }
}

@end