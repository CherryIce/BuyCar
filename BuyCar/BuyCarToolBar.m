//
//  BuyCarToolBar.m
//  BuyCar
//
//  Created by xfej on 17/4/6.
//  Copyright © 2017年 消费e家. All rights reserved.
//

#import "BuyCarToolBar.h"

@implementation BuyCarToolBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.selectAllBtn = [BuyCarToolBar initButtonWithRect:CGRectMake(10,(49-20)/2.0, 60, 20) name:@"全选" bgColor:nil titleColor:[UIColor blackColor] tagNum:102 image:nil target:self action:@selector(selectAllaction:)];
        [self.selectAllBtn setImage:[UIImage imageNamed:@"check_n"] forState:UIControlStateNormal];
        [self.selectAllBtn setImage:[UIImage imageNamed:@"check_p"] forState:UIControlStateSelected];
        self.selectAllBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        //_selectAllBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
        [_selectAllBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 40)];
        _selectAllBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -40, 0, 0);
        [self addSubview:self.selectAllBtn];
        
        _lb_totalPrice = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_selectAllBtn.frame) + 5, 4.5, [UIScreen mainScreen].bounds.size.width - CGRectGetMaxX(_selectAllBtn.frame) - 10 - 60, 40)];
        _lb_totalPrice.font = [UIFont systemFontOfSize:15];
        _lb_totalPrice.numberOfLines = 2;
        _lb_totalPrice.attributedText = [BuyCarToolBar transCurrentStr:[NSString stringWithFormat:@"总计:¥0.00元"]];
        [self addSubview:_lb_totalPrice];
        
        _balanceBtn = [BuyCarToolBar initButtonWithRect:CGRectMake([UIScreen mainScreen].bounds.size.width - 60, 0, 60, 49) name:@"结算" bgColor:[UIColor orangeColor] titleColor:[UIColor whiteColor] tagNum:103 image:nil target:self action:@selector(selectAllaction:)];
        _balanceBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:self.balanceBtn];

    }
    return self;
}

- (void)selectAllaction:(UIButton *)sender
{
    if (_buyCarToolBarCallBack)
        _buyCarToolBarCallBack(sender);
}

+ (UIButton *) initButtonWithRect:(CGRect)frame name:(NSString *)name bgColor:(UIColor *)bgColor titleColor:(UIColor *)titleColor tagNum:(NSInteger)tag image:(UIImage *)image target:(id)target action:(SEL)action
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setTitle:name forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    button.backgroundColor = bgColor;
    button.tag = tag;
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

+ (NSMutableAttributedString *) transCurrentStr:(NSString *)currentString;
{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:currentString];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(3,str.length - 3)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(3,str.length - 3)];
    return str;
}

@end
