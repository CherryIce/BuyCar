//
//  EditCellView.m
//  BuyCar
//
//  Created by xfej on 17/4/7.
//  Copyright © 2017年 消费e家. All rights reserved.
//

#import "EditCellView.h"

#import "GoodsModel.h"

@implementation EditCellView
{
    UILabel * lb_style;
    UILabel * lb_goods_num;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self =  [super initWithFrame:frame];
    if (self)
    {
        _btn_sub =  [EditCellView initWithFrame:CGRectMake(0, 10, 30, 30) title:@"－" tag:99]; [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_btn_sub];
        
        _btn_add =  [EditCellView initWithFrame:CGRectMake(self.frame.size.width - 30, 10, 30, 30) title:@"＋" tag:101];
        [self addSubview:_btn_add];
        
        lb_goods_num = [[UILabel alloc] initWithFrame:CGRectMake(30, 10, self.frame.size.width - 60, 30)];
        lb_goods_num.textAlignment = NSTextAlignmentCenter;
        [self addSubview:lb_goods_num];
        
        lb_style = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_btn_sub.frame) + 10, self.frame.size.width, 40)];
        lb_style.textColor = [UIColor lightGrayColor];
        lb_style.font = [UIFont systemFontOfSize:15];
        [self addSubview:lb_style];
        
    }
    return self;
}

+ (UIButton *) initWithFrame:(CGRect)frame title:(NSString *) title tag:(NSInteger) tag
{
    UIButton * button =  [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    button.tag = tag;
    button.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    button.layer.cornerRadius = 2;
    button.layer.borderWidth = 0.5;
    button.layer.borderColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1].CGColor;
    return button;
}

- (void)setGoods_num:(NSString *)goods_num
{
    _goods_num = goods_num;
    lb_goods_num.text = _goods_num;
}

- (void)setGoods_style:(NSString *)goods_style
{
    _goods_style = goods_style;
    lb_style.text = _goods_style;
}

@end
