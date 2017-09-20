//
//  BuyCarCell.h
//  BuyCar
//
//  Created by xfej on 17/4/7.
//  Copyright © 2017年 消费e家. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GoodsModel.h"

typedef void (^ CarCellButtonClickCallBack)(NSInteger tag);

@interface BuyCarCell : UITableViewCell

@property (nonatomic,retain) UIButton * selectCellBtn;

@property (nonatomic,copy) CarCellButtonClickCallBack carCellButtonCallBack;

@property (nonatomic,copy) GoodsModel * goodsModel;

@end
