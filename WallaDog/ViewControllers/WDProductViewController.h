//
//  WDProductViewController.h
//  WallaDog
//
//  Created by Fernando Luna on 1/24/16.
//  Copyright © 2016 Dancing Queen. All rights reserved.
//

@import UIKit;
@import MapKit;

@class WDProductViewModel;

@interface WDProductViewController : UIViewController

- (instancetype) init NS_UNAVAILABLE;
- (instancetype)initWithProductViewModel:(WDProductViewModel*)productViewModel;

@end
