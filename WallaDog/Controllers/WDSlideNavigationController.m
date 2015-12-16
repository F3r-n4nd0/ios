//
//  WDSlideNavigationController.m
//  WallaDog
//
//  Created by Fernando Luna on 12/6/15.
//  Copyright © 2015 Dancing Queen. All rights reserved.
//

#import "WDSlideNavigationController.h"
#import "UIColor+WDColorsDefault.h"

@interface WDSlideNavigationController ()

@end

@implementation WDSlideNavigationController

-(instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    self = [super initWithRootViewController:rootViewController];
    if(self) {
        [self.navigationBar setTranslucent:NO];
        [self.navigationBar setBarTintColor:[UIColor colorPrimary]];
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
