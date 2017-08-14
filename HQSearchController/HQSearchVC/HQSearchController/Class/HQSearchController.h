//
//  HQSearchController.h
//  HQSearchController
//
//  Created by huangqiang on 2017/8/11.
//  Copyright © 2017年 huangqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HQSearchView.h"
@protocol HQSearchResultsUpdating;
@interface HQSearchController : UIViewController
@property (strong, nonatomic) HQSearchView * searchBar;
@property (assign, nonatomic) BOOL active;
@property (strong, nonatomic) UIViewController * searchResultsController;
@property (weak, nonatomic) id <HQSearchResultsUpdating>searchResultsUpdater;
- (instancetype)initWithSearchResultsController:(UIViewController *)searchResultsController;
- (void)dismissViewAnimated:(BOOL)flag completion:(void (^)(void))completion;
@end

@protocol HQSearchResultsUpdating<NSObject>
- (void)updateSearchResultsForSearchController:(HQSearchController *)searchController;
@end
