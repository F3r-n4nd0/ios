//
//  WDAddItemViewController.h
//  WallaDog
//
//  Created by Fernando Luna on 12/21/15.
//  Copyright © 2015 Dancing Queen. All rights reserved.
//
@import UIKit;

@class WDAddItemViewModel;

@interface WDAddItemViewController : UIViewController

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithAddItemViewModel:(WDAddItemViewModel *)addItemViewModel;

@end
