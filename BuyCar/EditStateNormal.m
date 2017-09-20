//
//  EditStateNormal.m
//  BuyCar
//
//  Created by xfej on 17/4/7.
//  Copyright © 2017年 消费e家. All rights reserved.
//

#import "EditStateNormal.h"

@implementation EditStateNormal
{
    UILabel * lb_goodsName;
    UILabel * lb_goodsStyle;
    UILabel * lb_goodsPrice;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self =  [super initWithFrame:frame];
    
    if (self) {
        
        lb_goodsName = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,self.frame.size.width, 40)];
        lb_goodsName.numberOfLines = 2;
        lb_goodsName.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
        [self addSubview:lb_goodsName];
        
        lb_goodsStyle = [[UILabel alloc] initWithFrame:CGRectMake(lb_goodsName.frame.origin.x, CGRectGetMaxY(lb_goodsName.frame) + 10, lb_goodsName.frame.size.width, 20)];
        lb_goodsStyle.textColor = [UIColor lightGrayColor];
        lb_goodsStyle.font = [UIFont systemFontOfSize:15];
        [self addSubview:lb_goodsStyle];
        
        lb_goodsPrice = [[UILabel alloc] initWithFrame:CGRectMake(lb_goodsName.frame.origin.x, CGRectGetMaxY(lb_goodsStyle.frame) + 10, lb_goodsName.frame.size.width, 20)];
        lb_goodsPrice.textColor = [UIColor redColor];
        lb_goodsPrice.font = [UIFont boldSystemFontOfSize:16];
        [self addSubview:lb_goodsPrice];
    }
    
    return self;
}

- (void)setGoods_name:(NSString *)goods_name
{
    _goods_name = goods_name;
    lb_goodsName.text = goods_name;
}

- (void)setGoods_price:(NSString *)goods_price
{
    _goods_price = goods_price;
    lb_goodsPrice.text = goods_price;
}

- (void)setStyle:(NSString *)style
{
    _style = style;
    lb_goodsStyle.text = _style;
}

@end
