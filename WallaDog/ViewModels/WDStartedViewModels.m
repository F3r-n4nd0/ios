//
//  WDStartedViewModels.m
//  WallaDog
//
//  Created by Fernando Luna on 12/22/15.
//  Copyright © 2015 Dancing Queen. All rights reserved.
//

#import "WDStartedViewModels.h"
#import "WDHTTPClient.h"
#import "WDUser.h"
#import "WDMainViewModel.h"

@interface WDStartedViewModels ()

@property(nonatomic, strong)WDMainViewModel *mainViewModel;

@end



@implementation WDStartedViewModels

- (instancetype)initWithMainViewModel:(WDMainViewModel*)mainViewModel {
    if(self = [super init]){
        _mainViewModel = mainViewModel;
    }
    return self;
}


- (void)signUpWithUserName:(NSString*)userName
                     email:(NSString*)email
                  password:(NSString*)password
           completionBlock:(void (^)(NSString *error, NSString *alert, BOOL success))completionBlock {
    
    NSString *alert = [self veryfyDataToSignUpWithUserName:userName email:email password:password];
    if(![alert isEqualToString:@""]) {
        completionBlock(nil,alert,NO);
        return;
    }
    [[WDHTTPClient sharedWDHTTPClient] signUpWithUserName:userName
                                                    email:email
                                                 password:password
                                                  success:^(id responseObject)
     {
         WDUser *user = [[WDUser alloc] initWithDictionary:responseObject];
         if(user) {
             [self loginAndGetAuthorizationTokenWithUserName:userName
                                                    password:password
                                             completionBlock:completionBlock];
             return;
         }
         completionBlock(@"Error sign up",nil,NO);
     } failure:^(NSString *errorDescripcion) {
         completionBlock(errorDescripcion,nil,NO);
     }];
}

- (void)loginAndGetAuthorizationTokenWithUserName:(NSString*)userName
                                         password:(NSString*)password
                                  completionBlock:(void (^)(NSString *error, NSString *alert, BOOL success))completionBlock {
    
    [[WDHTTPClient sharedWDHTTPClient] loginAndobtainAuthorizationTokenWithUserName:userName
                                                                           password:password
                                                                    complitionBLock:
     ^{
         [self.mainViewModel showMainView];
         completionBlock(nil,nil,YES);
     } complitionError:^(NSString *error) {
          completionBlock(error.description,nil,NO);
     }];
}

- (NSString*)veryfyDataToSignUpWithUserName:(NSString*)userName
                                      email:(NSString*)email
                                   password:(NSString*)password {
    NSString *result = @"";
    if(userName.length == 0) {
        result = [result stringByAppendingString:@"User name requiered"];
    }
    if(userName.length <= 3) {
        result = [result stringByAppendingString:@"\nUser name need more than 3 characters"];
    }
    if(email.length == 0) {
        result = [result stringByAppendingString:@"\nEmail requiered"];
    }
    if(email.length == 0) {
        result = [result stringByAppendingString:@"\nPassword requiered"];
    }
    return result;
}


@end
