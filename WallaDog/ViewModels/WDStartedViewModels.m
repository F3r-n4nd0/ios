//
//  WDStartedViewModels.m
//  WallaDog
//
//  Created by Fernando Luna on 12/22/15.
//  Copyright © 2015 Dancing Queen. All rights reserved.
//

#import "WDStartedViewModels.h"

@implementation WDStartedViewModels

- (void)signUpWithFullName:(NSString*)fullName
                     email:(NSString*)email
                  password:(NSString*)password
           completionBlock:(void (^)(NSError *error, NSString *alert, BOOL finished))completionBlock {
    [NSThread sleepForTimeInterval:20];
    completionBlock(nil, @"Error Email", YES);
}



@end
