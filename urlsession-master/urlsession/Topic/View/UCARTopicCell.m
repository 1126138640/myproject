//
//  UCARTopicCell.m
//  urlsession
//
//  Created by linux on 2019/8/21.
//  Copyright © 2019 linux. All rights reserved.
//

// import分组次序：Frameworks、Services、UI
#import <Masonry/Masonry.h>
#import "UCARTopicCell.h"

#pragma mark - @class

#pragma mark - 常量
const CGFloat UCARTopicCellDetailFontSize = 14.0;

#pragma mark - 枚举

@interface UCARTopicCell ()

#pragma mark - 私有属性
@property (nonatomic, strong, readwrite) UIImageView *memberAvatarImageView;
@property (nonatomic, strong, readwrite) UILabel *titleLabel;
@property (nonatomic, strong, readwrite) UILabel *nodeNameLabel;
@property (nonatomic, strong, readwrite) UILabel *memberNameLabel;
@property (nonatomic, strong, readwrite) UILabel *replyCountLabel;

@end

@implementation UCARTopicCell

#pragma mark - Life cycle

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createSubViews];
        [self createSubViewsConstraints];
    }
    return self;
}

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

- (void)dealloc {
    NSLog(@"%@ - dealloc", NSStringFromClass([self class]));
}

#pragma mark - Events

#pragma mark - UIOtherComponentDelegate

#pragma mark - Custom Delegates

#pragma mark - Public Methods

#pragma mark - Private Methods

// 添加子视图
- (void)createSubViews {
    self.memberAvatarImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:self.memberAvatarImageView];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.titleLabel.numberOfLines = 0;
    [self.contentView addSubview:self.titleLabel];
    
    self.nodeNameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:self.nodeNameLabel];
    
    self.memberNameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.memberNameLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.memberNameLabel];
    
    self.replyCountLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.replyCountLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.replyCountLabel];
}

// 添加约束
- (void)createSubViewsConstraints {
    [self.memberAvatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.height.equalTo(@50);
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.width.equalTo(@50);
    }];
    
    [self.replyCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.height.equalTo(@30);
        make.left.equalTo(self.contentView.mas_left).offset(70);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
    }];
    
    [self.nodeNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-5);
        make.height.equalTo(@30);
        make.left.equalTo(self.contentView.mas_left).offset(70);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
    }];
    
    [self.memberNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-5);
        make.height.equalTo(@30);
        make.left.equalTo(self.contentView.mas_left).offset(70);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-40);
        make.left.equalTo(self.contentView.mas_left).offset(70);
        make.right.equalTo(self.contentView.mas_right).offset(-40);
    }];
}

#pragma mark - Getters and Setters

@end
