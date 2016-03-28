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

@property (nonatomic, strong) HomePageTableViewCell * cell;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //    self.barLable.text = @"英语大全";
    
    [self initInterface];
    NSLog(@"123");
    
}
- (void)initInterface{
    _pictures = [NSArray arrayWithObjects:@"水果",@"蔬菜",@"动物.jpg",@"生活用品.jpg",@"运动", nil];
    //    self.barLeftButton.hidden = YES;
    //    self.barRightButton.hidden = YES;
    //    self.barView.hidden = YES;
    //    self.barLable.hidden = YES;
    self.view.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.backgroundImageView];
    [self.view addSubview:self.tableView];
    
}

#pragma mark -- animation

- (CABasicAnimation *)positionAnimation:(CGPoint)CGPoint
{
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.duration = 1;
    animation.fromValue = [NSValue valueWithCGPoint:CGPoint];
    animation.delegate = self;
    animation.removedOnCompletion = NO;
    return animation;
}

- (CABasicAnimation *)scaleAnimation
{
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.duration = 1;
    //    animation.fromValue = @3;
    NSArray * arrar = @[@2,@1,@0.8,@0.4];
    animation.toValue = arrar;
    return animation;
}

- (CABasicAnimation *)rotationAnimation
{
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    animation.duration = 1;
    animation.fromValue = @0;
    animation.toValue = @(M_PI * 4);
    return animation;
}

- (CAKeyframeAnimation *)shakeAnimation
{
    CAKeyframeAnimation * animation = [CAKeyframeAnimation animationWithKeyPath:@"position.y"];
    animation.duration = 2;
    animation.additive = YES;
    animation.values = @[@600,@-600,@1];
    animation.repeatCount = 1;
    return animation;
    
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
    NSInteger y = BAR_H + indexPath.row * (SCREEN_H - BAR_H - 50) / 5 ;
    [cell.fruitImageView.layer addAnimation:[self positionAnimation:CGPointMake(600, y)] forKey:@"position"];
    [cell.fruitImageView.layer addAnimation:[self scaleAnimation] forKey:@"position"];
    [cell.fruitImageView.layer addAnimation:[self rotationAnimation] forKey:@"position"];
    [cell.fruitImageView.layer addAnimation:[self shakeAnimation] forKey:nil];
    
    self.cell = cell;
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
        [_backgroundImageView setImage:[UIImage imageNamed:@"背景2.jpg"]];
    }
    return _backgroundImageView;
}

@end
