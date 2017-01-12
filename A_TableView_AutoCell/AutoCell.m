//
//  AutoCell.m
//  A_TableView_AutoCell
//
//  Created by Zin_戦 on 17/1/9.
//  Copyright © 2017年 Zin_戦. All rights reserved.
//

#import "AutoCell.h"
#import <Masonry.h>
@interface AutoCell()

@property (nonatomic, strong)  UILabel     *titleLabel;
@property (nonatomic, strong)  UILabel     *contentLabel;
@property (nonatomic, strong)  UIImageView *contentImageView;
@property (nonatomic, strong)  UILabel     *usernameLabel;
@property (nonatomic, strong)  UILabel     *timeLabel;

@end


@implementation AutoCell


/** 初始化方法,自定义 cell时,不清楚高度,可以在这里添加子空间 */
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupUI];
    }
    return self;
}

- (void)setupUI{

    _titleLabel                       = [UILabel new];
    _titleLabel.textColor             = [UIColor redColor];
    
    _contentLabel                     = [UILabel new];
    _contentLabel.numberOfLines       = 0;
    _contentLabel.textColor           = [UIColor orangeColor];
    
    _contentImageView                 = [UIImageView new];
    _contentImageView.backgroundColor = [UIColor greenColor];
    
    _usernameLabel                    = [UILabel new];
    _usernameLabel.textColor          = [UIColor purpleColor];
    
    _timeLabel                        = [UILabel new];
    _timeLabel.textColor              = [UIColor darkGrayColor];
    
    UIView *line                      = [[UIView alloc]init];
    line.backgroundColor              = [UIColor lightGrayColor];
    
    [self.contentView addSubview:_titleLabel];
    [self.contentView addSubview:_contentLabel];
    [self.contentView addSubview:_contentImageView];
    [self.contentView addSubview:_usernameLabel];
    [self.contentView addSubview:_timeLabel];
    [self.contentView addSubview:line];
    
}

- (void)setModel:(ModelEntity *)model{

    _model = model;
    _titleLabel.text = model.title;
    _contentLabel.text = model.content;
    _contentImageView.image = model.imageName.length > 0 ? [UIImage imageNamed:model.imageName] : nil;
    _usernameLabel.text = model.username;
    _timeLabel.text = model.time;
    [self setLayOut];
}

- (void)setLayOut{

    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(5);
        make.left.equalTo(self.contentView.mas_left).offset(5);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        
    }];
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.left.equalTo(_titleLabel.mas_left);
    }];
    [_contentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentLabel.mas_bottom).offset(5);
        make.left.equalTo(_titleLabel.mas_left);
        make.right.equalTo(self.contentImageView.mas_right);
        
    }];
    [_usernameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentImageView.mas_bottom).offset(5);
        make.left.equalTo(self.contentView.mas_left).offset(5);
        make.right.equalTo(self.contentView.mas_right);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentImageView.mas_bottom).offset(5);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
//        make.left.equalTo(self.contentView.mas_left).offset(5);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
    

}


@end
