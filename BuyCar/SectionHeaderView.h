//
//  SectionHeaderView.h
//  BuyCar
//
//  Created by xfej on 17/4/6.
//  Copyright © 2017年 消费e家. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BusinessModel.h"

@interface SectionHeaderView : UITableViewHeaderFooterView

@property (nonatomic,retain) UIButton * selectSectionButton;

@property (nonatomic,retain) UIButton * editSectionCellButton;

@property (nonatomic,retain) UILabel * storeName;

@property (nonatomic,copy) BusinessModel * model;

@end
