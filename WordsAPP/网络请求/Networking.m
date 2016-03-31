//
//  Networking.m
//  WordsAPP
//
//  Created by rimi on 16/3/28.
//  Copyright © 2016年 zhugaoqiang. All rights reserved.
//

#import "Networking.h"
#import <AVOSCloud/AVOSCloud.h>

@interface Networking ()


@property (nonatomic, retain) UIImage * image;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSArray * imageTypes;
@property (nonatomic, retain) NSArray * nameTypes;



@end

@implementation Networking

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}

#pragma mark - 加载图片、名字
- (void)getimageType:(ImageType)imageType index:(NSInteger)index success:(void(^)(UIImage *image))image failure:(void(^)(NSError *error))failure{
    _imageTypes = [NSArray arrayWithObjects:@"fruit",@"vegetables",@"animals",@"articles",@"sport", nil];
    
    AVQuery *query = [AVQuery queryWithClassName:@"data"];
    [query whereKey:@"objectId" equalTo:DATAID];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (objects) {
            NSArray<AVObject *> *priorityEqualsZeroTodos = objects;
            NSArray * images = priorityEqualsZeroTodos[0][_imageTypes[imageType - 1]];
            NSInteger indexOne = index % images.count;
            NSString * imageTitle = images[indexOne];
            NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageTitle]];
            _image = [UIImage imageWithData:data];
            image(_image);
        }else{
            failure(error);
        }
    }];
    
}
- (void)getNameWithType:(nameType)nameType index:(NSInteger)index successBlock:(void(^)(NSString *name))name failure:(void(^)(NSError * error))failure{
    _nameTypes = [NSArray arrayWithObjects:@"fruitWords",@"vegetablesWords",@"animalsWords",@"articlesWords",@"sportWords", nil];
    
    AVQuery *query = [AVQuery queryWithClassName:@"data"];
    [query whereKey:@"objectId" equalTo:DATAID];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (objects) {
            NSArray<AVObject *> *priorityEqualsZeroTodos = objects;
            NSArray * words = priorityEqualsZeroTodos[0][_nameTypes[nameType]];
            NSInteger indexOne = index % words.count;
            _name = [NSString stringWithString:words[indexOne]];
            name(_name);
        }else{
            failure(error);
        }
    }];
}

#pragma mark - 添加数据
- (void)addRecordWithQuestions:(NSDictionary *)questions{
    //判断时间，判断是不是今天加过数据
    NSDate * date = [NSDate date];
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy/MM/dd"];
    NSString * time = [formatter stringFromDate:date];
    
    AVUser * currentUser = [AVUser currentUser];
    NSDictionary * dictionary = [[NSDictionary alloc] initWithDictionary:[currentUser objectForKey:@"records"]];
    if (dictionary) {
        NSArray * keys = [NSArray arrayWithArray:dictionary.allKeys];
        for (int i = 0; i < keys.count; i ++) {
            if ([keys[i] isEqualToString:time]) {
                NSMutableArray * groups = [NSMutableArray arrayWithArray:dictionary[keys[i]]];
                [groups addObject:questions];
                [dictionary setValue:groups forKey:time];
            }else if (i == keys.count - 1){
                [dictionary setValue:@[questions] forKey:time];
            }
        }
        [currentUser setValue:dictionary forKey:@"records"];
        [currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                NSLog(@"数据添加成功");
            }else{
                NSLog(@"数据添加失败----%@",error);
            }
        }];
    }
    
}
- (void)addMistakeWithQuestion:(NSDictionary *)question{
    //判断时间，判断是不是今天加过数据
    NSDate * date = [NSDate date];
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy/MM/dd"];
    NSString * time = [formatter stringFromDate:date];
    
    AVUser * currentUser = [AVUser currentUser];
    NSDictionary * dictionary = [[NSDictionary alloc] initWithDictionary:[currentUser objectForKey:@"mistakes"]];
    if (dictionary) {
        NSArray * keys = [NSArray arrayWithArray:dictionary.allKeys];
        for (int i = 0; i < keys.count; i ++) {
            if ([keys[i] isEqualToString:time]) {
                NSMutableArray * questions = [NSMutableArray arrayWithArray:dictionary[keys[i]]];
                [questions addObject:question];
                [dictionary setValue:questions forKey:time];
            }else if (i == keys.count - 1){
                [dictionary setValue:@[question] forKey:time];
            }
        }
        [currentUser setValue:dictionary forKey:@"mistakes"];
        [currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                NSLog(@"错题添加成功");
            }else{
                NSLog(@"错题添加失败----%@",error);
            }
        }];
    }
}
- (void)removeMistakeWithQuestion:(NSDictionary *)question{
    //判断时间，判断是不是今天加过数据
    NSDate * date = [NSDate date];
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy/MM/dd"];
    NSString * time = [formatter stringFromDate:date];
    
    AVUser * currentUser = [AVUser currentUser];
    NSDictionary * dictionary = [[NSDictionary alloc] initWithDictionary:[currentUser objectForKey:@"mistakes"]];
    if (dictionary) {
        NSArray * keys = [NSArray arrayWithArray:dictionary.allKeys];
        for (int i = 0; i < keys.count; i ++) {
            if ([keys[i] isEqualToString:time]) {
                NSMutableArray * questions = [NSMutableArray arrayWithArray:dictionary[keys[i]]];
                [questions removeObject:question];
                [dictionary setValue:questions forKey:time];
            }else if (i == keys.count - 1){
                NSLog(@"无此错题");
            }
        }
        [currentUser setValue:dictionary forKey:@"mistakes"];
        [currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                NSLog(@"错题删除成功");
            }else{
                NSLog(@"错题删除失败----%@",error);
            }
        }];
    }
}

