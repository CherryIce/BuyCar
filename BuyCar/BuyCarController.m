//
//  BuyCarController.m
//  BuyCar
//
//  Created by xfej on 17/4/7.
//  Copyright © 2017年 消费e家. All rights reserved.
//

#import "BuyCarController.h"

#import "BuyCarCell.h"

#import "SectionHeaderView.h"

#import "BuyCarToolBar.h"

#import "IndicatoryView.h"

#import "ViewModel.h"

//设备高度
#define KScreenHeight [UIScreen mainScreen].bounds.size.height
//设备的宽度
#define KScreenWidth  [UIScreen mainScreen].bounds.size.width

@interface BuyCarController ()<UITableViewDelegate,UITableViewDataSource>
{
    BuyCarToolBar * buyCarToolBar;
    CGFloat allPrice;
    IndicatoryView * loading;
    
    BOOL editbool;
    SectionHeaderView * sectionHeader;
}

@property (nonatomic,strong) UITableView * buyCarTableView;

@property (nonatomic,strong) NSMutableArray * dataSource;

@property (nonatomic, strong) NSMutableArray * sectionSelect;//记录当前section是否选中

@property (nonatomic, strong) NSMutableArray * selectArray;//记录选中的indexPath (indexPath.section,indexPath.row)

@property (nonatomic,strong) NSMutableArray * deleteArray;

@end

@implementation BuyCarController

- (UITableView *)buyCarTableView
{
    if (!_buyCarTableView)
    {
        _buyCarTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, KScreenWidth, KScreenHeight - 64 - 49) style:UITableViewStyleGrouped];
        _buyCarTableView.backgroundColor = [UIColor whiteColor];
        _buyCarTableView.delegate = self;
        _buyCarTableView.dataSource = self;
        [_buyCarTableView registerClass:[BuyCarCell class] forCellReuseIdentifier:@"Cell"];
        [_buyCarTableView registerClass:[SectionHeaderView class] forHeaderFooterViewReuseIdentifier:@"SectionHeader"];
        _buyCarTableView.showsVerticalScrollIndicator = NO;
        _buyCarTableView.tableFooterView = [[UIView alloc] init];
        [self.view addSubview:_buyCarTableView];
    }
    return _buyCarTableView;
}

- (NSMutableArray *)dataSource
{
    if (!_dataSource)
        _dataSource = [NSMutableArray array];
    return _dataSource;
}

- (NSMutableArray *)selectArray
{
    if (!_selectArray)
        _selectArray = [NSMutableArray array];
    return _selectArray;
}

- (NSMutableArray *)deleteArray
{
    if (!_deleteArray)
        _deleteArray = [NSMutableArray array];
    return _deleteArray;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"贼不爽";
    
    [self setIndicatorView];
    
    ViewModel * viewModel = [[ViewModel alloc] init];
    [viewModel getDataSourceSuceess:^(NSArray *dataArr) {
        [loading removeFromSuperview];
        self.dataSource = [dataArr mutableCopy];
        [self sectionUnselect:self.dataSource.count];
        [self.buyCarTableView reloadData];
        [self setBootmView];
    } failure:^(id errorCode) {
        [loading removeFromSuperview];
    }];
    
    
}

#pragma mark 点击section编辑按钮
- (void) editClick:(UIButton *) sender
{
    if (editbool)
    {
        [self editBtn:editbool section:sender.tag - 1000];
        editbool = NO;
    }
    else
    {
        [self editBtn:editbool section:sender.tag - 1000];
        editbool = YES;
    }
    [sectionHeader.editSectionCellButton setTitle:editbool?@"完成":@"编辑" forState:UIControlStateNormal];
}

