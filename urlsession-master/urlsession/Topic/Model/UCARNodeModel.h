//
//  UCARNodeModel.h
//  urlsession
//
//  Created by linux on 2019/8/21.
//  Copyright © 2019 linux. All rights reserved.
//

// import分组次序：Frameworks、Services、UI
#import <Foundation/Foundation.h>

#pragma mark - @class

#pragma mark - 常量

#pragma mark - 枚举

NS_ASSUME_NONNULL_BEGIN

/**
 * node model
 */
@interface UCARNodeModel : NSObject

@property (nonatomic, copy) NSString *avatar_large;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *avatar_normal;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, assign) NSInteger topics;
@property (nonatomic, copy) NSString *footer;
@property (nonatomic, copy) NSString *header;
@property (nonatomic, copy) NSString *title_alternative;
@property (nonatomic, copy) NSString *avatar_mini;
@property (nonatomic, assign) NSInteger stars;
@property (nonatomic, assign) BOOL root;
@property (nonatomic, assign) NSInteger nodeID;
@property (nonatomic, copy) NSString *parent_node_name;

@end

NS_ASSUME_NONNULL_END
