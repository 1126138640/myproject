//
//  AppDelegate.m
//  urlsession
//
//  Created by linux on 2019/8/20.
//  Copyright © 2019 linux. All rights reserved.
//

#import "AppDelegate.h"
#import "UCARHomeViewController.h"
#import "UCARHotViewController.h"

@interface AppDelegate () <UITabBarControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    self.window.rootViewController = [self naviRootVC];
    self.window.rootViewController = [self tabRootVC];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
//    https://pixabay.com/api/?key=6417729-8d51a494750542ba7338e8800&q=cat
    
    return YES;
}

#pragma mark - tab root

- (UITabBarController *)tabRootVC {
    UCARHomeViewController *homeVC = [[UCARHomeViewController alloc] init];
    UCARHotViewController *topTenVC = [[UCARHotViewController alloc] init];
    
    homeVC.tabBarItem.image = [UIImage imageNamed:@"tabbar_home"];
    topTenVC.tabBarItem.image = [UIImage imageNamed:@"tabbar_topten"];
    
    UINavigationController *homeNC = [[UINavigationController alloc] initWithRootViewController:homeVC];
    UINavigationController *topTenNC = [[UINavigationController alloc] initWithRootViewController:topTenVC];
    
    UITabBarController *mainTabVC = [[UITabBarController alloc] init];
    mainTabVC.viewControllers = @[homeNC, topTenNC];
    
    
    return mainTabVC;
}

#pragma mark - navi root

- (UINavigationController *)naviRootVC {
    UCARHomeViewController *homeVC = [[UCARHomeViewController alloc] init];
    UCARHotViewController *topTenVC = [[UCARHotViewController alloc] init];
    
    homeVC.tabBarItem.image = [UIImage imageNamed:@"tabbar_home"];
    topTenVC.tabBarItem.image = [UIImage imageNamed:@"tabbar_topten"];
    
    UITabBarController *tabVC = [[UITabBarController alloc] init];
    tabVC.viewControllers = @[homeVC, topTenVC];
    tabVC.delegate = self;
    tabVC.title = homeVC.title;
    
    UINavigationController *mainNC = [[UINavigationController alloc] initWithRootViewController:tabVC];
    return mainNC;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    tabBarController.title = viewController.title;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