- (void) editBtn:(BOOL) isbool section:(NSInteger)section
{
    
    BusinessModel * model = self.dataSource[section];
        
    if (!isbool)
    {
        for (GoodsModel * goods in model.BuyCarArray)
        {
            goods.cellEditState = 1;
        }
    }
    else
    {
        for (GoodsModel * goods in model.BuyCarArray)
        {
                goods.cellEditState = 0;
        }
    }
    //单独刷新某个section
    NSIndexSet * indexSet = [[NSIndexSet alloc] initWithIndex:section];
    [self.buyCarTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
}

- (void) setIndicatorView
{
    loading = [[IndicatoryView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
    [[UIApplication sharedApplication].keyWindow addSubview:loading];
}

- (void) setBootmView
{
    [buyCarToolBar removeFromSuperview];
    buyCarToolBar = [[BuyCarToolBar alloc] initWithFrame:CGRectMake(0, KScreenHeight - 49, KScreenWidth, 49)];
    buyCarToolBar.backgroundColor = [UIColor whiteColor];
    __weak typeof(self) weakSelf = self;
    buyCarToolBar.buyCarToolBarCallBack = ^ (UIButton * sender)
    {
        if (sender.tag == 102)
            [weakSelf selectAllaction:sender];
        else
            [weakSelf showAlertViewWithMessage:@"oh~no~"];
    };
    
    [self.view addSubview:buyCarToolBar];
}

#pragma mark 默认表头没有被选中
- (void) sectionUnselect:(NSInteger)count
{
    if (_sectionSelect.count == 0)
    {
        _sectionSelect = [NSMutableArray array];
        for (int i = 0; i < count; i++)
        {
            [_sectionSelect addObject:@0];
        }
    }
}

#pragma mark <UITableViewDelegate,UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    BusinessModel * businessModel = self.dataSource[section];
    return businessModel.BuyCarArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BusinessModel * store = self.dataSource[indexPath.section];
    GoodsModel * good  = store.BuyCarArray[indexPath.row];
    
    BuyCarCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (!cell) {
        cell = [[BuyCarCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];//点击cell颜色不变
    
    cell.carCellButtonCallBack = ^ (NSInteger tag) {
        switch (tag) {
            case 99://-方法
            {
                if (good.Goods_Num != 1)
                    good.Goods_Num --;
                [self.buyCarTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                if (cell.selectCellBtn.selected == YES)
                    [self CalculationPrice];
            }
                break;
            case 101://+方法
            {
                if (good.Goods_Num < good.Goods_TotalNum)
                    good.Goods_Num ++;
                else
                {
                    good.Goods_Num = good.Goods_TotalNum;
                    [self showAlertViewWithMessage:@"库存不足"];
                }
                //单独刷新某行
                [self.buyCarTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                if (cell.selectCellBtn.selected == YES)
                    [self CalculationPrice];
            }
                break;
            case 100:
            {
                [self cellClickWithIndexPath:indexPath];
            }
                break;
            default:
                break;
        }
    };
    cell.goodsModel = good;
    return cell;
}

#pragma mark 点击选择商品按钮
- (void) cellClickWithIndexPath:(NSIndexPath *)indexPath
{
    if (self.dataSource.count != 0)
    {
        BusinessModel * model = self.dataSource[indexPath.section];
        GoodsModel * good = model.BuyCarArray[indexPath.row];
        if (good.selected == 1)
        {
            good.selected = 0;
            [self.selectArray removeObject:indexPath];
        }
        else
        {
            good.selected = 1;
            [self.selectArray addObject:indexPath];
        }
        //是否选中表头
        [self headerViewIsSelect];
        //是否选中全部
        [self selectAllButtonIsSelect];
        //单独刷新某个section
        NSIndexSet * indexSet = [[NSIndexSet alloc] initWithIndex:indexPath.section];
        [self.buyCarTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
        [self CalculationPrice];
    }
}

#pragma mark 判断 如果全选了 那么全选按钮就变为选中 反之，则不选中
- (void)selectAllButtonIsSelect
{
    NSUInteger count = 0;
    for (NSUInteger i = 0; i < self.dataSource.count; i++)
    {
        BusinessModel * model = self.dataSource[i];
        count += model.BuyCarArray.count;
    }
    if (self.selectArray.count == count)
        buyCarToolBar.selectAllBtn.selected = YES;
    else
        buyCarToolBar.selectAllBtn.selected = NO;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self showAlertViewWithMessage:@"别闹～"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
   sectionHeader = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"SectionHeader"];
    if (!sectionHeader)
        sectionHeader = [[SectionHeaderView alloc] initWithReuseIdentifier:@"header"];
    
    BusinessModel * model = self.dataSource[section];
    
    sectionHeader.model = model;
    
    sectionHeader.selectSectionButton.tag = section + 100;
    sectionHeader.editSectionCellButton.tag = section + 1000;
    NSNumber *num = self.sectionSelect[section];
    //1为选中 0为未选中
    if ([num isEqualToNumber:@1])
        sectionHeader.selectSectionButton.selected = YES;
    else
        sectionHeader.selectSectionButton.selected = NO;
    
    [sectionHeader.selectSectionButton addTarget:self action:@selector(headerButtonOnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [sectionHeader.editSectionCellButton addTarget:self action:@selector(editClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return sectionHeader;
}

#pragma mark ---->点击section
- (void) headerButtonOnClick:(UIButton *)button
{
    NSInteger section = button.tag - 100;
    if (!button.selected)
    {
        BusinessModel * model = self.dataSource[section];
        for (NSUInteger i = 0; i < model.BuyCarArray.count ; i++)
        {
            NSIndexPath * indexPath = [NSIndexPath indexPathForRow:i inSection:section];
            GoodsModel * goods = model.BuyCarArray[indexPath.row];
            if (![self.selectArray containsObject:indexPath])
            {
                goods.selected = 1;
                [self.selectArray addObject:indexPath];
            }
        }
        [self.sectionSelect replaceObjectAtIndex:section withObject:@1];
    }
    else
    {
        NSMutableArray *arrM = [NSMutableArray arrayWithArray:self.selectArray];
        NSMutableIndexSet *indexSet = [[NSMutableIndexSet alloc]init];
        BusinessModel * model = self.dataSource[section];
        for (int i = 0 ; i < arrM.count ; i++)
        {
            NSIndexPath *indexPath = arrM[i];
            GoodsModel * goods = model.BuyCarArray[indexPath.row];
            if (indexPath.section == section)
            {
                goods.selected = 0;
                [indexSet addIndex:i];
            }
        }
        [self.selectArray removeObjectsAtIndexes:indexSet];
        [self.sectionSelect replaceObjectAtIndex:section withObject:@0];
    }
    [self selectAllButtonIsSelect];
    [self.buyCarTableView reloadData];
    [self CalculationPrice];
}

#pragma mark 判断是否选中的商品数已经达到商家的购买数，达到则连商家(section)一起选中
- (void)headerViewIsSelect
{
    for (int j = 0 ; j < self.sectionSelect.count; j++ )
    {
        NSInteger count = 0;
        for (int i = 0; i < self.selectArray.count ; i ++)
        {
            NSIndexPath *indexPath = self.selectArray[i];
            if (indexPath.section == j)
                count++;
        }
        BusinessModel * model = self.dataSource[j];
        if (count == model.BuyCarArray.count)
            [self.sectionSelect replaceObjectAtIndex:j withObject:@1];
        else
            [self.sectionSelect replaceObjectAtIndex:j withObject:@0];
    }
}

#pragma mark ---->全选
-(void)selectAllaction:(UIButton *)sender
{
    sender.selected = !sender.selected;
    if (sender.selected)
    {
        for (NSUInteger i = 0; i < self.dataSource.count; i++)
        {
            BusinessModel * model = self.dataSource[i];
            for (NSUInteger j = 0; j < model.BuyCarArray.count; j++)
            {
                NSIndexPath * indexPath = [NSIndexPath indexPathForRow:j inSection:i];
                GoodsModel * goods = model.BuyCarArray[indexPath.row];
                if (![self.selectArray containsObject:indexPath])
                {
                    goods.selected = 1;
                    [self.selectArray addObject:indexPath];
                }
            }
            [self.sectionSelect replaceObjectAtIndex:i withObject:@1];
        }
    }
    else
    {
        for (NSUInteger k = 0; k < self.dataSource.count; k++)
        {
            BusinessModel * model = self.dataSource[k];
            for (GoodsModel * goods in model.BuyCarArray) {
                goods.selected = 0;
            }
            [self.selectArray removeAllObjects];
            [self.sectionSelect replaceObjectAtIndex:k withObject:@0];
        }
    }
    [self.buyCarTableView reloadData];
    [self CalculationPrice];
}

#pragma mark --->计算价格
-(void)CalculationPrice
{
    allPrice = 0.0;
    if (self.dataSource.count != 0 && self.selectArray.count != 0)
    {
        //判断如果是选中的商品，就计算价格(单价 * 商品数量)
        for (NSIndexPath * indexPath in self.selectArray)
        {
            BusinessModel * model = self.dataSource[indexPath.section];
            GoodsModel * shop = model.BuyCarArray[indexPath.row];
            allPrice += shop.Goods_Price * shop.Goods_Num;
        }
        //给总价赋值
        buyCarToolBar.lb_totalPrice.attributedText = [BuyCarToolBar transCurrentStr:[NSString stringWithFormat:@"总计:￥%.2f",allPrice]];
    }
    else
    {
        //给总价赋值
        buyCarToolBar.lb_totalPrice.attributedText =  buyCarToolBar.lb_totalPrice.attributedText = [BuyCarToolBar transCurrentStr:[NSString stringWithFormat:@"总计:￥%.2f",allPrice]];
    }
}

#pragma mark ----->单行本地删除
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //code..... 删除单个cell,如果这是当前section的最后一个,则section也被删除
    [self.deleteArray addObject:indexPath];
    [self deleteMethodWithArr:self.deleteArray];
    for (int index = 0; index < self.selectArray.count; index ++)
    {
        NSIndexPath * indexP = self.selectArray[index];
        BusinessModel * model = self.dataSource[indexP.section];
        for (GoodsModel * shop in model.BuyCarArray) {
            shop.selected = 0;
        }
    }
    [self.selectArray removeAllObjects];
    if (self.dataSource.count == 0)
    {
        return;
    }
    else
    {
        BusinessModel * model = self.dataSource[indexPath.section];
        if (model.BuyCarArray.count == 0)
            [self.sectionSelect removeObjectAtIndex:0];
        for (int i = 0; i < self.sectionSelect.count; i++) {
            [self.sectionSelect replaceObjectAtIndex:i withObject:@0];
        }
        buyCarToolBar.selectAllBtn.selected = NO;
        [self CalculationPrice];
    }
}

#pragma mark ---->网络删除
- (void)deleteMethodWithArr:(NSMutableArray *)arr
{
    //删除完成之前还要把数据上传服务器,服务器删除完成之后请求成功才能进行删除操作
    if (arr.count == 0 || self.dataSource.count == 0)
    {
        [self showAlertViewWithMessage:@"没有任何需要删除的"];
    }
    else if (arr.count != 0 && self.dataSource.count != 0)
    {
        NSMutableArray * Arr = [NSMutableArray array];
        for ( int i = 0; i < arr.count ; i ++)
        {
            NSIndexPath * indexP = arr[i];
            BusinessModel * model = self.dataSource[indexP.section];
            GoodsModel * shop = model.BuyCarArray[indexP.row];
            [Arr addObject:shop];
        }
        //模拟请求
        [self setIndicatorView];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(),^{
            [loading removeFromSuperview];
            [self loactionDeleteWithArr:arr];//请求成功后进行本地删除
        });
        
    }
}

#pragma mark ---->本地删除
- (void)loactionDeleteWithArr:(NSMutableArray *)arr
{
    NSMutableIndexSet *indexSet = [[NSMutableIndexSet alloc]init];
    [arr sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return obj1 < obj2;
    }];
    for ( int i = 0; i < arr.count ; i ++)
    {
        NSIndexPath * indexP = arr[i];
        BusinessModel * model = self.dataSource[indexP.section];
        GoodsModel * shop = model.BuyCarArray[indexP.row];
        [model.BuyCarArray removeObject:shop];
        if (model.BuyCarArray.count == 0)
        {
            [self.dataSource removeObject:model];
            [self.sectionSelect removeObjectAtIndex:indexP.section];
        }
        [indexSet addIndex:i];
    }
    [arr removeObjectsAtIndexes:indexSet];
    [self.buyCarTableView reloadData];
}

#pragma mark 提示框
- (void) showAlertViewWithMessage:(NSString *)message
{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:message message:@"" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
}

@end
