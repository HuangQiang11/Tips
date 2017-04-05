//
//  MNavigationController.m
//  DIYFont
//
//  Created by huangqiang on 17/4/5.
//  Copyright © 2017年 huangqiang. All rights reserved.
//

#import "MNavigationController.h"

@interface MNavigationController ()

@end

@implementation MNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
