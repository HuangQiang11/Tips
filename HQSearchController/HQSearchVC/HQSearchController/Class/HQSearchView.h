//
//  HQSearchView.h
//  HQSearchController
//
//  Created by huangqiang on 2017/8/10.
//  Copyright © 2017年 huangqiang. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol HQSearchViewDelegate;
#define DEVICE_HEIGHT [UIScreen mainScreen].bounds.size.height
#define DEVICE_WIDTH [UIScreen mainScreen].bounds.size.width
@interface HQSearchView : UIView
@property (weak, nonatomic) id<HQSearchViewDelegate>delegate;
@property (copy, nonatomic, readonly) NSString * text;
@property (copy, nonatomic) NSString * placehold;
@end

@protocol HQSearchViewDelegate<NSObject>
@optional
- (void)searchViewTextDidBeginEditing:(HQSearchView *)searchBar;
- (void)searchViewTextDidEndEditing:(HQSearchView *)searchBar;
- (void)searchViewDidClickSearchBtn:(HQSearchView *)searchBar;
@end
