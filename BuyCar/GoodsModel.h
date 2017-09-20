//
//  GoodsModel.h
//  BuyCar
//
//  Created by xfej on 17/4/6.
//  Copyright © 2017年 消费e家. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodsModel : NSObject

@property (nonatomic,copy) NSString * Goods_Name;

@property (nonatomic,copy) NSString * Goods_Style;

@property (nonatomic,assign) int Goods_Num;

@property (nonatomic,assign) int Goods_TotalNum;

@property (nonatomic,assign) float Goods_Price;

@property (nonatomic,copy) NSString * Goods_Image;

@property (nonatomic,assign) int selected;//进入选中状态

@property (nonatomic,assign) int cellEditState;//进入编辑状态

@end
