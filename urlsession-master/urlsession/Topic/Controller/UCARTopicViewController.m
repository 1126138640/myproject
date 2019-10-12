//
//  UCARTopicViewController.m
//  urlsession
//
//  Created by linux on 2019/8/21.
//  Copyright © 2019 linux. All rights reserved.
//

// import分组次序：Frameworks、Services、UI
#import <Masonry/Masonry.h>
#import "UCARTopicViewController.h"

#import "UCARTopicCell.h"
#import "UCARTopicModel.h"

#pragma mark - @class

#pragma mark - 常量
NSString * const UCARTopicCellReuseIdentifier = @"cell";

#pragma mark - 枚举

@interface UCARTopicViewController ()<UITableViewDelegate, UITableViewDataSource>

#pragma mark - 私有属性
@property (nonatomic, strong) NSURLSession *URLSession;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<UCARTopicModel *> *topicArray;
@property (nonatomic, strong) NSMutableDictionary *imageCacheDict;

@end

@implementation UCARTopicViewController

#pragma mark - Life cycle
- (instancetype)init {
    self = [super init];
    if (self) {
        self.topicURLString = @"";
        self.URLSession = [NSURLSession sharedSession];
        self.imageCacheDict = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureNavigationbar];
    [self createSubViews];
    [self createSubViewsConstraints];
    [self fetchData];
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

- (void)httpGet {
    NSURL *getURL = [NSURL URLWithString:@"http://localhost:5000/get"];
    NSURLSessionDataTask *getTask = [self.URLSession dataTaskWithURL:getURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"dict %@", dict);
        } else {
            NSLog(@"error %@", error);
        }
    }];
    [getTask resume];
}

- (void)httpPost {
    NSDictionary *dict = @{@"home": @"post"};
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
    NSURL *postURL = [NSURL URLWithString:@"http://localhost:5000/post"];
    NSMutableURLRequest *postRequest = [NSMutableURLRequest requestWithURL:postURL];
    postRequest.HTTPMethod = @"POST";
    postRequest.HTTPBody = data;
    //响应头
    [postRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSURLSessionDataTask *postTask = [self.URLSession uploadTaskWithRequest:postRequest fromData:data completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"dict %@", dict);
        } else {
            NSLog(@"error %@", error);
        }
    }];
    [postTask resume];
}
#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.topicArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UCARTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:UCARTopicCellReuseIdentifier forIndexPath:indexPath];
    
    UCARTopicModel *topicModel = self.topicArray[indexPath.row];
    cell.titleLabel.text = topicModel.title;
    cell.nodeNameLabel.text = topicModel.node.name;
    cell.memberNameLabel.text = topicModel.member.username;
    cell.replyCountLabel.text = @(topicModel.replies).stringValue;
    
    NSString *imageURL = topicModel.member.avatar_normal;
    imageURL = [@"https:" stringByAppendingString:imageURL];
    NSURL *cachedImageURL = self.imageCacheDict[imageURL];
    if (cachedImageURL) {
        //hit
        cell.memberAvatarImageView.image = [self imageForURL:cachedImageURL];
    } else {
        //miss
        [self downloadImage:imageURL forCell:cell];
    }
    
    return cell;
}


#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

#pragma mark - UITableViewDelegate

#pragma mark - UIOtherComponentDelegate

#pragma mark - Custom Delegates

#pragma mark - Public Methods

#pragma mark - Private Methods
// 配置导航栏
- (void)configureNavigationbar {
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"get" style:UIBarButtonItemStylePlain target:self action:@selector(httpGet)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"post" style:UIBarButtonItemStylePlain target:self action:@selector(httpPost)];
}

// 添加子视图
- (void)createSubViews {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.tableView registerClass:[UCARTopicCell class] forCellReuseIdentifier:UCARTopicCellReuseIdentifier];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

// 添加约束
- (void)createSubViewsConstraints {
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
        make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
    }];
}

- (void)fetchData {
    //从
    if (self.topicURLString.length < 1) {
        NSLog(@"error, topicURL must not be nil");
        return;
    }
    
    
    NSURL *topicURL = [NSURL URLWithString:self.topicURLString];
    NSURLSessionDataTask *topicTask = [self.URLSession dataTaskWithURL:topicURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            NSArray *topicList = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            [self parseTopics:topicList];
        } else {
            NSLog(@"error %@", error);
        }
    }];
    [topicTask resume];
}

