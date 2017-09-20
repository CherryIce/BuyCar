//
//  ViewModel.m
//  BuyCar
//
//  Created by xfej on 17/4/6.
//  Copyright © 2017年 消费e家. All rights reserved.
//

#import "ViewModel.h"

#import "BusinessModel.h"

@implementation ViewModel

- (void) getDataSourceSuceess:(void(^)(NSArray * dataArr))sucess failure:(void(^)(id errorCode))failure
{
//    
//    @property (nonatomic,copy) NSString * Goods_Name;
//    
//    @property (nonatomic,copy) NSString * Goods_Style;
//    
//    @property (nonatomic,assign) int Goods_Num;
//    
//    @property (nonatomic,assign) int Goods_TotalNum;
//    
//    @property (nonatomic,assign) float Goods_Price;
//    
//    @property (nonatomic,copy) NSString * Goods_Image;
//    
//    @property (nonatomic,assign) int selected;
    //模拟请求
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(),^
    {
        NSArray * randName = @[
                              @[@"商家1",@[@{@"Goods_Name":@"商品1",@"Goods_Style":@"颜色:粉色,尺寸:40",@"Goods_Image":@"goods_img",@"Goods_Num":@(10),@"Goods_TotalNum":@(20),@"Goods_Price":@(100),@"selected":@(0)},@{@"Goods_Name":@"商品2",@"Goods_Style":@"颜色:粉色,尺寸:40",@"Goods_Image":@"goods_img",@"Goods_Num":@(10),@"Goods_TotalNum":@(20),@"Goods_Price":@(100),@"selected":@(0)},@{@"Goods_Name":@"商品3",@"Goods_Style":@"颜色:粉色,尺寸:40",@"Goods_Image":@"goods_img",@"Goods_Num":@(10),@"Goods_TotalNum":@(20),@"Goods_Price":@(100),@"selected":@(0)}]],
                               @[@"商家2",@[@{@"Goods_Name":@"商品1",@"Goods_Style":@"颜色:粉色,尺寸:40",@"Goods_Image":@"goods_img",@"Goods_Num":@(10),@"Goods_TotalNum":@(20),@"Goods_Price":@(100),@"selected":@(0)},@{@"Goods_Name":@"商品2",@"Goods_Style":@"颜色:粉色,尺寸:40",@"Goods_Image":@"goods_img",@"Goods_Num":@(10),@"Goods_TotalNum":@(20),@"Goods_Price":@(100),@"selected":@(0)},@{@"Goods_Name":@"商品3",@"Goods_Style":@"颜色:粉色,尺寸:40",@"Goods_Image":@"goods_img",@"Goods_Num":@(10),@"Goods_TotalNum":@(20),@"Goods_Price":@(100),@"selected":@(0)}]],
                               @[@"商家3",@[@{@"Goods_Name":@"商品1",@"Goods_Style":@"颜色:粉色,尺寸:40",@"Goods_Image":@"goods_img",@"Goods_Num":@(10),@"Goods_TotalNum":@(20),@"Goods_Price":@(100),@"selected":@(0)},@{@"Goods_Name":@"商品2",@"Goods_Style":@"颜色:粉色,尺寸:40",@"Goods_Image":@"goods_img",@"Goods_Num":@(10),@"Goods_TotalNum":@(20),@"Goods_Price":@(100),@"selected":@(0)},@{@"Goods_Name":@"商品3",@"Goods_Style":@"颜色:粉色,尺寸:40",@"Goods_Image":@"goods_img",@"Goods_Num":@(10),@"Goods_TotalNum":@(20),@"Goods_Price":@(100),@"selected":@(0)}]]];
        NSMutableArray * buinessArr = [NSMutableArray array];
        for (int i = 0; i < randName.count; i++)
        {
            NSDictionary * businessDic = @{@"UserName":randName[i][0],@"BuyCars":randName[i][1]};
            BusinessModel * model = [[BusinessModel alloc] init];
            [model setValuesForKeysWithDictionary:businessDic];
            [buinessArr addObject:model];
        }
        
        if (sucess) {
            sucess(buinessArr);
        }
        
        
        if (failure) {
            failure(@"error");
        }
    });
}

@end
