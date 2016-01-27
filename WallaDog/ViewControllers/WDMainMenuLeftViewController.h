//
//  WDMainMenuLeftViewController.h
//  WallaDog
//
//  Created by Fernando Luna on 12/6/15.
//  Copyright © 2015 Dancing Queen. All rights reserved.
//

@import UIKit;

@class WDMainViewModel;

@protocol WDMainMenuLeftViewControllerDelegate <NSObject>

- (void)selectMenuSection:(NSInteger)section;

@end

@interface WDMainMenuLeftViewController : UIViewController

@property (weak, nonatomic) id<WDMainMenuLeftViewControllerDelegate> delegate;

- (instancetype)init NS_UNAVAILABLE;
   - (instancetype)initWithMainViewModel:(WDMainViewModel*) mainViewModel;

@end
