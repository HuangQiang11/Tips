//
//  Type2Controller.m
//  CartAnmation
//
//  Created by huangqiang on 17/4/10.
//  Copyright © 2017年 HQ. All rights reserved.
//

#import "Type2Controller.h"
#import "HQCartAnimationTool.h"
@interface Type2Controller ()<UITableViewDelegate,UITableViewDataSource>{
    NSUInteger i;
}
@property (strong, nonatomic) HQCartAnimationTool * cartTool;
@end

@implementation Type2Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.cartTool = ({
        HQCartAnimationTool  *cartTool = [[HQCartAnimationTool alloc] init];
        cartTool.vc = self;
        cartTool.type = HQCartAnimationFromLeft;
        __weak typeof(self) weakSelf = self;
        cartTool.cartBtnClick = ^(id sender){
            NSLog(@"%@",weakSelf);
        };
        cartTool;
    });
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * identifier = @"type2";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    if (indexPath.row%2 == 1) {
        cell.imageView.image = [UIImage imageNamed:@"1.jpg"];
    }else{
        cell.imageView.image = [UIImage imageNamed:@"2.jpg"];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    i++;
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    NSLog(@"cellImage:%@",NSStringFromCGRect(cell.imageView.frame));
    
    CGRect taIRect = [cell convertRect:cell.imageView.frame toView:tableView];

    CGRect imageRect = [tableView convertRect:taIRect toView:self.view];
    NSLog(@"imageRect:%@",NSStringFromCGRect(imageRect));
    
    [self.cartTool addGoodToCartWithOriginPoint:CGPointMake(CGRectGetMaxX(imageRect), CGRectGetMinY(imageRect)) image:cell.imageView.image tipNum:i];
}

@end
