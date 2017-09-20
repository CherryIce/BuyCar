//
//  BuyCarToolBar.h
//  BuyCar
//
//  Created by xfej on 17/4/6.
//  Copyright © 2017年 消费e家. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BuyCarToolBarCallBack)(UIButton * sender);

@interface BuyCarToolBar : UIView

@property (nonatomic,retain) UIButton * selectAllBtn;

@property (nonatomic,retain) UILabel * lb_totalPrice;

@property (nonatomic,retain) UIButton * balanceBtn;

@property (nonatomic,copy) BuyCarToolBarCallBack buyCarToolBarCallBack;

+ (NSMutableAttributedString *) transCurrentStr:(NSString *)currentString;

@end
