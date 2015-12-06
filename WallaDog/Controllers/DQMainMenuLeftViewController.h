//
//  DQMainMenuLeftViewController.h
//  WallaDog
//
//  Created by Fernando Luna on 12/6/15.
//  Copyright © 2015 Dancing Queen. All rights reserved.
//

@import UIKit;

@protocol DQMainMenuLeftViewControllerDelegate <NSObject>

- (void)selectMenuSection:(NSInteger)section;

@end

@interface DQMainMenuLeftViewController : UIViewController

@property (weak, nonatomic) id<DQMainMenuLeftViewControllerDelegate> delegate;


@end
