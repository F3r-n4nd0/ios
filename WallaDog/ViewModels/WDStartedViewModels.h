//
//  WDStartedViewModels.h
//  WallaDog
//
//  Created by Fernando Luna on 12/22/15.
//  Copyright © 2015 Dancing Queen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WDStartedViewModels : NSObject

- (void)signUpWithFullName:(NSString*)fullName
                     email:(NSString*)email
                  password:(NSString*)password
           completionBlock:(void (^)(NSError *error, NSString *alert, BOOL finished))completionBlock;

@end
