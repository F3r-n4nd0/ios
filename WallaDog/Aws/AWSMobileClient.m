//
//  AWSMobileHubClient.m
//
//
// Copyright 2015 Amazon.com, Inc. or its affiliates (Amazon). All Rights Reserved.
//
// Code generated by AWS Mobile Hub. Amazon gives unlimited permission to 
// copy, distribute and modify it.
//
// Source code generated from template: aws-my-sample-app-ios-objc v0.4
//
#import "AWSMobileClient.h"
#import "AWSConfiguration.h"
#import "AWSIdentityManager.h"
#import <AWSMobileAnalytics/AWSMobileAnalytics.h>

@interface AWSMobileClient ()

@property (nonatomic) AWSCognitoCredentialsProvider *credentialsProvider;
@property (nonatomic) BOOL initialized;

@end

@implementation AWSMobileClient

- (instancetype)init {
    AWSLogDebug(@"init");
    self = [super init];
    _initialized = NO;
    [AWSLogger defaultLogger].logLevel = AWSLogLevelInfo;
    return self;
}

- (void)dealloc {
    // Should never get called
    AWSLogError(@"Dealloc called on singleton AWSMobileClient.");
}

#pragma mark Singleton Methods

+ (instancetype)sharedInstance {
    static AWSMobileClient* client = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        client = [[self alloc] init];
    });
    
    return client;
}

#pragma mark AppDelegate Methods

- (BOOL)didFinishLaunching:(UIApplication *)application
              withOptions:(NSDictionary *)launchOptions {
    AWSLogDebug(@"didFinishLaunching:withOptions:");

    if (!_initialized) {
        [[AWSIdentityManager sharedInstance] resumeSessionWithCompletionHandler:^(id result, NSError *error) {
            NSLog(@"result = %@, error = %@", result, error);
        }];
        _initialized = YES;
    }

    BOOL didFinishLaunching = [[AWSIdentityManager sharedInstance] application:application
                                                 didFinishLaunchingWithOptions:launchOptions];

    return didFinishLaunching;
}

- (BOOL)withApplication:(UIApplication *)application
               withURL:(NSURL *)url
 withSourceApplication:(NSString *)sourceApplication
        withAnnotation:(id)annotation {
    AWSLogDebug(@"withApplication:withURL:...");

    [[AWSIdentityManager sharedInstance] application:application
                                             openURL:url
                                   sourceApplication:sourceApplication
                                          annotation:annotation];

    if (!_initialized) {
        _initialized = YES;
    }

    return NO;
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    AWSLogDebug(@"applicationDidBecomeActive");
    [self initializeMobileAnalytics];
}


#pragma mark - AWS Methods

- (void)initializeMobileAnalytics {
    if (_mobileAnalytics == nil) {
        _mobileAnalytics = [AWSMobileAnalytics mobileAnalyticsForAppId:AMAZON_MOBILE_ANALYTICS_APP_ID
                                                        identityPoolId:AMAZON_COGNITO_IDENTITY_POOL_ID];
        AWSLogInfo(@"Amazon Mobile Analytics OK");
    }
}
@end
