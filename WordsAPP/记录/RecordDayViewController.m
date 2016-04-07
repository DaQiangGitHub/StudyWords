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

#import "ModelView.h"
#import "MidiumView.h"
#import "DifficultView.h"
#import "CompleteView.h"

@interface RecordDayViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, retain) UITableView * tableView;

@property (nonatomic, retain) NSArray * array;

@property (nonatomic, assign) NSInteger i;

@end

@implementation RecordDayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.barLable.text = self.date;
    self.barRightButton.hidden = YES;
    self.barLeftButton.hidden = NO;
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
- (void)addViewsForQuestionWithIndexPath:(NSIndexPath *)indexPath{
    switch ([_array[indexPath.section][@"level"] intValue]) {
        case 0:{
            ModelView * modelView =[[ModelView alloc] initWithFrame:self.view.frame imageType:[_array[indexPath.section][@"type"] integerValue] nameType:[_array[indexPath.section][@"level"] integerValue] isRecord:1 dic:_array[indexPath.section]];
            [self.view addSubview:modelView];
        }
            break;
        case 1:{
            MidiumView * midiumView = [[MidiumView alloc] initWithFrame:[UIScreen mainScreen].bounds nameType:[_array[indexPath.section][@"type"] integerValue] imageType:[_array[indexPath.section][@"level"] integerValue] isRecord:1 dic:_array[indexPath.section]];
            [self.view addSubview:midiumView];
        }
            break;
        case 2:{
            DifficultView * difficultView = [[DifficultView alloc] initWithFrame:[UIScreen mainScreen].bounds imageType:[_array[indexPath.section][@"type"] integerValue] nameType:[_array[indexPath.section][@"level"] integerValue]isRecord:1 dic:_array[indexPath.section]];
            [self.view addSubview:difficultView];
        }
            break;
        default:
            break;
    }
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self addViewsForQuestionWithIndexPath:indexPath];
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
    cell.levelImage.image = self.imagesLevel[[_array[indexPath.section][@"level"] intValue]];
    cell.typeImage.image = self.imagesType[[_array[indexPath.section][@"type"] intValue]];
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
