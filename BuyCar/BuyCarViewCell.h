//
//  BuyCarViewCell.h
//  BuyCar
//
//  Created by xfej on 17/4/6.
//  Copyright © 2017年 消费e家. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GoodsModel.h"

typedef void (^cellButtonClickCallBack)(NSInteger tag);

@interface BuyCarViewCell : UITableViewCell

- (IBAction)selectCellBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *selectCellBtn;

@property (nonatomic,copy) cellButtonClickCallBack cellButtonCallBack;

@property (nonatomic,copy) GoodsModel * goodsModel;

@end
