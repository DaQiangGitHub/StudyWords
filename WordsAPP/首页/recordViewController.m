//
//  recordViewController.m
//  WordsAPP
//
//  Created by rimi on 16/3/23.
//  Copyright © 2016年 zhugaoqiang. All rights reserved.
//

#import "recordViewController.h"
#import "Networking.h"
#import "SimpleViewController.h"
#import "RecoredTableViewCell.h"


@interface recordViewController () <UITableViewDelegate, UITableViewDataSource>


@property (nonatomic, retain) UIImageView * backImage;
@property (nonatomic, retain) UITableView * tableView;




@end

@implementation recordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.barLable.text = @"重新答题";
    self.tabBarController.tabBar.hidden = YES;
    
    [self.view addSubview:self.backImage];
    [self.view addSubview:self.tableView];
    
    
    [self.view sendSubviewToBack:self.backImage];
    


}
#pragma mark - UITableViewDelegate
- (void)selectRowAtIndexPath:(nullable NSIndexPath *)indexPath animated:(BOOL)animated scrollPosition:(UITableViewScrollPosition)scrollPosition{
    //需传数据：答题记录
    SimpleViewController * simple = [[SimpleViewController alloc] init];
    [self.navigationController pushViewController:simple animated:YES];
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
    cell.score.text = @"100分";
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy/MM/dd"];
    cell.date.text = [formatter stringFromDate:[NSDate date]];
    
    return cell;
}

#pragma mark - getter
- (UIImageView *)backImage{
    if (!_backImage) {
        _backImage = ({
            UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
            imageView.image = [UIImage imageNamed:@"背景6.jpg"];

            [[Networking alloc] getimageType:animals index:2 success:^(UIImage *image) {
                imageView.image = image;
            } failure:^(NSError *error) {
                NSLog(@"%@",error);
            }];

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
