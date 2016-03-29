//
//  WrongQuestionViewController.m
//  WordsAPP
//
//  Created by rimi on 16/3/23.
//  Copyright © 2016年 zhugaoqiang. All rights reserved.
//

#import "WrongQuestionViewController.h"
#import "RecoredTableViewCell.h"

@interface WrongQuestionViewController () <UITableViewDelegate, UITableViewDataSource>


@property (nonatomic, retain) UIImageView * backImage;
@property (nonatomic, retain) UITableView * tableView;


@end

@implementation WrongQuestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.barLable.text = @"错题重做";
    self.tabBarController.tabBar.hidden = YES;
    
    [self.view addSubview:self.backImage];
    [self.view addSubview:self.tableView];
    
    [self.view sendSubviewToBack:self.backImage];
    
    
}


#pragma mark - UITableViewDelegate
- (void)selectRowAtIndexPath:(nullable NSIndexPath *)indexPath animated:(BOOL)animated scrollPosition:(UITableViewScrollPosition)scrollPosition{
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 15;
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RecoredTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[RecoredTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    cell.imageView.image = [UIImage imageNamed:@"中等模式背景"];
    cell.imageView.contentMode = UIViewContentModeScaleToFill;
    cell.levelImage.image = [UIImage imageNamed:@"简单模式"];
    cell.typeImage.image = [UIImage imageNamed:@"动物.jpg"];
//    cell.score.text = @"100分";        //不显示
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy/MM/dd"];
    cell.date.text = [formatter stringFromDate:[NSDate date]];
    
    return cell;
}


#pragma mark - getter
- (UIImageView *)backImage{
    if (!_backImage) {
        _backImage = ({
            UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H)];
            imageView.image = [UIImage imageNamed:@"背景6.jpg"];
            imageView;
        });
    }
    return _backImage;
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = ({
            UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, BAR_H, SCREEN_W, SCREEN_H)];
            tableView.delegate = self;
            tableView.dataSource = self;
            tableView.rowHeight = 150;
            tableView;
        });
    }
    return _tableView;
}
@end
