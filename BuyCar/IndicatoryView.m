//
//  IndicatoryView.m
//  BuyCar
//
//  Created by xfej on 17/4/6.
//  Copyright © 2017年 消费e家. All rights reserved.
//

#import "IndicatoryView.h"

@implementation IndicatoryView
{
    UIActivityIndicatorView *indicatorView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [indicatorView removeFromSuperview];
        indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        indicatorView.frame = CGRectMake(0, 0, 80, 80);
        indicatorView.layer.cornerRadius = 5;
        indicatorView.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.5];
        indicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
        indicatorView.center = self.center;
        [indicatorView startAnimating];
        [self addSubview:indicatorView];
        [indicatorView startAnimating];
    }
    return self;
}

@end
