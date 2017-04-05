//
//  ViewController.m
//  CartAnmation
//
//  Created by huangqiang on 16/5/18.
//  Copyright © 2016年 HQ. All rights reserved.
//

#import "ViewController.h"
#import "HQTableViewCell.h"
#import "HQCartView.h"
#define CellView @"cell"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) UITableView * mainTableView;
@property (strong, nonatomic) HQCartView * cartView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.mainTableView];
    [self.view addSubview:self.cartView];
}

#pragma mark all click 
- (void)addButtonAction:(UIButton *)button{
    NSIndexPath * indexPath = [NSIndexPath indexPathForRow:button.tag inSection:0];
    [self.cartView addGoodsToCartWith:[HQTableViewCell addbuttonFrameOriginWith:indexPath toView:self.view tableView:self.mainTableView] onView:self.view];
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 200;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HQTableViewCell * cell = [HQTableViewCell tableViewCellWith:tableView indexPath:indexPath identifier:CellView target:self action:@selector(addButtonAction:)];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark lazy
- (UITableView *)mainTableView{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height-69)];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.rowHeight = 60;
        [_mainTableView registerClass:[HQTableViewCell class] forCellReuseIdentifier:CellView];
    }
    return _mainTableView;
}

- (HQCartView *)cartView{
    if (!_cartView) {
        _cartView = [[HQCartView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.frame)-49, self.view.frame.size.width, 49)];
    }
    return _cartView;
}
@end
