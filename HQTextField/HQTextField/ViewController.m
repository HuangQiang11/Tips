//
//  ViewController.m
//  HQTextField
//
//  Created by huangqiang on 16/9/14.
//  Copyright © 2016年 huangqiang. All rights reserved.
//

#import "ViewController.h"
#import "TestViewController.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) UITableView * mainTableView;
@property (strong, nonatomic) NSArray * dataArr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"Main";
    _mainTableView = ({
        UITableView *mainTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        mainTableView.delegate = self;
        mainTableView.dataSource = self;
        mainTableView.tableFooterView = [UIView new];
        mainTableView;
    });
    [self.view addSubview:_mainTableView];
    
    self.dataArr = @[@"NoTitleStyle",@"ButtonStyle",@"SelectStyle",@"PhoneTitleStyle",@"NormalTitleStyle",@"NoTitleAndVerifyStyle",@"NormalTitleAndVerifyStyle",@"NormalTitleAndMoneyTipStyle"];
}

#pragma mark UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * identifier = @"identifier";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = self.dataArr[indexPath.row];
    return  cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.navigationController pushViewController:({
        TestViewController * testVC = [TestViewController new];
        testVC.style = indexPath.row;
        testVC;
    }) animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
