//
//  SearchResultController.m
//  HQSearchController
//
//  Created by huangqiang on 2017/8/11.
//  Copyright © 2017年 huangqiang. All rights reserved.
//

#import "SearchResultController.h"
@interface SearchResultController ()
@end

@implementation SearchResultController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.tableFooterView = [UIView new];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"standCell"];
}

- (void)setDataArr:(NSArray *)dataArr{
    _dataArr = [dataArr copy];
    [self.tableView reloadData];
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"standCell"];
    cell.textLabel.text = [NSString stringWithFormat:@"%zd",[self.dataArr[indexPath.row] integerValue]];
    cell.contentView.backgroundColor = [UIColor yellowColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.clickBlock) {
        self.clickBlock(indexPath);
    }
}

@end
