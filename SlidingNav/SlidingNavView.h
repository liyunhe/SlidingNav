//
//  SlidingNavView.h
//  SlidingNav
//
//  Created by Yun_He_Lee on 15/9/14.
//  Copyright (c) 2015年 lee. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SlidingNavViewBlock)(NSInteger selectIndex);

@interface SlidingNavView : UIView
@property (nonatomic, assign) CGPoint currentOffset;

@property (nonatomic, copy)SlidingNavViewBlock slidingNavViewBlock;

- (instancetype)initWithTitle:(NSArray *)titles;
@end
