//
//  WDUIHelper.h
//  WallaDog
//
//  Created by Fernando Luna on 1/31/16.
//  Copyright © 2016 Dancing Queen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WDUIHelper : NSObject

+ (void)showWarningAlertWithTitle:(NSString *)title subTitle:(NSString *)subTitle;
+ (void)showErrorAlertWithSubTitle:(NSString *)subTitle;
+ (void)showInfoAlertWithTitle:(NSString *)title subTitle:(NSString *)subTitle;
+ (void)showConfirmationAlerTitle:(NSString *)title subTitle:(NSString *)subTitle actionBlock:(void (^)())actionBlock;
+ (void)showSuccessAlertWithTitle:(NSString *)title subTitle:(NSString *)subTitle;

@end
