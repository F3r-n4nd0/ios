//
//  WDUIHelper.m
//  WallaDog
//
//  Created by Fernando Luna on 1/31/16.
//  Copyright © 2016 Dancing Queen. All rights reserved.
//
@import SCLAlertView_Objective_C;

#import "WDUIHelper.h"

@implementation WDUIHelper

+ (void)showWarningAlertWithTitle:(NSString *)title subTitle:(NSString *)subTitle {
    SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
    [alert showWarning:title
              subTitle:subTitle
      closeButtonTitle:@"Ok"
              duration:0.0f];
}

+ (void)showErrorAlertWithSubTitle:(NSString *)subTitle {
    SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
    [alert showError:@"Whoops"
            subTitle:subTitle
    closeButtonTitle:@"Ok"
            duration:0.0f];
}

+ (void)showInfoAlertWithTitle:(NSString *)title subTitle:(NSString *)subTitle {
    SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
    [alert showInfo:title
           subTitle:subTitle
   closeButtonTitle:@"Ok"
           duration:0.0f];
}

+ (void)showConfirmationAlerTitle:(NSString *)title subTitle:(NSString *)subTitle actionBlock:(void (^)())actionBlock {
    SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
    [alert addButton:@"Accept" actionBlock:actionBlock];
    [alert showQuestion:title
              subTitle:subTitle
    closeButtonTitle:@"Cancel"
            duration:0.0f];
}

+ (void)showSuccessAlertWithTitle:(NSString *)title subTitle:(NSString *)subTitle {
    SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
    [alert showSuccess:title
           subTitle:subTitle
   closeButtonTitle:@"Ok"
           duration:0.0f];
}

@end
