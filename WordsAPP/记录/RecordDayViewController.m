//
//  RecordDayViewController.m
//  WordsAPP
//
//  Created by rimi on 16/3/30.
//  Copyright © 2016年 zhugaoqiang. All rights reserved.
//

#import "RecordDayViewController.h"
#import "Networking.h"
#import "RecoredTableViewCell.h"


@interface RecordDayViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, retain) UITableView * tableView;

@property (nonatomic, retain) NSArray * array;


@end

@implementation RecordDayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initDataSource];
    
}
- (void)initDataSource{
    _array = [NSArray arrayWithArray:[[Networking alloc] getRecordOfOneDayListWithDate:self.date successBlock:^(BOOL succeed) {
        if (succeed) {
            NSLog(@"获取成功");
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }]];

    [self initInterface];
}
- (void)initInterface{
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDelegate
- (void)selectRowAtIndexPath:(nullable NSIndexPath *)indexPath animated:(BOOL)animated scrollPosition:(UITableViewScrollPosition)scrollPosition{
    //需传数据：答题记录
//    SimpleViewController * simple = [[SimpleViewController alloc] init];
//    [self.navigationController pushViewController:simple animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 15;
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _array.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RecoredTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[RecoredTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    cell.levelImage.image = self.imagesLevel[[_array[indexPath.row][@"type"] intValue]];
    cell.typeImage.image = self.imagesType[[_array[indexPath.row][@"level"] intValue]];
    cell.score.text = _array[indexPath.section][@"score"];
    cell.date.text = self.date;
    
    return cell;
}

#pragma mark - getter
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
