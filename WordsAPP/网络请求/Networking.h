//
//  Networking.h
//  WordsAPP
//
//  Created by rimi on 16/3/28.
//  Copyright © 2016年 zhugaoqiang. All rights reserved.
//

#import <UIKit/UIKit.h>


#define DATAID @"56f8f7bb1ea49300591ff421"

typedef NS_OPTIONS(NSUInteger, ImageType) {
    fruit = 1,
    vegetables = 2,
    animals = 3,
    articles = 4,
    sport = 5
};
typedef NS_ENUM(NSUInteger, nameType) {
    fruitWords,
    vegetablesWords,
    animalsWords,
    articlesWords,
    sportWords
};

@interface Networking : UIViewController
//取
- (void)getimageType:(ImageType)imageType index:(NSInteger)index success:(void(^)(UIImage *image))image failure:(void(^)(NSError *error))failure;
- (void)getNameWithType:(nameType)nameType index:(NSInteger)index successBlock:(void(^)(NSString *name))name failure:(void(^)(NSError *error))failure;
//加
- (void)addRecordWithQuestions:(NSDictionary *)question successBlock:(void(^)(BOOL succeed))succeed failure:(void(^)(NSError * error))failure;
- (void)addMistakeWithQuestion:(NSDictionary *)question successBlock:(void(^)(BOOL succeed))succeed failure:(void(^)(NSError * error))failure;
- (void)removeMistakeWithQuestion:(NSDictionary *)question;
//取列表
- (NSDictionary *)getRecordsList;
- (NSArray *)getRecordOfOneDayListWithDate:(NSString *)date;
- (NSDictionary *)getMistakesList;

@end
