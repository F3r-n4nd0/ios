//
//  WDAccountViewModel.h
//  WallaDog
//
//  Created by Fernando Luna on 2/3/16.
//  Copyright © 2016 Dancing Queen. All rights reserved.
//

@import UIKit;

@class WDUser;
@class WDMainViewModel;

@interface WDAccountViewModel : NSObject

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithUser:(WDUser*)user
               mainViewModel:(WDMainViewModel*)mainViewModel;

- (NSURL*)urlAvatarlUser;
- (NSString*)textUserName;
- (NSString*)textFirstName;
- (NSString*)textLastName;
- (NSString*)textEmail;

-(void)saveChangeWithFirstName:(NSString*)firstName
                      lastName:(NSString*)lastName
                         email:(NSString*)email
                         image:(UIImage*)image
                       success:(void (^)())success
                       failure:(void (^)(NSString *errorDescripcion))failure;
@end
