//
//  HomePageTableViewCell.m
//  WordsAPP
//
//  Created by rimi on 16/3/23.
//  Copyright © 2016年 zhugaoqiang. All rights reserved.
//

#import "HomePageTableViewCell.h"

@interface HomePageTableViewCell ()



@end

@implementation HomePageTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initializeUserInterface];
    }
    return self;
}

- (void)initializeUserInterface
{
    [self.contentView addSubview:self.fruitImageView];
}

#pragma  mark -- getter
- (UIImageView *)fruitImageView
{
    if (!_fruitImageView) {
        _fruitImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 300, 80)];
        _fruitImageView.center = CGPointMake(414 / 2, 70);
    }
    return _fruitImageView;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
