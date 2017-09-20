//
//  ViewModel.h
//  BuyCar
//
//  Created by xfej on 17/4/6.
//  Copyright © 2017年 消费e家. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ViewModel : NSObject

- (void) getDataSourceSuceess:(void(^)(NSArray * dataArr))sucess failure:(void(^)(id errorCode))failure;

@end
