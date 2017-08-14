//
//  SearchResultController.h
//  HQSearchController
//
//  Created by huangqiang on 2017/8/11.
//  Copyright © 2017年 huangqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^SelectRowBlock)(id);
@interface SearchResultController : UITableViewController
@property (copy, nonatomic) NSArray * dataArr;
@property (copy, nonatomic) SelectRowBlock clickBlock;
@end
