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
- (void)addRecordWithQuestions:(NSDictionary *)questions successBlock:(void(^)(BOOL succeed))succeed failure:(void(^)(NSError * error))failure{
    //判断时间，判断是不是今天加过数据
    NSDate * date = [NSDate date];
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy/MM/dd"];
    NSString * time = [formatter stringFromDate:date];
    
    AVUser * currentUser = [AVUser currentUser];
    NSMutableDictionary * dictionary = [[NSMutableDictionary alloc] initWithDictionary:[currentUser objectForKey:@"records"]];
    
    NSArray * keys = [NSArray arrayWithArray:dictionary.allKeys];
            if (keys.count) {
                for (int i = 0; i < keys.count; i ++) {
                    if ([keys[i] isEqualToString:time]) {
                        NSMutableArray * groups = [NSMutableArray arrayWithArray:dictionary[keys[i]]];
                        for (int j = 0; j < groups.count; j ++) {
                            if (groups[j][@"type"] == questions[@"type"] && groups[j][@"level"] == questions[@"level"]) {
                                [groups replaceObjectAtIndex:j withObject:questions];
                                return;
                            }else if (j == groups.count - 1){
                                [groups addObject:questions];
                            }
                        }
                        [dictionary setObject:groups forKey:time];
                    }else if (i == keys.count - 1){
                        [dictionary setObject:@[questions] forKey:time];
                    }
                }
            }else{
                [dictionary setObject:@[questions] forKey:time];
            }
            [currentUser setObject:dictionary forKey:@"records"];
            [currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                    succeed(succeeded);
                }else{
                    failure(error);
                }
            }];
}
- (void)addMistakeWithQuestion:(NSDictionary *)question successBlock:(void(^)(BOOL succeed))succeed failure:(void(^)(NSError * error))failure{
    //判断时间，判断是不是今天加过数据
    NSDate * date = [NSDate date];
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy/MM/dd"];
    NSString * time = [formatter stringFromDate:date];
    
    AVUser * currentUser = [AVUser currentUser];
    NSMutableDictionary * dictionary = [[NSMutableDictionary alloc] initWithDictionary:[currentUser objectForKey:@"mistakes"]];

            NSArray * keys = [NSArray arrayWithArray:dictionary.allKeys];
            if (keys.count) {
                for (int i = 0; i < keys.count; i ++) {
                    if ([keys[i] isEqualToString:time]) {
                        NSMutableArray * questions = [NSMutableArray arrayWithArray:dictionary[keys[i]]];
                        [questions addObject:question];
                        [dictionary setObject:questions forKey:time];
                    }else if (i == keys.count - 1){
                        [dictionary setObject:@[question] forKey:time];
                    }
                }
            }else{
                [dictionary setObject:@[question] forKey:time];
            }
            [currentUser setObject:dictionary forKey:@"mistakes"];
            [currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                if (succeeded) {
                    succeed(succeeded);
                }else{
                    failure(error);
                }
            }];

}
- (void)removeMistakeWithQuestion:(NSDictionary *)question successBlock:(void(^)(BOOL succeed))succeed failure:(void(^)(NSError * error))failure{
    //判断时间，判断是不是今天加过数据
    NSDate * date = [NSDate date];
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy/MM/dd"];
    NSString * time = [formatter stringFromDate:date];
    
    
    AVUser * currentUser = [AVUser currentUser];
    AVQuery *query = [AVQuery queryWithClassName:@"data"];
    [query whereKey:@"objectId" equalTo:DATAID];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (objects) {
            NSArray<AVObject *> *priorityEqualsZeroTodos = objects;
            NSMutableDictionary * dictionary = [[NSMutableDictionary alloc] initWithDictionary:[priorityEqualsZeroTodos[0] objectForKey:@"mistakes"]];
            NSArray * keys = [NSArray arrayWithArray:dictionary.allKeys];
            if (keys.count) {
                for (int i = 0; i < keys.count; i ++) {
                    if ([keys[i] isEqualToString:time]) {
                        NSMutableArray * questions = [NSMutableArray arrayWithArray:dictionary[keys[i]]];
                        [questions removeObject:question];
                        [dictionary setObject:questions forKey:time];
                    }else if (i == keys.count - 1){
                        [dictionary setObject:@[question] forKey:time];
                    }
                }
            }else{
                [dictionary setObject:@[question] forKey:time];
            }
            [currentUser setObject:dictionary forKey:@"mistakes"];
            [currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//                if (succeeded) {
//                    succeed(succeeded);
//                }else{
//                    failure(error);
//                }
            }];
            NSLog(@"储存成功");
        }
    }];
}

