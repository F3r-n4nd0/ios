//
//  WDStartedViewModels.h
//  WallaDog
//
//  Created by Fernando Luna on 12/22/15.
//  Copyright © 2015 Dancing Queen. All rights reserved.
//

@import Foundation;

@class WDMainViewModel;

@interface WDStartedViewModels : NSObject

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithMainViewModel:(WDMainViewModel*)mainViewModel;

- (void)signUpWithUserName:(NSString*)userName
                     email:(NSString*)email
                  password:(NSString*)password
           completionBlock:(void (^)(NSString *error, NSString *alert, BOOL success))completionBlock;
- (void)logInWithUserName:(NSString*)userName
                  password:(NSString*)password
           completionBlock:(void (^)(NSString *error, NSString *alert, BOOL success))completionBlock;

@end
