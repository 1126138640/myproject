//
//  UCARTopicCell.h
//  urlsession
//
//  Created by linux on 2019/8/21.
//  Copyright © 2019 linux. All rights reserved.
//

// import分组次序：Frameworks、Services、UI
#import <UIKit/UIKit.h>

#pragma mark - @class

#pragma mark - 常量

#pragma mark - 枚举

NS_ASSUME_NONNULL_BEGIN

/**
 * topic cell
 */
@interface UCARTopicCell : UITableViewCell

@property (nonatomic, strong, readonly) UIImageView *memberAvatarImageView;
@property (nonatomic, strong, readonly) UILabel *titleLabel;
@property (nonatomic, strong, readonly) UILabel *nodeNameLabel;
@property (nonatomic, strong, readonly) UILabel *memberNameLabel;
@property (nonatomic, strong, readonly) UILabel *replyCountLabel;

@end

NS_ASSUME_NONNULL_END
