//
//  UCARHomeViewController.m
//  urlsession
//
//  Created by linux on 2019/8/20.
//  Copyright © 2019 linux. All rights reserved.
//

// import分组次序：Frameworks、Services、UI
#import <Masonry/Masonry.h>
#import "UCARHomeViewController.h"

#pragma mark - @class

#pragma mark - 常量

#pragma mark - 枚举

@interface UCARHomeViewController ()

#pragma mark - 私有属性

@end

@implementation UCARHomeViewController

#pragma mark - Life cycle
- (instancetype)init {
    self = [super init];
    if (self) {
        self.topicURLString = @"https://www.v2ex.com/api/topics/latest.json";
        self.title = @"Home";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    NSLog(@"%@ - dealloc", NSStringFromClass([self class]));
}

#pragma mark - Events

#pragma mark - UITextFieldDelegate

#pragma mark - UITableViewDataSource

#pragma mark - UITableViewDelegate

#pragma mark - UIOtherComponentDelegate

#pragma mark - Custom Delegates

#pragma mark - Public Methods

#pragma mark - Private Methods

#pragma mark - Getters and Setters

@end