#pragma mark - 获取列表
- (NSDictionary *)getRecordsListSuccessBlock:(void(^)(BOOL succeed))succeed failure:(void(^)(NSError * error))failure{
    
    NSMutableArray * arrayTimes = [NSMutableArray array];
    NSMutableArray * arrayGroups = [NSMutableArray array];
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    
    AVUser * currentUser = [AVUser currentUser];
    NSMutableDictionary * dictionary = [[NSMutableDictionary alloc] initWithDictionary:[currentUser objectForKey:@"records"]];
    
            NSArray * keys = [NSArray arrayWithArray:dictionary.allKeys];
            for (int i = 0; i < keys.count; i ++) {
                [arrayTimes addObject:keys[i]];
                [arrayGroups addObject:[NSNumber numberWithLong:[dictionary[keys[i]] count]]];
            }
            [dic setDictionary:@{@"count":[NSNumber numberWithLong:keys.count], @"times":arrayTimes, @"groups":arrayGroups}];

    return dic;
}
- (NSArray *)getRecordOfOneDayListWithDate:(NSString *)date successBlock:(void(^)(BOOL succeed))succeed failure:(void(^)(NSError * error))failure{
    
    NSMutableArray * array = [NSMutableArray array];
    
    AVUser * currentUser = [AVUser currentUser];
    NSMutableDictionary * dictionary = [[NSMutableDictionary alloc] initWithDictionary:[currentUser objectForKey:@"records"]];
            NSArray * keys = [NSArray arrayWithArray:dictionary.allKeys];
            for (int i = 0; i < keys.count; i ++) {
                if ([date isEqualToString:keys[i]]) {
                    [array addObjectsFromArray:dictionary[keys[i]]];
                }
            }

    return array;
}
- (NSDictionary *)getMistakesListSuccessBlock:(void(^)(BOOL succeed))succeed failure:(void(^)(NSError * error))failure{
    
    NSMutableArray * arrayTimes = [NSMutableArray array];
    NSMutableArray * arrayQuestions = [NSMutableArray array];
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    
    AVUser * currentUser = [AVUser currentUser];
    NSMutableDictionary * dictionary = [[NSMutableDictionary alloc] initWithDictionary:[currentUser objectForKey:@"mistakes"]];
            NSArray * keys = [NSArray arrayWithArray:dictionary.allKeys];
            for (int i = 0; i < keys.count; i ++) {
                [arrayTimes addObject:keys[i]];
                [arrayQuestions addObject:[NSNumber numberWithLong:[dictionary[keys[i]] count]]];
            }
            [dic setDictionary:@{@"count":[NSNumber numberWithLong:keys.count], @"times":arrayTimes, @"questions":arrayQuestions}];
    
    return dic;
}
- (NSArray *)getMistakesWithDate:(NSString *)date{
    
    NSMutableArray * array = [NSMutableArray array];
    
    AVUser * currentUser = [AVUser currentUser];
    NSMutableDictionary * dictionary = [[NSMutableDictionary alloc] initWithDictionary:[currentUser objectForKey:@"mistakes"]];
    NSArray * keys = [NSArray arrayWithArray:dictionary.allKeys];
    for (int i = 0; i < keys.count; i ++) {
        if ([keys[i] isEqualToString:date]) {
            [array addObjectsFromArray:dictionary[keys[i]]];
        }
    }
    return array;
}

@end
