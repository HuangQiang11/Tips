//
//  Type1Controller.m
//  CartAnmation
//
//  Created by huangqiang on 17/4/10.
//  Copyright © 2017年 HQ. All rights reserved.
//

#import "Type1Controller.h"
#import "HQTableViewCell.h"
#import "HQCartAnimationTool.h"
#define CellView @"cell"
@interface Type1Controller ()<UITableViewDataSource,UITableViewDelegate>
{
    NSUInteger i;
}
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;
@property (strong, nonatomic) HQCartAnimationTool * cartTool;
@end

@implementation Type1Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.mainTableView registerClass:[HQTableViewCell class] forCellReuseIdentifier:CellView];
    self.cartTool = ({
        HQCartAnimationTool  *cartTool = [[HQCartAnimationTool alloc] init];
        cartTool.vc = self;
        cartTool.type = HQCartAnimationFromRight;
        __weak typeof(self) weakSelf = self;
        cartTool.cartBtnClick = ^(id sender){
            NSLog(@"%@",weakSelf);
        };
        cartTool;
    });

}

#pragma mark all click
- (void)addButtonAction:(UIButton *)button{
    i++;
    NSIndexPath * indexPath = [NSIndexPath indexPathForRow:button.tag inSection:0];
    HQTableViewCell * cell = [self.mainTableView cellForRowAtIndexPath:indexPath];
    CGRect taRect = [cell convertRect:cell.button.frame toView:self.mainTableView];
    CGRect vRect = [self.mainTableView convertRect:taRect toView:self.view];
    NSLog(@"%@",NSStringFromCGRect(vRect));
    
    [self.cartTool addGoodToCartWithOriginPoint:CGPointMake(vRect.origin.x, vRect.origin.y) image:cell.button.imageView.image tipNum:i];
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

@end
