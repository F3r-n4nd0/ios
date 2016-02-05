//
//  WDMainMenuLeftViewController.h
//  WallaDog
//
//  Created by Fernando Luna on 12/6/15.
//  Copyright © 2015 Dancing Queen. All rights reserved.
//

@import UIKit;

@class WDMainViewModel;

@interface WDMainMenuLeftViewController : UIViewController

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithMainViewModel:(WDMainViewModel*) mainViewModel;

- (void)updateCurrentUser;

@end