- (void)parseTopics:(NSArray<NSDictionary *> *)topics {
    NSMutableArray *topicArray = [NSMutableArray array];
    
    [topics enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UCARTopicModel *topicModel = [[UCARTopicModel alloc] init];
        topicModel.node = [self nodeModelOfTopic:obj];
        topicModel.member = [self memberModelOfTopic:obj];
        topicModel.last_reply_by = obj[@"last_reply_by"];
        topicModel.last_touched = [obj[@"last_touched"] integerValue];
        topicModel.title = obj[@"title"];
        topicModel.url = obj[@"url"];
        topicModel.created = [obj[@"created"] integerValue];
        topicModel.content = obj[@"content"];
        topicModel.content_rendered = obj[@"content_rendered"];
        topicModel.last_modified = [obj[@"last_modified"] integerValue];
        topicModel.replies = [obj[@"replies"] integerValue];
        topicModel.topicID = [obj[@"id"] integerValue];
        
        [topicArray addObject:topicModel];
    }];
    self.topicArray = topicArray;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

- (UCARNodeModel *)nodeModelOfTopic:(NSDictionary *)topic {
    NSDictionary *node = topic[@"node"];
    UCARNodeModel *nodeModel = [[UCARNodeModel alloc] init];
    nodeModel.avatar_large = node[@"avatar_large"];
    nodeModel.name = node[@"name"];
    nodeModel.avatar_normal = node[@"avatar_normal"];
    nodeModel.title = node[@"title"];
    nodeModel.url = node[@"url"];
    nodeModel.topics = [node[@"topics"] integerValue];
    nodeModel.footer = node[@"footer"];
    nodeModel.header = node[@"header"];
    nodeModel.title_alternative = node[@"title_alternative"];
    nodeModel.avatar_mini = node[@"avatar_mini"];
    nodeModel.stars = [node[@"stars"] integerValue];
    nodeModel.root = [node[@"root"] boolValue];
    nodeModel.nodeID = [node[@"id"] integerValue];
    nodeModel.parent_node_name = node[@"parent_node_name"];
    
    return nodeModel;
}

- (UCARMemberModel *)memberModelOfTopic:(NSDictionary *)topic {
    NSDictionary *member = topic[@"member"];
    UCARMemberModel *memberModel = [[UCARMemberModel alloc] init];
    memberModel.username = member[@"username"];
    memberModel.website = member[@"website"];
    memberModel.github = member[@"github"];
    memberModel.psn = member[@"psn"];
    memberModel.avatar_normal = member[@"avatar_normal"];
    memberModel.bio = member[@"bio"];
    memberModel.url = member[@"url"];
    memberModel.tagline = member[@"tagline"];
    memberModel.twitter = member[@"twitter"];
    memberModel.created = [member[@"created"] integerValue];
    memberModel.avatar_large = member[@"avatar_large"];
    memberModel.avatar_mini = member[@"avatar_mini"];
    memberModel.location = member[@"location"];
    memberModel.btc = member[@"btc"];
    memberModel.memberID = [member[@"id"] integerValue];
    
    return memberModel;
}

- (void)downloadImage:(NSString *)imageURL forCell:(UCARTopicCell *)cell {
    //缓冲池，在处理图片的时候一般要把图片缓冲下来以减少流量损耗
    NSURL *downloadURL = [NSURL URLWithString:imageURL];
    NSURLSessionDownloadTask *task = [self.URLSession downloadTaskWithURL:downloadURL completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSURL *cachedImageURL = [self writeImageToCacheFromLocation:location forDownloadURL:downloadURL];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.imageCacheDict[imageURL] = cachedImageURL;
            cell.memberAvatarImageView.image = [self imageForURL:cachedImageURL];
        });
    }];
    [task resume];
}

- (UIImage *)imageForURL:(NSURL *)imageURL {
    NSData *data = [NSData dataWithContentsOfURL:imageURL];
    UIImage *image = [UIImage imageWithData:data];
    return image;
}

- (NSURL *)writeImageToCacheFromLocation:(NSURL *)location forDownloadURL:(NSURL *)downloadURL {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *applicationSupportURL = [[fileManager URLsForDirectory:NSApplicationSupportDirectory inDomains:NSUserDomainMask] lastObject];
    NSString *imageDirPath = [applicationSupportURL.path stringByAppendingPathComponent:@"image"];
    
    if (![fileManager fileExistsAtPath:imageDirPath]) {
        [fileManager createDirectoryAtPath:imageDirPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    NSString *fileName = [downloadURL.path lastPathComponent];
    NSString *imagePath = [imageDirPath stringByAppendingPathComponent:fileName];
    NSURL *imageURL = [NSURL fileURLWithPath:imagePath];
    [fileManager copyItemAtURL:location toURL:imageURL error:nil];
    return imageURL;
}

#pragma mark - Getters and Setters

@end
