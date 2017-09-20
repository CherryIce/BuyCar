//
//  BuyCarViewCell.m
//  BuyCar
//
//  Created by xfej on 17/4/6.
//  Copyright © 2017年 消费e家. All rights reserved.
//

#import "BuyCarViewCell.h"

@implementation BuyCarViewCell
{
    __weak IBOutlet UIButton *subBtn;
    __weak IBOutlet UIButton *addBtn;
    __weak IBOutlet UILabel *goods_name;    
    __weak IBOutlet UILabel *goods_style;
    __weak IBOutlet UILabel *goods_price;
    __weak IBOutlet UILabel *goods_number;
    __weak IBOutlet UIImageView *goods_img;
}

- (void)setGoodsModel:(GoodsModel *)goodsModel
{
    _goodsModel = goodsModel;
    
    goods_name.text = _goodsModel.Goods_Name;
    
    goods_style.text = _goodsModel.Goods_Style;
    
    goods_number.text = [NSString stringWithFormat:@"%zd",_goodsModel.Goods_Num];
    
    goods_img.image = [UIImage imageNamed:_goodsModel.Goods_Image];
    
    if (_goodsModel.selected == 1)
        self.selectCellBtn.selected = YES;
    else
        self.selectCellBtn.selected = NO;
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)selectCellBtn:(UIButton *)sender {
    
    if (_cellButtonCallBack) {
        _cellButtonCallBack (sender.tag);
    }
    
}

@end
