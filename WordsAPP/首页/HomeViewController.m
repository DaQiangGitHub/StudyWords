//
//  HomeViewController.m
//  WordsAPP
//
//  Created by rimi on 16/3/17.
//  Copyright © 2016年 zhugaoqiang. All rights reserved.
//

#import "HomeViewController.h"
#import "LevelViewController.h"
#import "HomePageTableViewCell.h"
#import "LevelViewController.h"

@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSArray * pictures;
@property (nonatomic, strong) UIImageView * backgroundImageView;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.barLable.text = @"英语大全";
    
    [self initInterface];
    
}
- (void)initInterface{
    _pictures = [NSArray arrayWithObjects:@"水果",@"蔬菜",@"动物.jpg",@"生活用品.jpg",@"运动", nil];
    self.barLeftButton.hidden = YES;
    self.barRightButton.hidden = YES;
    self.barView.hidden = YES;
    self.barLable.hidden = YES;
    self.view.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.backgroundImageView];
    [self.view addSubview:self.tableView];

}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomePageTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[HomePageTableViewCell alloc] initWithStyle:0 reuseIdentifier:@"Cell"];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.fruitImageView.image = [UIImage imageNamed:self.pictures[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark -- UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LevelViewController * leverViewController = [[LevelViewController alloc] init];
    [self.navigationController pushViewController:leverViewController animated:YES];
}

#pragma mark - ClickOnTheEvents

#pragma mark - getter


- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = ({
            UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, BAR_H, SCREEN_W, SCREEN_H - BAR_H - 50)];
            tableView.delegate = self;
            tableView.dataSource = self;
            tableView.backgroundColor = [UIColor clearColor];
            tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            tableView.rowHeight = (SCREEN_H - BAR_H - 50) / 5;
            tableView.scrollEnabled = NO;
            tableView;
        });
    }
    return _tableView;
}

- (UIImageView *)backgroundImageView
{
    if (!_backgroundImageView) {
        _backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H - 50)];
        [_backgroundImageView setImage:[UIImage imageNamed:@"1%3O86)NSF}%0@~~J[KG@1K.jpg"]];
    }
    return _backgroundImageView;
}

@end
