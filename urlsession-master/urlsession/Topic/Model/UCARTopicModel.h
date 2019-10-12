//
//  UCARTopicModel.h
//  urlsession
//
//  Created by linux on 2019/8/21.
//  Copyright © 2019 linux. All rights reserved.
//

// import分组次序：Frameworks、Services、UI
#import <Foundation/Foundation.h>
#import "UCARNodeModel.h"
#import "UCARMemberModel.h"

#pragma mark - @class

#pragma mark - 常量

#pragma mark - 枚举

NS_ASSUME_NONNULL_BEGIN

/**
 * topic model
 */
@interface UCARTopicModel : NSObject

@property (nonatomic, strong) UCARNodeModel *node;
@property (nonatomic, strong) UCARMemberModel *member;

@property (nonatomic, copy) NSString *last_reply_by;
@property (nonatomic, assign) NSTimeInterval last_touched;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, assign) NSTimeInterval created;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *content_rendered;
@property (nonatomic, assign) NSTimeInterval last_modified;
@property (nonatomic, assign) NSInteger replies;
@property (nonatomic, assign) NSInteger topicID;

@end

NS_ASSUME_NONNULL_END
