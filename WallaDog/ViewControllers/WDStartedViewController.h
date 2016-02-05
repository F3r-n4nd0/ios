//
//  WDStartedViewController.h
//  WallaDog
//
//  Created by Fernando Luna on 12/6/15.
//  Copyright © 2015 Dancing Queen. All rights reserved.
//
@import UIKit;

@class WDStartedViewModels;

@interface WDStartedViewController : UIViewController

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithStartedViewModels:(WDStartedViewModels*)startedViewModels;

@end
