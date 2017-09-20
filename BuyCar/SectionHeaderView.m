//
//  SectionHeaderView.m
//  BuyCar
//
//  Created by xfej on 17/4/6.
//  Copyright © 2017年 消费e家. All rights reserved.
//

#import "SectionHeaderView.h"

@implementation SectionHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.contentView.backgroundColor= [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0f];
        _selectSectionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _selectSectionButton.frame = CGRectMake(5,10,20,20);
        [_selectSectionButton setBackgroundImage:[UIImage imageNamed:@"check_n"] forState:UIControlStateNormal];
        [_selectSectionButton setBackgroundImage:[UIImage imageNamed:@"check_p"] forState:UIControlStateSelected];
        [self.contentView addSubview:_selectSectionButton];
        
        self.storeName = [[UILabel alloc] initWithFrame:CGRectMake(30, 5, 100, 30)];
        self.storeName.textAlignment = NSTextAlignmentLeft;
        self.storeName.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:self.storeName];
        
        
        _editSectionCellButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _editSectionCellButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 45,10,40,20);
        [_editSectionCellButton setTitle:@"编辑" forState:UIControlStateNormal];
        _editSectionCellButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_editSectionCellButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _editSectionCellButton.titleLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_editSectionCellButton];

    }
    
    return self;
}

- (void)setModel:(BusinessModel *)model
{
    _model = model;
    
    _storeName.text = model.UserName;
}

@end
