//
//  AppDelegate.m
//  WallaDog
//
//  Created by Fernando Luna on 11/15/15.
//  Copyright © 2015 Dancing Queen. All rights reserved.
//

#import "AppDelegate.h"
#import "AWSMobileClient.h"
#import "WDMainViewController.h"
#import "WDSlideNavigationController.h"

@interface AppDelegate ()

@property(nonatomic, strong) WDMainViewController *mainViewController;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self initWindow];
    [self loadFirstViewController];
    return [[AWSMobileClient sharedInstance] didFinishLaunching:application
                                                    withOptions:launchOptions];
}

- (BOOL)application:(UIApplication *)app
            openURL:(NSURL *)url
            options:(NSDictionary<NSString *,id> *)options {
    return [[AWSMobileClient sharedInstance] withApplication:app
                                                     withURL:url
                                       withSourceApplication:[options objectForKey:UIApplicationOpenURLOptionsSourceApplicationKey]
                                              withAnnotation:[options objectForKey:UIApplicationOpenURLOptionsAnnotationKey]];
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    return [[AWSMobileClient sharedInstance] withApplication:application
                                                     withURL:url
                                       withSourceApplication:sourceApplication
                                              withAnnotation:annotation];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [[AWSMobileClient sharedInstance] applicationDidBecomeActive:application];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Start methods

- (void)initWindow {
    [self setWindow:[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]]];
    [self.window setBackgroundColor:[UIColor whiteColor]];
    [self.window makeKeyAndVisible];
}

- (void)loadFirstViewController {
    self.mainViewController = [[WDMainViewController alloc] init];
    WDSlideNavigationController *navigationViewController = [[WDSlideNavigationController alloc] initWithRootViewController:self.mainViewController];
    
    [self.window setRootViewController:navigationViewController];
}

@end
