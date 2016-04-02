//
//  WrongQuestionViewController.m
//  WordsAPP
//
//  Created by rimi on 16/3/23.
//  Copyright © 2016年 zhugaoqiang. All rights reserved.
//

#import "WrongQuestionViewController.h"
#import "QuestionTableViewCell.h"
#import "Networking.h"

@interface WrongQuestionViewController () <UITableViewDelegate, UITableViewDataSource>


@property (nonatomic, retain) UIImageView * backImage;
@property (nonatomic, retain) UITableView * tableView;
@property (nonatomic, retain) NSDictionary * dictionary;
@property (nonatomic, retain) UIImageView * noDataImage;

@end

@implementation WrongQuestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.barLable.text = @"错题重做";
    self.tabBarController.tabBar.hidden = YES;
    
    [self initDataSource];
    
}
- (void)initDataSource{
    _dictionary = [NSDictionary dictionaryWithDictionary:[[Networking alloc] getMistakesListSuccessBlock:^(BOOL succeed) {
        if (succeed) {
            NSLog(@"获取成功");
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }]];
    
    [self initInterface];
}
- (void)initInterface{
    [self.view addSubview:self.backImage];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.noDataImage];
    
    [self.view sendSubviewToBack:self.backImage];
}
#pragma mark - UITableViewDelegate
- (void)selectRowAtIndexPath:(nullable NSIndexPath *)indexPath animated:(BOOL)animated scrollPosition:(UITableViewScrollPosition)scrollPosition{
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 15;
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if(_dictionary){
        self.noDataImage.hidden = YES;
        if (!_dictionary[@"count"]) {
            self.noDataImage.hidden = NO;
        }
        return [_dictionary[@"count"] intValue];
    }else{
        self.noDataImage.hidden = NO;
    }
    return 0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    QuestionTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[QuestionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    cell.typeImage.image = [UIImage imageNamed:@"动物.jpg"];
    cell.groups.text = _dictionary[@"questions"][indexPath.section];
    cell.date.text = _dictionary[@"times"][indexPath.section];
    
    return cell;
}


#pragma mark - getter
- (UIImageView *)backImage{
    if (!_backImage) {
        _backImage = ({
            UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, BAR_H, SCREEN_W, SCREEN_H)];
            imageView.image = [UIImage imageNamed:@"背景6.jpg"];
            imageView;
        });
    }
    return _backImage;
}
- (UIImageView *)noDataImage{
    if (!_noDataImage) {
        _noDataImage = ({
            UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_W/4, BAR_H * 2, SCREEN_W/2, SCREEN_H/2 - 50)];
            imageView.image = [UIImage imageNamed:@"暂无数据"];
            imageView.hidden = YES;
            imageView;
        });
    }
    return _noDataImage;
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
