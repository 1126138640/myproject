//
//  UCARMemberModel.h
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
 * member model
 */
@interface UCARMemberModel : NSObject

@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *website;
@property (nonatomic, copy) NSString *github;
@property (nonatomic, copy) NSString *psn;
@property (nonatomic, copy) NSString *avatar_normal;
@property (nonatomic, copy) NSString *bio;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *tagline;
@property (nonatomic, copy) NSString *twitter;
@property (nonatomic, assign) NSTimeInterval created;
@property (nonatomic, copy) NSString *avatar_large;
@property (nonatomic, copy) NSString *avatar_mini;
@property (nonatomic, copy) NSString *location;
@property (nonatomic, copy) NSString *btc;
@property (nonatomic, assign) NSInteger memberID;

@end

NS_ASSUME_NONNULL_END
