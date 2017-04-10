//
//  TableViewCell.m
//  CartAnmation
//
//  Created by huangqiang on 16/5/18.
//  Copyright © 2016年 HQ. All rights reserved.
//

#import "HQTableViewCell.h"
#define kAddButtonY 20
#define kAddButtonH 30
#define kAddButtonX (CGRectGetWidth([UIScreen mainScreen].bounds) -kAddButtonH -10)
@implementation HQTableViewCell
+ (HQTableViewCell *)tableViewCellWith:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath identifier:(NSString *)indentifier target:(id)target action:(SEL)action{
    HQTableViewCell * cell = (HQTableViewCell *)[tableView dequeueReusableCellWithIdentifier:indentifier];
    cell.button.tag = indexPath.row;
    if (indexPath.row%2 == 1) {
        [cell.button setImage:[UIImage imageNamed:@"1.jpg"] forState:UIControlStateNormal];
    }else{
        [cell.button setImage:[UIImage imageNamed:@"2.jpg"] forState:UIControlStateNormal];
    }
    [cell.button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
+ (CGPoint)addbuttonFrameOriginWith:(NSIndexPath *)indexPath toView:(UIView *)view tableView:(UITableView *)tableView{
    CGRect rect_mainTableView = [tableView rectForRowAtIndexPath:indexPath];
    CGRect rect_view = [tableView convertRect:rect_mainTableView toView:view];
    CGFloat pointX = kAddButtonX;
    CGFloat pointY = CGRectGetMinY(rect_view) + kAddButtonY;
    return CGPointMake(pointX, pointY);
    
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self crearUi];
    }
    return self;
}

- (void)crearUi{
    [self.contentView addSubview:self.button];
}

- (UIButton *)button{
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.frame = CGRectMake(kAddButtonX, kAddButtonY, kAddButtonH, kAddButtonH);
        [_button setBackgroundColor:[UIColor redColor]];
    }
    return _button;
}

@end
