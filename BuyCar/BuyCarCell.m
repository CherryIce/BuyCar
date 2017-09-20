//
//  BuyCarCell.m
//  BuyCar
//
//  Created by xfej on 17/4/7.
//  Copyright © 2017年 消费e家. All rights reserved.
//

#import "BuyCarCell.h"

#import "EditCellView.h"

#import "EditStateNormal.h"

@implementation BuyCarCell
{
    UIImageView * goods_icon;
    
    EditCellView  * editCellView;
    
    EditStateNormal * editNormal;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        _selectCellBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _selectCellBtn.frame = CGRectMake(10, 45, 30, 30);
        _selectCellBtn.tag = 100;
        [_selectCellBtn setImage:[UIImage imageNamed:@"check_n"] forState:UIControlStateNormal];
        [_selectCellBtn setImage:[UIImage imageNamed:@"check_p"] forState:UIControlStateSelected];
        [_selectCellBtn addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_selectCellBtn];
        
        goods_icon = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_selectCellBtn.frame) + 10, 10, 100, 100)];
        [self.contentView addSubview:goods_icon];
        
        editNormal = [[EditStateNormal alloc] initWithFrame:CGRectMake(CGRectGetMaxX(goods_icon.frame) + 10, 10, [UIScreen mainScreen].bounds.size.width - CGRectGetMaxX(goods_icon.frame) - 20 , 100)];
        [self.contentView addSubview:editNormal];
        
        editCellView = [[EditCellView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(goods_icon.frame) + 10, 10, [UIScreen mainScreen].bounds.size.width - CGRectGetMaxX(goods_icon.frame) - 20 , 100)];
        [editCellView.btn_sub addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
        [editCellView.btn_add addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:editCellView];
        editCellView.hidden = YES;
        
    }
    return self;
}

- (void)selectButton:(UIButton *)sender
{
    if (_carCellButtonCallBack)
        _carCellButtonCallBack(sender.tag);
}

- (void)setGoodsModel:(GoodsModel *)goodsModel
{
    _goodsModel = goodsModel;
    
    editNormal.goods_name = _goodsModel.Goods_Name;
    
    editNormal.style = _goodsModel.Goods_Style;
    
    editNormal.goods_price = [NSString stringWithFormat:@"¥%.2f",_goodsModel.Goods_Price];
    
    goods_icon.image = [UIImage imageNamed:_goodsModel.Goods_Image];
    
    if (_goodsModel.selected == 1)
        self.selectCellBtn.selected = YES;
    else
        self.selectCellBtn.selected = NO;
    
    editCellView.goods_style = _goodsModel.Goods_Style;
    
    editCellView.goods_num = [NSString stringWithFormat:@"%zd",_goodsModel.Goods_Num];
    
    if (_goodsModel.cellEditState == 1)
    {
        editNormal.hidden = YES;
        editCellView.hidden = NO;
    }
    else
    {
        editNormal.hidden = NO;
        editCellView.hidden = YES;
    }
}

//即将布局子控件就会调用这个方法，我们在这里完成cell里面子控件的相对布局
- (void)layoutSubviews
{
    //重写这个方法，一定要记得手动调用父类方法。
    [super layoutSubviews];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
