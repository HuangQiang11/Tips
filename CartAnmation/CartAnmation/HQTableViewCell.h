//
//  TableViewCell.h
//  CartAnmation
//
//  Created by huangqiang on 16/5/18.
//  Copyright © 2016年 HQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HQTableViewCell : UITableViewCell
@property (strong, nonatomic) UIButton * button;
+ (HQTableViewCell *)tableViewCellWith:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath identifier:(NSString *)indentifier target:(id)target action:(SEL)action;
+ (CGPoint)addbuttonFrameOriginWith:(NSIndexPath *)indexPath toView:(UIView *)view tableView:(UITableView *)tableView;
@end
