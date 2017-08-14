//
//  RootVC.m
//  HQSearchController
//
//  Created by huangqiang on 2017/8/10.
//  Copyright © 2017年 huangqiang. All rights reserved.
//

#import "RootVC.h"
#import "HQSearchView.h"
#import "HQSearchController.h"
#import "SearchResultController.h"
#import "UIViewController+JKRStatusBarStyle.h"
#import "TestController.h"
@interface RootVC ()<UITableViewDelegate,UITableViewDataSource,HQSearchViewDelegate,HQSearchResultsUpdating>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) HQSearchController * searchController;
@property (strong, nonatomic) NSMutableArray * dataArr;
@end

@implementation RootVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupLayout];
    self.jkr_lightStatusBar = YES;
}

- (void)setupLayout{
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"standCell"];
     self.tableView.tableHeaderView = self.searchController.searchBar;
}

- (void)didSelectRow:(NSIndexPath *)indexPath{
    [self.searchController dismissViewAnimated:YES completion:^{
        [self.navigationController pushViewController:[TestController new] animated:YES];
    }];
}

#pragma mark HQSearchViewDelegate
- (void)searchViewTextDidEndEditing:(HQSearchView *)searchBar{
    NSLog(@"%s",__func__);
}

- (void)searchViewTextDidBeginEditing:(HQSearchView *)searchBar{
    NSLog(@"%s",__func__);
}

- (void)searchViewDidClickSearchBtn:(HQSearchView *)searchBar{
      NSLog(@"%s",__func__);
}

#pragma mark HQSearchResultsUpdating
- (void)updateSearchResultsForSearchController:(HQSearchController *)searchController{
    NSLog(@"%s",__func__);
    SearchResultController * vc = (SearchResultController *)self.searchController.searchResultsController;
    NSMutableArray * arr = [NSMutableArray arrayWithCapacity:self.dataArr.count];
    for (NSNumber * num in self.dataArr) {
        if (searchController.searchBar.text && ![searchController.searchBar.text isEqualToString:@""]) {
            NSString * numStr = [NSString stringWithFormat:@"%@",num];
            if ([numStr rangeOfString:searchController.searchBar.text].location != NSNotFound) {
                [arr addObject:num];
            }
        }
    }
    
    vc.dataArr = arr;
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"standCell"];
    cell.textLabel.text = [NSString stringWithFormat:@"%zd",[self.dataArr[indexPath.row] integerValue]];
    return cell;
}

- (HQSearchController *)searchController{
    if (!_searchController) {
        SearchResultController * resultVC = [[SearchResultController alloc] init];
        __weak typeof(self) weakSelf = self;
        resultVC.clickBlock = ^(NSIndexPath * indexPath) {
            [weakSelf didSelectRow:indexPath];
        };
        _searchController = [[HQSearchController alloc] initWithSearchResultsController:resultVC];
        _searchController.searchBar.delegate = self;
        _searchController.searchResultsUpdater = self;
        _searchController.searchBar.placehold = @"search";
    }
    return _searchController;
}

#pragma mark setter getter
- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = @[].mutableCopy;
        for (int i = 0; i<10; i++) {
            [_dataArr addObject:[NSNumber numberWithInteger:arc4random()%10]];
        }
    }
    return _dataArr;
}

@end
