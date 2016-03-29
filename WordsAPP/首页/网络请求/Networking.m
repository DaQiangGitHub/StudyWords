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

#pragma mark - 网络请求
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


@end