#pragma mark - 获取列表
- (NSDictionary *)getRecordsList{
    
    NSMutableArray * arrayTimes = [NSMutableArray array];
    NSMutableArray * arrayGroups = [NSMutableArray array];
    
    AVUser *currentUser = [AVUser currentUser];
    NSDictionary * dictionary = [[NSDictionary alloc] initWithDictionary:[currentUser objectForKey:@"records"]];
    if (dictionary) {
        NSArray * keys = [NSArray arrayWithArray:dictionary.allKeys];
        for (int i = 0; i < keys.count; i ++) {
            [arrayTimes addObject:keys[i]];
            [arrayGroups addObject:[NSNumber numberWithLong:[dictionary[keys[i]] count]]];
        }
        NSDictionary * dic = @{@"count":[NSNumber numberWithLong:keys.count], @"times":arrayTimes, @"groups":arrayGroups};
        return dic;
    }
    return nil;
}
- (NSArray *)getRecordOfOneDayListWithDate:(NSString *)date{
    
    AVUser *currentUser = [AVUser currentUser];
    NSDictionary * dictionary = [[NSDictionary alloc] initWithDictionary:[currentUser objectForKey:@"records"]];
    if (dictionary) {
        NSArray * keys = [NSArray arrayWithArray:dictionary.allKeys];
        for (int i = 0; i < keys.count; i ++) {
            if ([date isEqualToString:keys[i]]) {
                return dictionary[keys[i]];
            }
        }
    }
    return nil;
}
- (NSDictionary *)getMistakesList{
    
    NSMutableArray * arrayTimes = [NSMutableArray array];
    NSMutableArray * arrayQuestions = [NSMutableArray array];
    
    AVUser *currentUser = [AVUser currentUser];
    NSDictionary * dictionary = [currentUser objectForKey:@"mistakes"];
    if (dictionary) {
        NSArray * keys = [NSArray arrayWithArray:dictionary.allKeys];
        for (int i = 0; i < keys.count; i ++) {
            [arrayTimes addObject:keys[i]];
            [arrayQuestions addObject:[NSNumber numberWithLong:[dictionary[keys[i]] count]]];
        }
        NSDictionary * dic = @{@"count":[NSNumber numberWithLong:keys.count], @"times":arrayTimes, @"questions":arrayQuestions};
        return dic;
    }
    return nil;
}

@end
