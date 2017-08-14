//
//  HQSearchView.m
//  HQSearchController
//
//  Created by huangqiang on 2017/8/10.
//  Copyright © 2017年 huangqiang. All rights reserved.
//

#import "HQSearchView.h"
@interface HQSearchView()
@property (strong, nonatomic) UISearchBar * searchBar;
@end
@implementation HQSearchView
- (instancetype)initWithFrame:(CGRect)frame{
    frame = CGRectMake(0, 0,DEVICE_WIDTH, 44);
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self addSubview:self.searchBar];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect frame = self.bounds;
    self.searchBar.frame = CGRectMake(8, CGRectGetHeight(frame)-37, DEVICE_WIDTH -16, 30);
}

#pragma mark setter getter
- (UISearchBar *)searchBar{
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc] init];
        _searchBar.backgroundImage = [UIImage new];
    }
    return _searchBar;
}

- (NSString *)text{
    return _searchBar.text;
}

- (void)setPlacehold:(NSString *)placehold{
    _placehold = [placehold copy];
    _searchBar.placeholder = _placehold;
}

@end
