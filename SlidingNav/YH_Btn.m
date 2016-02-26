//
//  YH_Btn.m
//  SlidingNav
//
//  Created by Yun-He-Lee on 16/2/26.
//  Copyright © 2016年 lee. All rights reserved.
//

#import "YH_Btn.h"

@implementation YH_Btn{
    UIImageView *left_img;
    UIImageView *right_img;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (!self) return nil;
    left_img = [[UIImageView alloc]init];
    [left_img setImage:[UIImage imageNamed:@"HW_LEFT_ICON"]];
    [left_img setFrame:CGRectMake(0, 80/2-12, 10, 10)];
    [left_img setHidden:YES];
    [self addSubview:left_img];
    right_img = [[UIImageView alloc]init];
    [right_img setImage:[UIImage imageNamed:@"HW_RIGHT_ICON"]];
    [right_img setFrame:CGRectMake(320/3-15,80/2-12, 10, 10)];
    [right_img setHidden:YES];
    [self addSubview:right_img];
  
    return self;
}
- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    
}
-(void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    if (selected==YES) {
        [left_img setHidden:NO];
        [right_img setHidden:NO];
        [self setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }else{
        [left_img setHidden:YES];
        [right_img setHidden:YES];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

    }

}
@end
