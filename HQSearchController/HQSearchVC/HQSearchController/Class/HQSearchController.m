//
//  HQSearchController.m
//  HQSearchController
//
//  Created by huangqiang on 2017/8/11.
//  Copyright © 2017年 huangqiang. All rights reserved.
//

#import "HQSearchController.h"
#import "UIView+JKRSubView.h"
#import "UIView+JKRViewController.h"
#import "UIViewController+HQRect.h"
#import "UISearchBar+HQCancelButton.h"
#import "UIViewController+JKRStatusBarStyle.h"
@interface HQSearchController ()<UISearchBarDelegate>
@property (strong, nonatomic) UIView * dimsBackground;
@end

@implementation HQSearchController
- (instancetype)initWithSearchResultsController:(UIViewController *)searchResultsController{
    self = [super init];
    _searchResultsController = searchResultsController;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor clearColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:_searchResultsController.view];
}

- (void)viewDidLayoutSubviews{
     _searchResultsController.view.frame = CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT-64);
}

- (void)dismissViewAnimated:(BOOL)flag completion:(void (^)(void))completion{
     [self hiddenSearchViewWith:[_searchBar valueForKey:@"searchBar"] animation:flag completion:completion];
}

- (void)showSearchViewWith:(UISearchBar *)searchBar{
    if (!self.view.superview) {
        searchBar.showsCancelButton = YES;
        UIViewController * currentVC = self.searchBar.jkr_viewController;
        UITableView * tableView = [currentVC.view tableView];
        HQSearchView * header = (HQSearchView *)tableView.tableHeaderView;
        header.bounds = CGRectMake(0, 0, DEVICE_WIDTH, 64);
        CGRect rect = CGRectMake(0, -64, DEVICE_WIDTH, DEVICE_HEIGHT+64);
//        currentVC.highlightRect = rect;
        tableView.scrollEnabled = NO;
        [UIView animateWithDuration:0.2 animations:^{
            currentVC.navigationController.view.frame = rect;
            tableView.tableHeaderView =  header;
        } completion:^(BOOL finished) {
            self.view.frame = CGRectMake(0, 64*2,DEVICE_WIDTH , DEVICE_HEIGHT-64);
            [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:self.view];
            currentVC.jkr_lightStatusBar = NO;
        }];
    }
}

- (void)hiddenSearchViewWith:(UISearchBar *)searchBar animation:(BOOL)flag completion:(void (^)(void))completion{
    searchBar.text = nil;
    [searchBar resignFirstResponder];
    if (self.view.superview) {
        searchBar.showsCancelButton = NO;
        UIViewController * currentVC = self.searchBar.jkr_viewController;
        UITableView * tableView = [currentVC.view tableView];
        HQSearchView * header = (HQSearchView *)tableView.tableHeaderView;
        header.bounds = CGRectMake(0, 0, DEVICE_WIDTH, 44);
        tableView.scrollEnabled = YES;
        //        currentVC.highlightRect = CGRectZero;
        if (flag) {
            [UIView animateWithDuration:0.2 animations:^{
                currentVC.navigationController.view.frame = CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT);
                tableView.tableHeaderView = header;
            }completion:^(BOOL finished) {
                currentVC.jkr_lightStatusBar = YES;
                if (completion) {
                    completion();
                }
            }];
        }else{
            currentVC.navigationController.view.frame = CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT);
            tableView.tableHeaderView = header;
            currentVC.jkr_lightStatusBar = YES;
            if (completion) {
                completion();
            }
        }
        
        [self.view removeFromSuperview];
    }

}

- (void)hiddenSearchViewWith:(UISearchBar *)searchBar{
    [self hiddenSearchViewWith:searchBar animation:YES completion:nil];
}

#pragma mark UISearchBarDelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    searchBar.showsCancelButton = YES;
    [searchBar.cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    return YES;
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    [self showSearchViewWith:searchBar];
    if (self.searchBar.delegate && [self.searchBar.delegate respondsToSelector:@selector(searchViewTextDidBeginEditing:)]) {
        [self.searchBar.delegate searchViewTextDidBeginEditing:self.searchBar];
    }
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    if (self.searchBar.delegate && [self.searchBar.delegate respondsToSelector:@selector(searchViewTextDidEndEditing:)]) {
        [self.searchBar.delegate searchViewTextDidEndEditing:self.searchBar];
    }
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if (self.searchResultsUpdater && [self.searchResultsUpdater respondsToSelector:@selector(updateSearchResultsForSearchController:)]) {
        [self.searchResultsUpdater updateSearchResultsForSearchController:self];
    }
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    searchBar.cancelBtn.enabled = YES;
    if (self.searchBar.delegate && [self.searchBar.delegate respondsToSelector:@selector(searchViewDidClickSearchBtn:)]) {
        [self.searchBar.delegate searchViewDidClickSearchBtn:self.searchBar];
    }
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [self hiddenSearchViewWith:searchBar];
}

#pragma mark setter getter
- (HQSearchView *)searchBar{
    if (!_searchBar) {
        _searchBar = [[HQSearchView alloc] initWithFrame:CGRectZero];
        UISearchBar * bar = [_searchBar valueForKey:@"searchBar"];
        bar.delegate = self;
    }
    return _searchBar;
}

- (UIView *)dimsBackground{
    if (!_dimsBackground) {
        _dimsBackground = [[UIView alloc] init];
        _dimsBackground.backgroundColor = [UIColor blackColor];
        _dimsBackground.alpha = 0.6;
    }
    return _dimsBackground;
}

- (void)setActive:(BOOL)active{
    _active = active;
    if (!_active) {
        [self searchBarCancelButtonClicked:[_searchBar valueForKey:@"searchBar"]];
    }
}

@end
