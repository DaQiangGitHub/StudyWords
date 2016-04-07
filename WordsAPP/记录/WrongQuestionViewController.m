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

#import "ModelView.h"
#import "MidiumView.h"
#import "DifficultView.h"
#import "CompleteView.h"

@interface WrongQuestionViewController () <UITableViewDelegate, UITableViewDataSource>


@property (nonatomic, retain) UIImageView * backImage;
@property (nonatomic, retain) UITableView * tableView;
@property (nonatomic, retain) NSDictionary * dictionary;
@property (nonatomic, retain) UIImageView * noDataImage;
@property (nonatomic, retain) NSArray * array;
@property (nonatomic, assign) NSInteger i;

@end

@implementation WrongQuestionViewController
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.barLable.text = @"错题重做";
    self.tabBarController.tabBar.hidden = YES;
    self.barRightButton.hidden = YES;
    self.barLeftButton.hidden = NO;
    [self initDataSource];
    _i = 0;
}
- (void)initDataSource{
    _dictionary = [NSDictionary dictionaryWithDictionary:[[Networking alloc] getMistakesListSuccessBlock:^(BOOL succeed) {
        if (succeed) {
            NSLog(@"获取成功");
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addViewsForQuestion) name:@"Next" object:nil];
    [self initInterface];
}
- (void)initInterface{
    [self.view addSubview:self.backImage];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.noDataImage];
    
    [self.view sendSubviewToBack:self.backImage];
}
- (void)addViewsForQuestion{
    if (_i == _array.count) {
        CompleteView * completView = [[CompleteView alloc] initWithFrame:self.view.frame];
        [self.view addSubview:completView];
    }else{
        switch ([_array[_i][@"level"] intValue]) {
            case 0:{
                ModelView * modelView =[[ModelView alloc] initWithFrame:self.view.frame imageType:[_array[_i][@"type"] integerValue] nameType:[_array[_i][@"level"] integerValue]isRecord:2 dic:_array[_i]];
                [self.view addSubview:modelView];
            }
                break;
            case 1:{
                MidiumView * midiumView = [[MidiumView alloc] initWithFrame:[UIScreen mainScreen].bounds nameType:[_array[_i][@"type"] integerValue] imageType:[_array[_i][@"level"] integerValue]isRecord:2 dic:_array[_i]];
                [self.view addSubview:midiumView];
            }
                break;
            case 2:{
                DifficultView * difficultView = [[DifficultView alloc] initWithFrame:[UIScreen mainScreen].bounds imageType:[_array[_i][@"type"] integerValue] nameType:[_array[_i][@"level"] integerValue]  isRecord:2 dic:_array[_i]];
                [self.view addSubview:difficultView];
            }
                break;
            default:
                break;
        }
        _i++;
    }
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    _array = [NSArray arrayWithArray:[[Networking alloc] getMistakesWithDate:[NSString stringWithFormat:@"%@",_dictionary[@"times"][indexPath.section]]]];
    [self addViewsForQuestion];
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
    cell.typeImage.image = [UIImage imageNamed:@"开始答题"];
    cell.groups.text = [NSString stringWithFormat:@"共%@道错题",_dictionary[@"questions"][indexPath.section]];
    cell.date.text = [NSString stringWithFormat:@"%@",_dictionary[@"times"][indexPath.section]];
    
    return cell;
}


#pragma mark - getter
- (UIImageView *)backImage{
    if (!_backImage) {
        _backImage = ({
            UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, BAR_H, SCREEN_W, SCREEN_H)];
            imageView.image = [UIImage imageNamed:@"背景6.png"];
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
