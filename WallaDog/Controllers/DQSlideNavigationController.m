//
//  DQSlideNavigationController.m
//  WallaDog
//
//  Created by Fernando Luna on 12/6/15.
//  Copyright © 2015 Dancing Queen. All rights reserved.
//

#import "DQSlideNavigationController.h"

@interface DQSlideNavigationController ()

@end

@implementation DQSlideNavigationController

-(instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    self = [super initWithRootViewController:rootViewController];
    if(self) {
        [self.navigationBar setBarTintColor:[UIColor colorWithRed:0.383 green:0.652 blue:0.89 alpha:1]];
        [self.navigationBar setTintColor:[UIColor whiteColor]];
    }
    return self;
}

- (BOOL)shouldAutorotate
{
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

@end
