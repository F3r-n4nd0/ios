//
//  WDImageProductView.h
//  WallaDog
//
//  Created by Fernando Luna on 1/26/16.
//  Copyright © 2016 Dancing Queen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WDImageProductView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;

+ (NSString*)nameXibIdentifier;

@end
