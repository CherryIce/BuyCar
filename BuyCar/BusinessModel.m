//
//  BusinessModel.m
//  BuyCar
//
//  Created by xfej on 17/4/6.
//  Copyright © 2017年 消费e家. All rights reserved.
//

#import "BusinessModel.h"

#import "GoodsModel.h"

@implementation BusinessModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"BuyCars"]) {
        for (NSDictionary *d in value ) {
            GoodsModel * model = [[GoodsModel alloc]init];
            [model setValuesForKeysWithDictionary:d];
            [_BuyCarArray addObject:model];
        }
    }
    
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _BuyCarArray = [NSMutableArray array];
    }
    return self;
}


@end
